variable "prefix" {
  default = "ataylor"
}

variable "region" {
    default = "East US"
}

variable "network_rg_name" {
  default = "ataylor-network"
}

variable "vnet_cidr" {
    default = "10.0.0.0/16"
}

variable "web_subnet_name" {
    default = "Web-01"
}

variable "web_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "sql_subnet_name" {
    default = "SQL-01"
}

variable "sql_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "aks_subnet_name" {
    default = "AKS-01"
}

variable "aks_subnet_cidr" {
    default = "10.0.2.0/24"
}

variable "vpn_subnet_cidr" {
    default = "10.0.254.0/24"
}