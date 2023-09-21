## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_service_plan.app_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_storage_account.stac_webapp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_share.shares](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_DOCKER_REGISTRY_SERVER_PASSWORD"></a> [DOCKER\_REGISTRY\_SERVER\_PASSWORD](#input\_DOCKER\_REGISTRY\_SERVER\_PASSWORD) | n/a | `string` | n/a | yes |
| <a name="input_DOCKER_REGISTRY_SERVER_URL"></a> [DOCKER\_REGISTRY\_SERVER\_URL](#input\_DOCKER\_REGISTRY\_SERVER\_URL) | n/a | `string` | n/a | yes |
| <a name="input_DOCKER_REGISTRY_SERVER_USERNAME"></a> [DOCKER\_REGISTRY\_SERVER\_USERNAME](#input\_DOCKER\_REGISTRY\_SERVER\_USERNAME) | n/a | `string` | n/a | yes |
| <a name="input_DOCUMENTROOT"></a> [DOCUMENTROOT](#input\_DOCUMENTROOT) | n/a | `string` | n/a | yes |
| <a name="input_DRUPAL_SITE_NAME"></a> [DRUPAL\_SITE\_NAME](#input\_DRUPAL\_SITE\_NAME) | n/a | `string` | n/a | yes |
| <a name="input_SERVERALIAS"></a> [SERVERALIAS](#input\_SERVERALIAS) | n/a | `string` | n/a | yes |
| <a name="input_SERVERNAME"></a> [SERVERNAME](#input\_SERVERNAME) | n/a | `string` | n/a | yes |
| <a name="input_WEBSITES_PORT"></a> [WEBSITES\_PORT](#input\_WEBSITES\_PORT) | n/a | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_docker_image_name"></a> [docker\_image\_name](#input\_docker\_image\_name) | n/a | `string` | n/a | yes |
| <a name="input_docker_image_tag_name"></a> [docker\_image\_tag\_name](#input\_docker\_image\_tag\_name) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_mount_path"></a> [mount\_path](#input\_mount\_path) | n/a | `string` | n/a | yes |
| <a name="input_nameshare"></a> [nameshare](#input\_nameshare) | n/a | `string` | n/a | yes |
| <a name="input_pp_service_plan_name"></a> [pp\_service\_plan\_name](#input\_pp\_service\_plan\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_share_name"></a> [share\_name](#input\_share\_name) | n/a | `string` | n/a | yes |
| <a name="input_stac_webapp_name"></a> [stac\_webapp\_name](#input\_stac\_webapp\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
