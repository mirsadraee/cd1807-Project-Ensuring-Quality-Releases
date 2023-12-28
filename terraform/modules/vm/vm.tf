resource "azurerm_network_interface" "" {
  name                = "${var.resource_type}-${var.application_type}"
  location            = "westeurope"
  resource_group_name = "Azuredevops"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

resource "azurerm_linux_virtual_machine" "" {
  name                = "myApplicationVM"
  location            = "westeurope"
  resource_group_name = "Azuredevops"
  size                = "Standard_DS2_v2"
  admin_username      = ""
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "alireza"
    public_key = "file("~/.ssh/id_rsa.pub")"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
