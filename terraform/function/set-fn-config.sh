#!/bin/sh
. ./set-local-vars.sh

fn config function $FN_APP_NAME ${PWD##*/} ociDataSafeCompartmentOCID $OCI_DATASAFE_COMPARTMENT_OCID
fn config function $FN_APP_NAME ${PWD##*/} ociLoggingLogOCID $OCI_LOGGING_LOG_OCID
fn config function $FN_APP_NAME ${PWD##*/} ociOSTrackerBucketName $OCI_OS_TRACKER_BUCKET_NAME
