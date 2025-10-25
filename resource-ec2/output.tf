output "ec2_instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.example.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
