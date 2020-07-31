resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.vnet_cidr]
  location            = var.region
  resource_group_name = var.network_rg_name
}

resource "azurerm_subnet" "web_sn" {
  name                 = var.web_subnet_name
  resource_group_name  = var.network_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.web_subnet_cidr]
}

resource "azurerm_subnet" "sql_sn" {
  name                 = var.sql_subnet_name
  resource_group_name  = var.network_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.sql_subnet_cidr]
}

resource "azurerm_subnet" "aks_sn" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.network_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.aks_subnet_cidr]
}

resource "azurerm_subnet" "vpn_sn" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.network_rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vpn_subnet_cidr]
}

resource "azurerm_route_table" "route_table" {
  name                          = "${var.prefix}-route-table"
  location                      = var.region
  resource_group_name           = var.network_rg_name
  disable_bgp_route_propagation = false

  route {
    name           = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  route {
    name           = "vnet"
    address_prefix = azurerm_virtual_network.vnet.address_space[0]
    next_hop_type  = "vnetlocal"
  }
}

resource "azurerm_subnet_route_table_association" "web_subnet_route" {
  subnet_id      = azurerm_subnet.web_sn.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_subnet_route_table_association" "sql_subnet_route" {
  subnet_id      = azurerm_subnet.sql_sn.id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_subnet_route_table_association" "aks_subnet_route" {
  subnet_id      = azurerm_subnet.aks_sn.id
  route_table_id = azurerm_route_table.route_table.id
}