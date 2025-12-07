output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_windows_virtual_machine.this.id
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.this.ip_address
}

output "network_interface_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "Private IP address"
  value       = azurerm_network_interface.this.private_ip_address
}