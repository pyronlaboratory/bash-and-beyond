output "public_ip" {
  description = "Public IP address of terra-byte"
  value       = aws_instance.terra_byte.public_ip
}

output "public_dns" {
  description = "Public DNS of terra-byte"
  value       = aws_instance.terra_byte.public_dns
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.terra_byte.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i ~/.ssh/<key>.pem ec2-user@${aws_instance.terra_byte.public_ip}"
}
