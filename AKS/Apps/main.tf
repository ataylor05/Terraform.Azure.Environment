data "azurerm_subnet" "aks_sn" {
  name                 = "AKS-01"
  virtual_network_name = var.aks_vnet_name
  resource_group_name  = var.network_rg_name
}

resource "azurerm_log_analytics_workspace" "aks_monitors" {
    name                = var.log_analytics_workspace
    location            = var.region
    resource_group_name = var.aks_rg_name
    sku                 = "PerGB2018"
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = var.region
    resource_group_name = var.aks_rg_name
    dns_prefix          = "${var.cluster_name}-dns"
    kubernetes_version  = var.k8s_version

    linux_profile {
        admin_username = var.linux_node_admin_username
        ssh_key {
            key_data = var.linux_node_admin_ssh_pub_key
        }
    }

    network_profile {
        network_plugin     = "kubenet"
        network_policy     = var.network_policy
        docker_bridge_cidr = var.aks_docker_bridge_cidr
        service_cidr       = var.aks_service_cidr
        pod_cidr           = var.aks_pod_cidr
        dns_service_ip     = var.aks_dns_service_ip
        load_balancer_sku  = "standard"
    }

    default_node_pool {
        name                = "linux"
        node_count          = var.cluster_node_count
        max_pods            = var.cluster_max_pod_count
        vm_size             = var.cluster_node_vm_size
        os_disk_size_gb     = var.cluster_node_vm_disk_size
        vnet_subnet_id      = data.azurerm_subnet.aks_sn.id
    }

    service_principal {
        client_id     = var.service_principal_id
        client_secret = var.service_principal_secret
    }

    addon_profile {
      oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_monitors.id
      }
    }
}