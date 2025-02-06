resource "azurerm_resource_group" "rg" {
  name     = "azure-ResourceGroup"
  location = "Central India"
}

resource "azurerm_service_plan" "appserviceplan" {
  name                = "azure-webapp-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "azure-webapp-test-akshay"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  depends_on          = [azurerm_service_plan.appserviceplan]
  https_only          = true
  site_config {
    minimum_tls_version = "1.2"

    application_stack {
      java_version        = "11"
      java_server         = "TOMCAT"
      java_server_version = "9.0"
    }
  }

  app_settings = {
    "JAVA_HOME"                           = "/usr/lib/jvm/java-11-openjdk"
    "MAVEN_HOME"                          = "/usr/share/maven"
    "MAVEN_OPTS"                          = "-Xms512m -Xmx1024m"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}