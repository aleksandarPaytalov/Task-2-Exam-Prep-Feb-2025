terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.39.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "alex-watchlist-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "alex-watchlist-sp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.alex-watchlist-rg.name
  location            = azurerm_resource_group.alex-watchlist-rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "alex-watchlist-web-app" {
  name                = var.web_app_name
  resource_group_name = azurerm_resource_group.alex-watchlist-rg.name
  location            = azurerm_service_plan.alex-watchlist-sp.location
  service_plan_id     = azurerm_service_plan.alex-watchlist-sp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLServer"
    value = "Server=${azurerm_mssql_server.alex-watchlist-mssql-server.fully_qualified_domain_name};Initial Catalog=${azurerm_mssql_database.alex-watchlist-mssql-database.name};User Id=${azurerm_mssql_server.alex-watchlist-mssql-server.administrator_login};Password=${azurerm_mssql_server.alex-watchlist-mssql-server.administrator_login_password};Trusted_Connection=False; MultipleActiveResultSets=True;"
  }
}

resource "azurerm_mssql_server" "alex-watchlist-mssql-server" {
    name = var.mssql_server_name
    resource_group_name = azurerm_resource_group.alex-watchlist-rg.name
    location = azurerm_resource_group.alex-watchlist-rg.location
    version = "12.0"
    administrator_login = var.mssql_administrator_login
    administrator_login_password = var.mssql_administrator_login_password
}

resource "azurerm_mssql_database" "alex-watchlist-mssql-database" {
    name = var.mssql_database_name
    server_id = azurerm_mssql_server.alex-watchlist-mssql-server.id
    collation = "SQL_Latin1_General_CP1_CI_AS"
    max_size_gb = 2
    sku_name = "S0"
    zone_redundant = false
    license_type = "LicenseIncluded"
}

resource "azurerm_app_service_source_control" "alex-watchlist-app-service-source-control" {
  app_id   = azurerm_linux_web_app.alex-watchlist-web-app.id
  repo_url = var.repo_url
  branch   = "main"
}

resource "azurerm_mssql_firewall_rule" "alex-watchlist-mssql-firewall-rule" {
  name             = ""
  server_id        = azurerm_mssql_server.alex-watchlist-mssql-server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
