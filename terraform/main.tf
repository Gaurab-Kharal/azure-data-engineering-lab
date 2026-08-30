terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.5.0"

}


provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "zoomcamp" {
  name     = "rg-zoomcamp-de"
  location = "centralindia"
}

resource "azurerm_storage_account" "zoomcamp" {
  name                     = "zoomcampde2026"
  resource_group_name      = azurerm_resource_group.zoomcamp.name
  location                 = azurerm_resource_group.zoomcamp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "raw" {
  name                   = "raw"
  storage_account_id     = azurerm_storage_account.zoomcamp.id
  container_access_type = "private"
}