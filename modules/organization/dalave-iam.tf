# Copyright 2026 DALAVE LLC.
# This software is provided as-is, without warranty or representation for any use or purpose.
# Your use of it is subject to your agreement with DALAVE LLC.

resource "google_organization_iam_audit_config" "config" {
  org_id = local.organization_id_numeric
  service = "allServices"
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}