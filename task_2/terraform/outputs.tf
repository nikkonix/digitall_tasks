output "web_server_ips" {
  value = aws_instance.web[*].public_ip
}

output "alb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.mydb.endpoint
}
