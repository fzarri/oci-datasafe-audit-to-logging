## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


# Functions Policies


resource "oci_identity_policy" "DataSafetoLoggingFunctionsPolicy" {
  provider = oci.homeregion
  depends_on     = [oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup]
  name = "${var.PolicyNamePrefix}-${local.compartment_name}-${random_id.tag.hex}"
  description = "${var.PolicyDescription}"
  compartment_id = var.tenancy_ocid
  count = var.setup_policies ? 1 : 0
  statements = ["Allow dynamic-group ${oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup[0].name} to manage log-content in compartment id ${var.compartment_ocid} where target.bucket.name=${oci_objectstorage_bucket.tracker-bucket.name}", 
        "Allow dynamic-group ${oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup[0].name} to manage objects in compartment id ${var.compartment_ocid} where target.bucket.name=${oci_objectstorage_bucket.tracker-bucket.name}",
        "Allow dynamic-group ${oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup[0].name} to read objectstorage-namespaces in compartment id ${var.compartment_ocid} where target.bucket.name=${oci_objectstorage_bucket.tracker-bucket.name}", 
        "allow dynamic-group ${oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup[0].name} to read buckets in compartment id ${var.compartment_ocid} where target.bucket.name=${oci_objectstorage_bucket.tracker-bucket.name}",
        "Allow dynamic-group ${oci_identity_dynamic_group.DataSafetoLoggingFunctionsServiceDynamicGroup[0].name} to read data-safe-audit-events in tenancy"
        ]

  provisioner "local-exec" {
       command = "sleep 5"
  }
}

resource "oci_identity_dynamic_group" "DataSafetoLoggingFunctionsServiceDynamicGroup" {
  provider = oci.homeregion
  name           = "${var.DynamicGroupNamePrefix}-${local.compartment_name}-${random_id.tag.hex}"
  description    =  "${var.DynamicGroupDescription}"
  compartment_id = var.tenancy_ocid
  count = var.setup_policies ? 1 : 0
  matching_rule  = "ALL {resource.type = 'fnfunc', resource.compartment.id = '${var.compartment_ocid}'}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}
