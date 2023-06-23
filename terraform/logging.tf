## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_logging_log_group" "log_group" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.LogGroupPrefix}"
}

resource "oci_logging_log" "log_datadafe_auditdb" {
  display_name = "${var.LogDataSafeAuditDBNamePrefix}-${var.deployment_name}-${random_id.tag.hex}"
  log_group_id = oci_logging_log_group.log_group.id
  log_type     = "CUSTOM"
  is_enabled = true
}
