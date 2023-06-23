## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_functions_application" "DataSafeAuditDBtoLoggingApp" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.FunctionAppNamePrefix}-${var.deployment_name}-${random_id.tag.hex}"
  subnet_ids     = [var.create_network ? module.setup-network[0].fnsubnet_ocid : var.subnet_ocid] 
}

resource "oci_functions_function" "postauditlogs" {
  depends_on     = [null_resource.DataSafeAuditDBtoLoggingPush2OCIR]
  application_id = oci_functions_application.DataSafeAuditDBtoLoggingApp.id
  display_name   = "${var.FunctionNamePrefix}-${var.deployment_name}"
  image          = "${local.ocir_docker_repository}/${local.namespace}/${var.ocir_repo_name}/${var.FunctionNamePrefix}:0.0.1"
  memory_in_mbs  = "${var.FunctionMemory}"
  config = {
    "ociDataSafeCompartmentOCID" : "${var.datasafe_audit_compartment_id}"
    "ociOSTrackerBucketName" : "${oci_objectstorage_bucket.tracker-bucket.name}",
    "ociLoggingLogOCID" : "${oci_logging_log.log_on_fn_invoke.id}"
  }
  
}

resource "oci_logging_log" "log_on_fn_invoke" {
  display_name = "${var.FunctionInvokeOCILoggingName}-${var.deployment_name}-${random_id.tag.hex}"
  log_group_id = oci_logging_log_group.log_group.id
  log_type     = "SERVICE"

  configuration {
    source {
      category    = "invoke"
      resource    = oci_functions_application.DataSafeAuditDBtoLoggingApp.id
      service     = "functions"
      source_type = "OCISERVICE"
    }
    compartment_id = var.compartment_ocid
  }
  is_enabled = true
  
}


