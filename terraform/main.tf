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
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_id    = azurerm_storage_account.zoomcamp.id
  container_access_type = "private"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "synapse" {
  name               = "synapse"
  storage_account_id = azurerm_storage_account.zoomcamp.id
}


resource "azurerm_synapse_workspace" "zoomcamp" {
  name                                 = "synapse-zoomcamp-de"
  resource_group_name                  = azurerm_resource_group.zoomcamp.name
  location                             = azurerm_resource_group.zoomcamp.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.synapse.id

  identity {
    type = "SystemAssigned"
  }

  sql_administrator_login          = "synapseadmin"
  sql_administrator_login_password = var.synapse_sql_admin_password
}


