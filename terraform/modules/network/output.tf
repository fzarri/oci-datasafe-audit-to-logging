## Copyright (c) 2023, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "fnsubnet_ocid"{
    value = oci_core_subnet.function_ds_log_vcn.id
}
