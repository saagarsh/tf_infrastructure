# used for count meta arguments

# output "ec2_instance_private_ip" {
#   value = aws_instance.terra-server[*].private_ip

# }

# output "ec2_instance_public_dns" {
#   value = aws_instance.terra-server[*].public_dns
# }

# output "ec2_instance_public_ip" {
#   value = aws_instance.terra-server[*].public_ip
# }

output "ec2_instance_private_ip" {
  value = [
    for insatnce in aws_instance.terra-server : insatnce.private_ip
  ]
}

output "ec2_instance_public_dns" {
  value = [
    for insatnce in aws_instance.terra-server : insatnce.public_dns
  ]
}

output "ec2_instance_public_ip" {
  value = [
    for insatnce in aws_instance.terra-server : insatnce.public_ip
  ]
}