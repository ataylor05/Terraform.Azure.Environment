# Environment
variable "region" {
    default = "East US"
}
variable "aks_rg_name" {
    default = "ataylor-aks"
}
variable "aks_vnet_name" {
    default = "ataylor-vnet"
}
variable "network_rg_name" {
    default = "ataylor-network"
}

# AKS 
variable "k8s_version" {
    default = "1.17.7"
}
variable "cluster_name" {
    default = "demo-build-cluster-01"
}
variable "cluster_node_count" {
    default = "1"
}
variable "cluster_max_pod_count" {
    default = "30"
}
variable "cluster_node_vm_size" {
    default = "Standard_B2Ms"
}
variable "cluster_node_vm_disk_size" {
    default = 100
}

# Authentication
variable "linux_node_admin_username" {
    default = "humana"
}
variable "linux_node_admin_ssh_pub_key" {
    default = "#{aks-linux-node-admin-ssh-pub-key}#"
}
variable "service_principal_id" {
    default = "#{aks-service-principal-id}#"
}
variable "service_principal_secret" {
    default = "#{aks-service-principal-secret}#"
}

# Cluster Networking
variable "network_policy" {
    default = "calico"
}
variable "aks_docker_bridge_cidr" {
    default = "192.168.0.10/20"
}
variable "aks_service_cidr" {
    default = "192.168.16.0/20"
}
variable "aks_pod_cidr" {
    default = "192.168.32.0/20"
}
variable "aks_dns_service_ip" {
    default = "192.168.16.10"
}

# Monitoring
variable "log_analytics_workspace" {
  default = "ataylor05-aks-monitor-workspace"
}