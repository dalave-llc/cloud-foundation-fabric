# Copyright 2026 DALAVE LLC.
# This software is provided as-is, without warranty or representation for any use or purpose.
# Your use of it is subject to your agreement with DALAVE LLC.

output "trigger" {
  value = google_cloudbuild_trigger.repo_trigger
}