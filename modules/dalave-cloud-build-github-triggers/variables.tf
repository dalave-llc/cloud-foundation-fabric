# Copyright 2026 DALAVE LLC.
# This software is provided as-is, without warranty or representation for any use or purpose.
# Your use of it is subject to your agreement with DALAVE LLC.

variable "project_id" {
  type        = string
  description = "The GCP Project ID where triggers will be created."
}

variable "region" {
  type        = string
  description = "The GCP region for the Cloud Build triggers."
}

variable "cloudbuild_service_account" {
  type        = string
  description = "The service account ID (not email) to be used by Cloud Build."
}

variable "repository_id" {
  type        = string
  description = "The ID of the Cloud Build v2 repository (retrieved from m-cb-repo module)."
}

variable "repo_branch" {
  type        = string
  default     = "main"
  description = "The default branch to trigger builds on."
}

variable "include_build_logs" {
  type        = string
  default     = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  description = "The logging configuration for Cloud Build."
}

variable "triggers" {
  type = map(object({
    substitutions = map(string)
  }))
  description = "Map of monorepo folder names to their specific trigger configurations."
}