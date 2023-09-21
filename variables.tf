variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "web_subnet_name" {
  type = string
}

variable "data_subnet_name" {
  type = string
}


variable "web_address_subnet_prefixes" {
  type = list(string)
}

variable "data_address_subnet_prefixes" {
  type = list(string)
}


variable "mysql_resource_id" {
  type = string
}



variable "storage_account_id" {
  type = string
}

variable "storage_account_name1" {
  type = string
  default ="storage"
}

variable "storage_account_name2" {
  type = string
  default = "stac_webapp"
}










variable "storage_account_name" {
  type = string
}

variable "data_address_subnet_prefixes" {
  type = list(string)
}

variable "data_subnet_name" {
  type = string
}

variable "web_address_prefixes" {
  type = list(string)
}

variable "azurerm_subnet_name" {
  type = string
}

variable "azurerm_subnet_address_prefixes" {
  type = list(string)
}

variable "appgw_subnet_name" {
  type = string
}