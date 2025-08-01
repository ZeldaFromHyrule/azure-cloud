# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.31.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "61edce70-81b3-4cbd-9659-6a5132989c1d"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_service_plan" "linux_plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "frontend" {
  name                = var.frontend_app_service_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.linux_plan.location
  service_plan_id     = azurerm_service_plan.linux_plan.id

   app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  https_only = false

  site_config {
    
    always_on                 = true
    ftps_state                = "AllAllowed"
   
    application_stack {
      docker_image_name = "mcr.microsoft.com/appsvc/staticsite:latest"
    }
  }
}

