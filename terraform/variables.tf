variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "towels_shop"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "westus2"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "towelsacr"
}

variable "app_service_plan_name" {
  default = "towels_app_service"
}

variable "frontend_app_service_name" {
  default = "towelshop"
}

