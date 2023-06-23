## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "null_resource" "Login2OCIR" {
  depends_on = [module.setup-network, oci_functions_application.DataSafeAuditDBtoLoggingApp,
   oci_objectstorage_bucket.tracker-bucket, oci_identity_policy.DataSafetoLoggingFunctionsPolicy]
 

  provisioner "local-exec" {
    command = "echo '${var.ocir_user_password}' |  docker login ${local.ocir_docker_repository} --username ${local.namespace}/${var.ocir_user_name} --password-stdin"
  }
}

resource "null_resource" "DataSafeAuditDBtoLoggingPush2OCIR" {
  depends_on = [null_resource.Login2OCIR, oci_functions_application.DataSafeAuditDBtoLoggingApp]

  provisioner "local-exec" {
    command     = "image=$(docker images | grep oci-datasafe-audit-to-logging | awk -F ' ' '{print $3}') ; docker rmi -f $image &> /dev/null ; echo $image"
    working_dir = "function/oci-datasafe-audit-to-logging"
  }

  provisioner "local-exec" {
    command     = "fn build --verbose"
    working_dir = "function/oci-datasafe-audit-to-logging"
  }

  provisioner "local-exec" {
    command     = "image=$(docker images | grep oci-datasafe-audit-to-logging | awk -F ' ' '{print $3}') ; docker tag $image ${local.ocir_docker_repository}/${local.namespace}/${var.ocir_repo_name}/oci-datasafe-audit-to-logging:0.0.1"
    working_dir = "function/oci-datasafe-audit-to-logging"
 }

  provisioner "local-exec" {
    command     = "docker push ${local.ocir_docker_repository}/${local.namespace}/${var.ocir_repo_name}/oci-datasafe-audit-to-logging:0.0.1"
    working_dir = "function/oci-datasafe-audit-to-logging"
 }
}

module "setup-network" {
  source = "./modules/network"
  count  = var.create_network ? 1 : 0
  compartment_ocid = var.compartment_ocid
  VCN-CIDR = var.VCN-CIDR
  fnsubnet-CIDR = var.fnsubnet-CIDR
}
