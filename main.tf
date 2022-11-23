resource "azurerm_resource_group" "testRG" {
    name = "${terraform.workspace}-RG"
    location = local.rg_location
  
}

resource "azurerm_virtual_network" "testVNet" {
    name = "${terraform.workspace}-VNet"
    address_space = [ "10.20.0.0/16" ]
    resource_group_name = azurerm_resource_group.testRG.name
    location = local.rg_location

    depends_on = [
      azurerm_resource_group.testRG
    ]
  
}

resource "azurerm_subnet" "testSubnet" {
    name = "${terraform.workspace}-Subnet"
    resource_group_name = azurerm_resource_group.testRG.name
    virtual_network_name = azurerm_virtual_network.testVNet.name
    address_prefixes = ["10.20.1.0/24"]

    depends_on = [
      azurerm_virtual_network.testVNet,
      azurerm_resource_group.testRG
    ]
  
}