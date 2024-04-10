provider "azurerm" {
  features {}
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "acrfinalproj"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canada-central"
  sku                 = "Basic"
}

# AKS Clusters
resource "azurerm_kubernetes_cluster" "aks_test" {
  name                = "aks_test_cluster"
  location            = "canada-central"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "aks-test-cluster-dns"

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

resource "azurerm_kubernetes_cluster" "aks_prod" {
  name                = "aks_prod_cluster"
  location            = "canada-central"
  resource_group_name = "cst8918-final-project-group-1"
  dns_prefix          = "aks-prod-cluster-dns"

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

# Redis Cache
resource "azurerm_redis_cache" "redis_test" {
  name                = "test_db"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canada-central"
  sku_name            = "Standard"
  capacity            = 1
  family              = "C"
}

resource "azurerm_redis_cache" "redis_prod" {
  name                = "prod_db"
  resource_group_name = "cst8918-final-project-group-1"
  location            = "canada-central"
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
