data "oci_core_vnic_attachments" "todo_server" {
  compartment_id = var.compartment_ocid
  instance_id    = oci_core_instance.todo_server.id
}

data "oci_core_vnic" "todo_server" {
  vnic_id = data.oci_core_vnic_attachments.todo_server.vnic_attachments[0].vnic_id
}

output "public_ip" {
  description = "Public IP address"
  value       = data.oci_core_vnic.todo_server.public_ip_address   # добавлено _address
}

output "private_ip" {
  description = "Private IP address"
  value       = data.oci_core_vnic.todo_server.private_ip_address  # добавлено _address
}


output "instance_ocid" {
  description = "Instance OCID"
  value       = oci_core_instance.todo_server.id
}