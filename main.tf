resource "azurerm_resource_group" "project_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}

resource "azurerm_container_group" "web_app" {
  name                = var.container_group_name
  location            = azurerm_resource_group.project_rg.location
  resource_group_name = azurerm_resource_group.project_rg.name

  ip_address_type = "Public"
  dns_name_label  = var.dns_name_label
  os_type         = "Linux"

  container {
    name   = "cloudscale-web-app"
    image  = var.docker_image
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    Project     = "Project2"
    Environment = "production"
    StudentName = var.student_name
  }
}