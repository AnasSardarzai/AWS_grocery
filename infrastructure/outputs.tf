output "ec2_public_ip" {
  value = aws_instance.grocery_ec2.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.grocery_db.endpoint
}