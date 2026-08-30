terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.0"
        }
    }

    required_version = ">= 1.5.0"

}


provider "azurerm" {
    features {}
    
}

resource "azurerm_resource_group" "zoomcamp" {
    name = "rg-zoomcamp-de"
    location = "centralindia"
}

