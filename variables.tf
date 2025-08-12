variable "subscription_id" {
  description = "The subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the service plan"
  type        = string
}

variable "web_app_name" {
  description = "The name of the web app"
  type        = string
}

variable "mssql_server_name" {
  description = "The name of the MSSQL Server"
  type        = string
}

variable "mssql_database_name" {
  description = "The name of the MSSQL Database"
  type        = string
}

variable "mssql_administrator_login" {
  description = "The administrator login for the MSSQL Server"
  type        = string
}

variable "mssql_administrator_login_password" {
  description = "The administrator login password for the MSSQL Server"
  type        = string
}

variable "mssql_firewall_rule_name" {
  description = "The name of the MSSQL Firewall Rule"
  type        = string
}

variable "repo_url" {
  description = "The URL of the repository"
  type        = string
}
