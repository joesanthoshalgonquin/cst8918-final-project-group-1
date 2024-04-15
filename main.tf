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

  backend "azurerm" {
    resource_group_name  = "sant0232-final-project-rg"
    storage_account_name = "sant0232finalprojstorage"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
    use_oidc             = true
  }
}
module "network" {
  source = "./network"
}

module "akscluster" {
  source = "./akscluster"
}

module "remix" {
  source = "./remix"
}
