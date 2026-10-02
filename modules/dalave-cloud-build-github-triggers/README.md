# Cloud Build Triggers

## Usage

```
module "github_monorepo_triggers" {
  source = "./modules/m-cb-trigger"

  project_id                 = local.cicd_project_id
  region                     = local.region
  cloudbuild_service_account = local.cloud_build_sa_id
  
  # Pass the repository ID from the module above
  repository_id = module.github_repositories["org-net-gcp-bootstrap"].repository_id
  
  # Pass the map of folders to generate triggers for
  triggers = local.triggers
}
```
locals.tf

```
triggers = {
    "org-00-iam" = {
      substitutions = {
        _IMPERSONATE_SA   = local.impersonate_service_account
        _REGION           = local.region
        _TF_STATE_BUCKET  = var.remote_state_bucket
        _PRIVATEPOOL_NAME = local.worker_pool_name
        _GROUP_ORG_ADMIN  = local.group_org_admin
        _ORGANIZATION_ID  = local.organization_id
      }
    }
    "org-03-resource-mgmt" = {
      substitutions = {
        _IMPERSONATE_SA    = local.impersonate_service_account
        _REGION            = local.region
        _TF_STATE_BUCKET   = var.remote_state_bucket
        _PRIVATEPOOL_NAME  = local.worker_pool_name
        _SSH_KEY_SECRET_ID = local.ssh_key_secret_id
      }
    }
  }
```