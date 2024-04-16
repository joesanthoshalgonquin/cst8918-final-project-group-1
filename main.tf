provider "azurerm" {
  features {}
  use_oidc = true
}

terraform {
  required_version = "~> 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
}
module "network" {
  source = "./network"
}

module "backend" {
  source = "./backend"
}

module "remix" {
  source = "./remix"

  dev_subnet_id   = module.network.dev_subnet_id
  prod_subnet_id  = module.network.prod_subnet_id
  test_subnet_id  = module.network.test_subnet_id
  admin_subnet_id = module.network.admin_subnet_id
}
