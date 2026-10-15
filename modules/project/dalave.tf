# Copyright 2026 DALAVE LLC.
# This software is provided as-is, without warranty or representation for any use or purpose.
# Your use of it is subject to your agreement with DALAVE LLC.

# Remove owner, editor and viewer roles
resource "google_project_iam_binding" "no_owner" {
  project = local.project.project_id
  role    = "roles/owner"
  members = [] 
}

resource "google_project_iam_binding" "no_editor" {
  project = local.project.project_id
  role    = "roles/editor"
  members = [] 
}

resource "google_project_iam_binding" "no_viewer" {
  project = local.project.project_id
  role    = "roles/viewer"
  members = [] 
}

resource "time_sleep" "wait_for_project" {
  depends_on = [google_project.project]
  create_duration = "60s"
}