provider "azurerm" {
  features {}
  subscription_id = "#{Tenant-Subscription}#"
  client_id       = "#{Terraform-SP-Client-Id}#"
  client_secret   = "#{Terraform-SP-Client-Secret}#"
  tenant_id       = "#{Tenant-Id}#"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "ataylorterraform"
    storage_account_name = "#{Terraform-SA-Name}#"
    container_name       = "tfstate"
    key                  = "common.terraform.tfstate"
    access_key           = "#{Terraform-SA-Key}#"
  }
}