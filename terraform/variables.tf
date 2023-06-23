## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}

#comment for stack zip file
variable "user_ocid" {}
#comment for stack zip file
variable "fingerprint" {} 
#comment for stack zip file
variable "private_key_path" {}

variable "compartment_ocid" {}
variable "region" {}
variable "ocir_user_name" {}
variable "ocir_user_password" {}

variable "deployment_name" {
    default = "test"
}

variable "datasafe_audit_compartment_id" {}


variable "release" {
  description = "Reference Data Safe DB Audit Log Exporter Release (OCI Logging)"
  default     = "1.0.0"
}

variable "ocir_repo_name" {
  default = "oci-datasafe-audit-to-logging"
}

variable "setup_policies" {
  default = true
}

###################################
# Bucket Variables
###################################
variable "tracker-bucket" {
  default = "datasafe-to-ocilogging-collector-bucket"
}

###################################
# Network Variables
###################################

variable "subnet_ocid" {
  default = "replace"
}
variable "create_network" {
  default = true
}
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



###################################
# Policies Variables
###################################
variable "PolicyNamePrefix" {
  default = "DataSafetoLoggingFunctions"
}

variable "PolicyDescription" {
  default = "Data Safe to Logging Function Policy"
}

variable "DynamicGroupNamePrefix" {
  default = "dg-datasafe-fn-audit-to-logging"
}
variable "DynamicGroupDescription" {
  default = "Dynamic Group for function to manage DataSafe DB Audit to OCI Logging"
}

###################################
# Functions Variables
###################################
variable "FunctionAppNamePrefix" {
  default = "DataSafeAuditDBtoLoggingApp"
}

variable "FunctionNamePrefix" {
  default = "oci-datasafe-audit-to-logging"
}

variable "FunctionMemory" {
  default = "1024"
}

variable "FunctionInvokeOCILoggingName" {
  default = "fn-datasafe-dbaudit"
}

variable "FunctionTimeoutSec" {
  default = "300"
}


###################################
# Logging Variables
###################################
variable "LogGroupPrefix" {
  default = "datasafe-dbaudit-log_group"
}

variable "LogDataSafeAuditDBNamePrefix" {
  default = "datasafe-dbaudit"
}

###################################
# Notification Variables
###################################
variable "NotificationTopicNamePrefix" {
  default = "datasafe-dbaudit-notification_topic"
}