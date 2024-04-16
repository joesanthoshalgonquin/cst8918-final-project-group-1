
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


resource "azurerm_resource_group" "network" {
  name     = "cst8918-final-project-group-${var.group_number}"
  location = "canadacentral" # Set your desired Azure region
}

resource "azurerm_virtual_network" "main" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/14"]
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name
}


# Create subnets
resource "azurerm_subnet" "prod" {
  name                 = "prodsubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.network.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "test" {
  name                 = "testsubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.network.name
  address_prefixes     = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "dev" {
  name                 = "devsubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.network.name
  address_prefixes     = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "admin" {
  name                 = "adminsubnet"
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = azurerm_resource_group.network.name
  address_prefixes     = ["10.3.0.0/16"]
}
