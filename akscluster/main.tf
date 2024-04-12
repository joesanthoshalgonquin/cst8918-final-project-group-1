provider "azurerm" {
  features {}
}


resource "azurerm_kubernetes_cluster" "test_cluster" {
  name                = "test-cluster"
  location            = "canadacentral"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "test-cluster"

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = "Standard_B2s"
    orchestrator_version = "1.29.2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_policy = "azure"
    network_plugin = "azure"
  }

  api_server_access_profile {
    authorized_ip_ranges = ["10.0.0.0/14"]
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
}


resource "azurerm_kubernetes_cluster" "prod_cluster" {
  name                = "prod-cluster"
  location            = "canadacentral"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "prod-cluster"

  default_node_pool {
    name                 = "default"
    node_count           = 1
    vm_size              = "Standard_B2s"
    orchestrator_version = "1.29.2"
    enable_auto_scaling  = true
    min_count            = 1
    max_count            = 3
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_policy = "azure"
    network_plugin = "azure"
  }

  api_server_access_profile {
    authorized_ip_ranges = ["10.0.0.0/14"]
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
}

