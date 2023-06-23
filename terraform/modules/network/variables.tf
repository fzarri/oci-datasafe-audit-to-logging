
variable "compartment_ocid" {}

variable "VCN-CIDR" {
  default = "10.0.0.0/22"
}

variable "fnsubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "fnvcndnslabelprefix" {
  default = "fndslogvcn"
}

variable "fnvcnnameprefix" {
  default = "vcn_fn_ds_log-fndslog"
}

variable "fnvcnnamenatgatewayprefix" {
  default = "function_ds_log_vcn_ng"
}

variable "fnvcnnameroutingtableprefix" {
  default = "function_ds_log_vcn_routetable_ng"
}

variable "fnvcnroutingtabledescription" {
  default = "Route for Nat Gateway"
}

variable "fnvcnnamedhcpopitonsprefix" {
  default = "function_ds_log_vcn_dhcpoptions1"
}

variable "fnsubnetnameprefix" {
  default = "private_fn_ds_log_vcn_subnet"
}

variable "fnsubnetdnslabelprefix" {
  default = "fndslogsub"
}

variable "fnvcnnamesecuritylistprefix" {
  default = "functions-security-list"
}
