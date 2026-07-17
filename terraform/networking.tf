resource "oci_core_subnet" "public" {

  compartment_id = var.compartment_ocid

  vcn_id = oci_core_vcn.main.id

  display_name = "public-subnet"

  cidr_block = "10.0.1.0/24"

  route_table_id = oci_core_route_table.main.id

  security_list_ids = [
    oci_core_security_list.main.id
  ]

  dns_label = "public"

  prohibit_public_ip_on_vnic = false

}