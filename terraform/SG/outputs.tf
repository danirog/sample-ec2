output "sg_ec2_id" {
  sensitive   = true
  description = "ID of the SG test"
  value       = aws_security_group.sg_test.id
}
