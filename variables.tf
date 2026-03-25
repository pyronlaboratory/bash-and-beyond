variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the AWS key pair for SSH access"
}

# ── Existing resource IDs to reuse ────────────────────────────────────────────

variable "create_new_sg" {
  default = false
}

variable "vpc_id" {
  description = "Existing VPC ID"
}

variable "subnet_id" {
  description = "Existing subnet ID"
}

variable "security_group_id" {
  description = "Existing security group ID (guardians-of-the-port)"
}

variable "snapshot_id" {
  description = "EBS snapshot ID to restore root volume from (from previous instance)"
  default     = ""
}
