# Apply Yourself!


Infrastructure-as-Code setup to provision an AWS EC2 instance using Terraform, with optional Ansible integration for server configuration.
Project: [https://roadmap.sh/projects/iac-digitalocean](https://roadmap.sh/projects/iac-digitalocean)

## Prerequisites

```
- Terraform ≥ 1.0
- AWS CLI
- AWS credentials configured with EC2 permissions
```

## Project structure

```bash
source/
├── main.tf            # Provider, data sources, EC2 instance
├── variables.tf       # Input variable declarations
├── outputs.tf         # Public IP, DNS, instance ID, SSH command
└── terraform.tfvars   # Variable values (see Configuration)
```

## Configuration

Rename `terraform.tfvars.example` to `terraform.tfvars` and set the following values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

| Variable | Description |
|---|---|
| `region` | AWS region |
| `ami_id` | EC2 AMI ID |
| `instance_type` | Instance type (default: `t3.micro`) |
| `key_name` | AWS key pair name |
| `vpc_id` | Target VPC ID |
| `subnet_id` | Target subnet ID |
| `security_group_id` | Existing SG ID — ignored when `create_new_sg = true` |
| `create_new_sg` | Set to `true` to provision a new security group |

Before applying, update `outputs.tf` with your actual key path and name:
> `"ssh -i ~/.ssh/<key>.pem ec2-user@..."`

## Usage

```bash
terraform init
terraform plan
terraform apply
```

Using the `-out` arg with `terraform plan`

```bash
terraform plan -out=tfplan   # persists the plan; apply executes it deterministically
terraform apply tfplan
```

```bash
# terraform apply outputs

instance_id = "i-xxxxxxxxxxxxxxxxx"
public_ip   = "x.x.x.x"
public_dns  = "ec2-x-x-x-x.compute-1.amazonaws.com"
ssh_command = "ssh -i ~/.ssh/<key>.pem ec2-user@x.x.x.x"
```

## SSH Access

```bash
chmod 400 ~/.ssh/<key>.pem
ssh -i ~/.ssh/<key>.pem ec2-user@<public-ip>
```

## Ansible Integration

Export the public IP for use in your Ansible inventory:

```bash
terraform output -raw public_ip > server_ip.txt
```

Place `server_ip.txt` in the root of your Ansible project and update `inventory.ini`:

```
[webservers]
{{ lookup('file', 'inventory_ip.txt') }}

...
```
## Teardown

```bash
terraform destroy
```
