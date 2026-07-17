data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "ubuntu" {
  compartment_id           = var.compartment_ocid
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
  shape                    = "VM.Standard.A1.Flex"

  sort_by    = "TIMECREATED"
  sort_order = "DESC"
}

resource "oci_core_instance" "todo_server" {

  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  compartment_id = var.compartment_ocid

  display_name = "todo-server"

  shape = "VM.Standard.A2.Flex"

  shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu.images[0].id
    boot_volume_size_in_gbs = 50
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public.id
    assign_public_ip = true
    display_name     = "todo-vnic"
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
}