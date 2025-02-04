resource "azurerm_resource_group" "rg" {
  name     = "my-resource-group"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "my-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "App"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "web_app" {
  name                = "my-java-web-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    java_version = "1.8"
    java_container = "TOMCAT"
    java_container_version = "9.0"
  }

  app_settings = {
    "JAVA_OPTS" = "-Xms512m -Xmx1024m"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "mystorageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "appsource"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

