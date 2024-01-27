resource "azurerm_virtual_network" "aks" {
  name                = "vnet-aks-${local.prefix}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  tags                = local.tags
}

resource "azurerm_subnet" "aks_node" {
  name                 = "snet-aks-node-${local.prefix}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = var.node_subnet_address_prefixes
}
resource "azurerm_subnet" "aks_api" {
  name                 = "snet-aks-api-${local.prefix}"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = var.api_subnet_address_prefixes
  delegation {

    name = "aks-api-access-profile"
    service_delegation {
      name = "Microsoft.ContainerService/managedClusters"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

## Use a domain what you own.
## Public DNS Zone, configure forwarders for this sub-domain or root domain to the nameservers from this DNS zone on your domain registrar
resource "azurerm_dns_zone" "stage_learndevops_in" {
  name                = var.dns_zone_name ## replace this value with a domain what you own.
  resource_group_name = azurerm_resource_group.aks.name
  tags                = local.tags
}
