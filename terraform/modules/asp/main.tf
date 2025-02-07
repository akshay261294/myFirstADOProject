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

resource "azurerm_windows_web_app" "web-app" {
  name                = "java-akshay-basic-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id

  site_config {
    application_stack {
      current_stack          = "java"
      java_version           = "21"
    }
  }
}