## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_virtual_network" "vcn" {
  cidr_block     = var.VCN-CIDR
  dns_label      = "${var.fnvcndnslabelprefix}${random_id.tag.hex}"
  compartment_id = var.compartment_ocid
  display_name   = "${var.fnvcnnameprefix}-${random_id.tag.hex}"
}

resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.fnvcnnamenatgatewayprefix}-${random_id.tag.hex}"
  vcn_id         = oci_core_virtual_network.vcn.id
}

resource "oci_core_route_table" "rt_fn_subnet" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.fnvcnnameroutingtableprefix}-${random_id.tag.hex}"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
    description = "${var.fnvcnroutingtabledescription}-${random_id.tag.hex}"
  }
  
}



resource "oci_core_dhcp_options" "dhcpoptions1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "${var.fnvcnnamedhcpopitonsprefix}-${random_id.tag.hex}"
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }  
}

resource "oci_core_subnet" "function_ds_log_vcn" {
  cidr_block        = var.fnsubnet-CIDR
  display_name      = "${var.fnsubnetnameprefix}-${random_id.tag.hex}"
  dns_label         = "${var.fnsubnetdnslabelprefix}${random_id.tag.hex}"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.vcn.id
  route_table_id    = oci_core_route_table.rt_fn_subnet.id
  dhcp_options_id   = oci_core_dhcp_options.dhcpoptions1.id
  security_list_ids = [oci_core_security_list.vcn_security_list.id]
}

resource "oci_core_security_list" "vcn_security_list"{
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name = "${var.fnvcnnamesecuritylistprefix}-${random_id.tag.hex}"

  egress_security_rules {
      stateless = false
      destination = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      protocol = "all" 
  }

  ingress_security_rules { 
      stateless = false
      source = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
        code = 4
      } 
  }   
  
  ingress_security_rules { 
      stateless = false
      source = "10.0.0.0/16"
      source_type = "CIDR_BLOCK"
      # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
      protocol = "1"
  
      # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
      icmp_options {
        type = 3
      } 
  }

}
