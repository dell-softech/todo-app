resource "oci_core_vcn" "main" {

  compartment_id = var.compartment_ocid

  display_name = "todo-vcn"

  cidr_blocks = ["10.0.0.0/16"]

  dns_label = "todovcn"

}

resource "oci_core_internet_gateway" "main" {

  compartment_id = var.compartment_ocid

  vcn_id = oci_core_vcn.main.id

  display_name = "todo-igw"

  enabled = true

}

resource "oci_core_route_table" "main" {

  compartment_id = var.compartment_ocid

  vcn_id = oci_core_vcn.main.id

  display_name = "todo-route-table"

  route_rules {

    destination = "0.0.0.0/0"

    destination_type = "CIDR_BLOCK"

    network_entity_id = oci_core_internet_gateway.main.id

  }

}


resource "oci_core_security_list" "main" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main.id
  display_name   = "todo-security-list"

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}