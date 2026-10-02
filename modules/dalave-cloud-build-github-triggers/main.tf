# Copyright 2026 DALAVE LLC.
# This software is provided as-is, without warranty or representation for any use or purpose.
# Your use of it is subject to your agreement with DALAVE LLC.

locals {
  # Dynamically generate Plan and Apply triggers for ALL folders
  triggers_list = flatten([
    for folder_name, config in var.triggers : [
      {
        trigger_name      = "${folder_name}-plan"
        trigger_type      = "pull_request"
        filename          = "${folder_name}/cloudbuild-plan.yaml"
        approval_required = false
        included_files    = ["${folder_name}/**"]
        ignored_files     = ["*", "!/${folder_name}/**"]
        substitutions     = config.substitutions
      },
      {
        trigger_name      = "${folder_name}-apply"
        trigger_type      = "push"
        filename          = "${folder_name}/cloudbuild-apply.yaml"
        approval_required = true
        included_files    = ["${folder_name}/**"]
        ignored_files     = ["*", "!/${folder_name}/**"]
        substitutions     = config.substitutions
      }
    ]
  ])

  # Convert list back to map for the resource for_each loop
  triggers_map = { for t in local.triggers_list : t.trigger_name => t }
}

resource "google_cloudbuild_trigger" "repo_trigger" {
  for_each        = local.triggers_map
  
  name            = each.value.trigger_name
  project         = var.project_id
  location        = var.region
  service_account = var.cloudbuild_service_account

  repository_event_config {
    repository = var.repository_id

    dynamic "push" {
      for_each = each.value.trigger_type == "push" ? [1] : []
      content {
        branch = var.repo_branch
      }
    }

    dynamic "pull_request" {
      for_each = each.value.trigger_type == "pull_request" ? [1] : []
      content {
        branch = var.repo_branch
      }
    }
  }

  source_to_build {
    repo_type = "GITHUB"
    ref       = "refs/heads/${var.repo_branch}"
  }

  included_files     = each.value.included_files
  ignored_files      = each.value.ignored_files
  filename           = each.value.filename
  include_build_logs = var.include_build_logs
  
  approval_config {
    approval_required = each.value.approval_required
  }
  
  substitutions = each.value.substitutions
}