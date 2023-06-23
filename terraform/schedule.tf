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

resource "oci_monitoring_alarm" "schedule_ds_ocilogging_alarm" {
    #Required
    compartment_id = var.compartment_ocid
    destinations = [oci_ons_notification_topic.schedule_ds_ocilogging_notification_topic.id]
    display_name = "${var.AlarmNamePrefix}-${var.deployment_name}-${random_id.tag.hex}"
    is_enabled = "true"
    metric_compartment_id =  var.compartment_ocid
    namespace = "oci_faas"
    query = "FunctionInvocationCount[1d].count() >= 0"
    severity = "INFO"

    #Optional
    pending_duration = "PT1M"
    repeat_notification_duration = "PT1M"
}