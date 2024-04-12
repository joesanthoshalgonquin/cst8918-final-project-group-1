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

module "backend" {
  source = "./backend"
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
