# IaC Vending Machine

Self-service Azure infrastructure provisioning via YAML requests + GitHub Actions.

## How it works
1. Developer submits a YAML file in `requests/` via PR
2. Workflow validates the request and runs `terraform plan`
3. On merge to main, Terraform provisions the infrastructure in Azure

## Architecture
- **Terraform** modules in `modules/` for reusable infrastructure
- **GitHub Actions** workflow with validate → plan → apply
- **Azure service principal** auth via GitHub secrets
- **Security by default**: TLS 1.2, no public access

## Example Request
\`\`\`yaml
resource: azure-storage
name: myteam-data
region: centralus
tags:
  team: analytics
  env: prod
  owner: bvoncarr
\`\`\`
