resource "azurerm_resource_group" "rg" {
  name     = "azure-ResourceGroup"
  location = "Central India"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "azure-webapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "B1"
}

# resource "azurerm_linux_web_app" "webapp" {
#   name                = "azure-webapp-akshay-test"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   service_plan_id     = azurerm_service_plan.appserviceplan.id
#   depends_on          = [azurerm_service_plan.appserviceplan]
#   https_only          = true
#
#   site_config {
#     minimum_tls_version = "1.2"
#     application_stack {
#       java_version        = "11"
#       java_server         = "TOMCAT"
#       java_server_version = "9.0"
#     }
#   }
#
#   app_settings = {
#     "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
#   }
# }


# resource "azurerm_resource_group" "example" {
#   name     = "${var.prefix}-resources"
#   location = var.location
# }
#
# resource "azurerm_service_plan" "example" {
#   name                = "${var.prefix}-sp"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   os_type             = "Windows"
#   sku_name            = "B1"
# }

resource "azurerm_windows_web_app" "web-app" {
  name                = "java-akshay-basic-example"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {
    application_stack {
      current_stack          = "java"
      java_version           = "11"
      java_container         = "JAVA"
      java_container_version = "SE"
    }
  }
}