##################################################################################
#                              Vnet & Subnets                                    #
##################################################################################
resource "azurerm_virtual_network" "Vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "data_subnet" {
  name                 = var.data_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.data_address_subnet_prefixes
}

resource "azurerm_subnet" "web_subnet" {
  name                 = var.web_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = var.web_address_subnet_prefixes
}


##################################################################################
#                               Private Endpoints                                #
#################################################################################


// Private Endpoint mysql
resource "azurerm_private_dns_zone" "pv_dns" {
name                = "mysql.database.azure.com"
resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "mysql-endpoint" {
  name                = "mysql-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.data_subnet.id

  private_service_connection {
    name                           = "mysql-pc"
    private_connection_resource_id = var.mysql_resource_id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                  = "default"
     private_dns_zone_ids  = [azurerm_private_dns_zone.pv_dns.id]
   }
}


//DNS Zones
resource "azurerm_private_dns_zone" "pv_st1_dns" {
  name                = "file.core.windows.net"
  resource_group_name = var.resource_group_name
}

// Private Endpoint storage
resource "azurerm_private_endpoint" "storage-endpoint" {
  name                = "stc1-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.data_subnet.id
  private_service_connection {
    name                           = "storage-pc2"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                  = "default"
     private_dns_zone_ids  = [azurerm_private_dns_zone.pv_st1_dns.id]
   }
}

//DNS Zones
resource "azurerm_private_dns_zone" "pv_st2_dns" {
  name                = "blob.core.windows.net"
  resource_group_name = var.resource_group_name
}
// Private Endpoint storage
resource "azurerm_private_endpoint" "storage-endpoint2" {
  name                = "stc2-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.data_subnet.id
  private_service_connection {
    name                           = "storage-pc2"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                  = "default"
     private_dns_zone_ids  = [azurerm_private_dns_zone.pv_st2_dns.id]
   }

}




# Create a Private DNS to VNET link
resource "azurerm_private_dns_zone_virtual_network_link" "dns-zone-to-vnet-link" {
  name                  = "vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pv_dns.name
  virtual_network_id    = azurerm_virtual_network.Vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "st1-dns-zone-to-vnet-link" {
  name                  = "st1-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pv_st_dns.name
  virtual_network_id    = azurerm_virtual_network.Vnet.id
}


resource "azurerm_private_dns_a_record" "st1filerecord" {
  name                = var.storage_account1_name
  zone_name           = azurerm_private_dns_zone.pv_st_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage-endpoint.private_service_connection[0].private_ip_address]
}

resource "azurerm_private_dns_zone_virtual_network_link" "st2-dns-zone-to-vnet-link" {
  name                  = "st2-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.pv_st2_dns.name
  virtual_network_id    = azurerm_virtual_network.Vnet.id
}


resource "azurerm_private_dns_a_record" "st2filerecord" {
  name                = var.storage_account2_name
  zone_name           = azurerm_private_dns_zone.pv_st2_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage-endpoint.private_service_connection[0].private_ip_address]
}
