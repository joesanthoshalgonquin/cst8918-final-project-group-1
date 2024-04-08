provider "azurerm" {
  features {}
}


resource "azurerm_kubernetes_cluster" "test_cluster" {
  name                = "test-cluster"
  location            = "canada-central"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "test-cluster"

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = "Standard_B2s"
    orchestrator_version = "1.21.2"
  }

 identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_kubernetes_cluster" "prod_cluster" {
  name                = "prod-cluster"
  location            = "canada-central"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "prod-cluster"

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = "Standard_B2s"
    orchestrator_version = "1.21.2"
     min_count   = 1
    max_count   = 3
  }

   identity {
    type = "SystemAssigned"
  }
}

