output "my-vpc-id" {
  value = aws_vpc.my-vpc.id
}

output "public1-id" {
  value = aws_subnet.public1.id
}

output "public2-id" {
  value = aws_subnet.public2.id
}