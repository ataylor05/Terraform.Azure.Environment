resource "azurerm_resource_group" "network_rg" {
  name     = "${var.prefix}-network"
  location = var.region
}

resource "azurerm_resource_group" "security_rg" {
  name     = "${var.prefix}-security"
  location = var.region
}

resource "azurerm_resource_group" "backup_rg" {
  name     = "${var.prefix}-backup"
  location = var.region
}

resource "azurerm_resource_group" "web_rg" {
  name     = "${var.prefix}-web"
  location = var.region
}

resource "azurerm_resource_group" "sql_rg" {
  name     = "${var.prefix}-sql"
  location = var.region
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.prefix}-aks"
  location = var.region
}

resource "azurerm_storage_account" "diag_storage_account" {
    name                        = var.boot_diag_sa_name
    resource_group_name         = azurerm_resource_group.security_rg.name
    location                    = var.region
    account_replication_type    = "LRS"
    account_tier                = "Standard"
}

resource "azurerm_storage_account" "backups_account" {
    name                        = var.backups_sa_name
    resource_group_name         = azurerm_resource_group.backup_rg.name
    location                    = var.region
    account_replication_type    = "LRS"
    account_tier                = "Standard"
}

resource "azurerm_container_registry" "acr" {
  name                     = "${var.prefix}registry"
  resource_group_name      = azurerm_resource_group.aks_rg.name
  location                 = var.region
  sku                      = "Standard"
  admin_enabled            = false
}