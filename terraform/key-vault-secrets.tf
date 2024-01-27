resource "azurerm_key_vault" "aks" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.aks.location
  resource_group_name        = azurerm_resource_group.aks.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  enable_rbac_authorization  = true
}

resource "azurerm_role_assignment" "kv_rbac" {
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_key_vault.aks.id
  role_definition_name = "Key Vault Administrator"
}
