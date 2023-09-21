resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  #reserved            =zz
  sku_name = "P2v2"
}

resource "azurerm_linux_web_app" "app" {
  name                      = var.app_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  service_plan_id           = azurerm_service_plan.app_service_plan.id
  virtual_network_subnet_id = azurerm_subnet.web_subnet.id
  client_affinity_enabled   = true

  #app_settings = {
  # DRUPAL_image       = "cnrgacr.azurecr.io/drupal"
  # DRUPAL_image_tag = "latest"
  #}


  identity {
    type         = "SystemAssigned"
    identity_ids = []

  }
  #app_settings = {

  # "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  # }

  site_config {
    always_on                               = true
    scm_minimum_tls_version                 = "1.2"
    ftps_state                              = "FtpsOnly"
    use_32_bit_worker                       = false
    container_registry_use_managed_identity = true
    # container_registry_managed_identity_client_id = azurerm_linux_web_app.app.identity.0.principal_id

    application_stack {
      docker_image     = var.docker_image_name
      docker_image_tag = var.docker_image_tag_name
    }
  }
  app_settings = {

    MYSQL_DATABASE   = azurerm_mysql_database.database.name
    MYSQL_USERNAME   = "${azurerm_mysql_server.mysql.administrator_login}@${azurerm_mysql_server.mysql.name}"
    MYSQL_PASSWORD   = azurerm_mysql_server.mysql.administrator_login_password
    MYSQL_HOST       = azurerm_mysql_server.mysql.fqdn
    DRUPAL_SITE_NAME = var.DRUPAL_SITE_NAME

    REDIS_HOSTNAME   = "${azurerm_private_dns_a_record.redisrecord.fqdn}"
    REDIS_PORT       = "${azurerm_redis_cache.redis.port}"
    REDIS_PASSWORD   = "${azurerm_redis_cache.redis.primary_access_key}"

    DOCKER_REGISTRY_SERVER_URL      = var.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME = var.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD = var.DOCKER_REGISTRY_SERVER_PASSWORD
    SERVERALIAS                     = var.SERVERALIAS
    SERVERNAME                      = var.SERVERNAME
    WEBSITES_PORT                   = var.WEBSITES_PORT
    DOCUMENTROOT                    = var.DOCUMENTROOT
  }


  storage_account {
    access_key   = azurerm_storage_account.stac_webapp.primary_access_key
    account_name = azurerm_storage_account.stac_webapp.name
    name         = var.nameshare
    share_name   = var.share_name
    type         = "AzureFiles"
    mount_path   = var.mount_path

  }

}

resource "azurerm_storage_account" "stac_webapp" {
  name                             = var.stac_webapp_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  is_hns_enabled                   = true
  account_tier                     = "Standard"
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = true
  min_tls_version                  = "TLS1_2"
  account_replication_type         = "LRS"
  network_rules {
    default_action = "Allow"
  }
}

resource "azurerm_storage_share" "shares" {
  name                 = var.share_name
  storage_account_name = azurerm_storage_account.stac_webapp.name
  quota                = 100
  access_tier          = "TransactionOptimized"
  enabled_protocol     = "SMB"
}


