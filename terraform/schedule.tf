## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl


resource "oci_ons_notification_topic" "schedule_ds_ocilogging_notification_topic" {
    #Required
    compartment_id = var.compartment_ocid
    name = "${var.NotificationTopicNamePrefix}-${var.deployment_name}-${random_id.tag.hex}"
}

resource "oci_ons_subscription" "schedule_ds_ocilogging_notification_subscription" {
    #Required
    compartment_id = var.compartment_ocid
    endpoint = oci_functions_function.postauditlogs.id
    protocol = "ORACLE_FUNCTIONS"
    topic_id = oci_ons_notification_topic.schedule_ds_ocilogging_notification_topic.id
}