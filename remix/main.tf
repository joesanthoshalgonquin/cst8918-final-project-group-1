provider "azurerm" {
  features {}
  use_oidc = true
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "acrfinalproj"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canadacentral"
  sku                 = "Basic"
}

output "acr_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
}

# AKS Clusters
resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks_test_cluster"
  location            = "canadacentral"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "aks-test-cluster-dns"

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

  api_server_authorized_ip_ranges = ["10.0.0.0/14"]

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
}

resource "azurerm_kubernetes_cluster" "aks_prod" {
  name                = "aks_prod_cluster"
  location            = "canadacentral"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "aks-prod-cluster-dns"

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

  api_server_authorized_ip_ranges = ["10.0.0.0/14"]

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }
}

# Redis Cache
resource "azurerm_redis_cache" "redis_test" {
  name                = "redistestdb"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canadacentral"
  sku_name            = "Standard"
  capacity            = 1
  family              = "C"
}

resource "azurerm_redis_cache" "redis_prod" {
  name                = "proddb"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canadacentral"
  sku_name            = "Standard"
  capacity            = 1
  family              = "C"
}

# Kubernetes Deployment and Service
resource "kubernetes_deployment" "remix_weather" {
  metadata {
    name = "remix-weather"
    labels = {
      app = "remix-weather"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "remix-weather"
      }
    }

    template {
      metadata {
        labels = {
          app = "remix-weather"
        }
      }

      spec {
        container {
          image = "joesanthosh/cst8918-a01-weather-app:latest"
          name  = "remix-weather"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "remix_weather_service" {
  metadata {
    name = "remix-weather-service"
  }

  spec {
    selector = {
      app = "remix-weather"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}
