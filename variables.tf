variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "sabreen-ritaj-rahaf-proj2-aci-rg"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "swedencentral"
}

variable "container_group_name" {
  description = "Name of the Azure Container Instance"
  type        = string
  default     = "sabreen-ritaj-rahaf-proj2-aci"
}

variable "dns_name_label" {
  description = "DNS label for the Azure Container Instance"
  type        = string
  default     = "sabreen-ritaj-rahaf-project2"
}

variable "docker_image" {
  description = "Docker Hub image used by Azure Container Instance"
  type        = string
  default     = "rahafmohammed1/cloudscale-project2:v2"
}

variable "student_name" {
  description = "Student or team name used in Azure tags"
  type        = string
  default     = "Sabreen-Ritaj-Rahaf"
}