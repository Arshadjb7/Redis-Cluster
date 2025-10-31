# outputs.tf
# This file defines all output values for the Redis Enterprise infrastructure

# ============================================
# EC2 INSTANCE OUTPUTS
# ============================================

# Public IP addresses of all Redis nodes
output "redis_node_public_ips" {
  description = "Public IP addresses of all Redis Enterprise nodes"
  value       = aws_instance.redis_nodes[*].public_ip
}

# Individual node public IPs for easy reference
output "redis_node_1_public_ip" {
  description = "Public IP address of Redis node 1"
  value       = aws_instance.redis_nodes[0].public_ip
}

output "redis_node_2_public_ip" {
  description = "Public IP address of Redis node 2"
  value       = aws_instance.redis_nodes[1].public_ip
}

output "redis_node_3_public_ip" {
  description = "Public IP address of Redis node 3"
  value       = aws_instance.redis_nodes[2].public_ip
}

# Private IP addresses for internal communication
output "redis_node_private_ips" {
  description = "Private IP addresses of all Redis Enterprise nodes"
  value       = aws_instance.redis_nodes[*].private_ip
}

# Instance IDs
output "redis_node_instance_ids" {
  description = "Instance IDs of all Redis Enterprise nodes"
  value       = aws_instance.redis_nodes[*].id
}

# ============================================
# VPC OUTPUTS
# ============================================

# VPC ID
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.redis_vpc.id
}

# VPC CIDR block
output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.redis_vpc.cidr_block
}

# ============================================
# SUBNET OUTPUTS
# ============================================

# All subnet IDs
output "subnet_ids" {
  description = "IDs of all public subnets"
  value       = aws_subnet.public_subnets[*].id
}

# Individual subnet IDs for reference
output "subnet_1_id" {
  description = "ID of public subnet 1 (ap-south-1a)"
  value       = aws_subnet.public_subnets[0].id
}

output "subnet_2_id" {
  description = "ID of public subnet 2 (ap-south-1b)"
  value       = aws_subnet.public_subnets[1].id
}

output "subnet_3_id" {
  description = "ID of public subnet 3 (ap-south-1c)"
  value       = aws_subnet.public_subnets[2].id
}

# ============================================
# SECURITY GROUP OUTPUTS
# ============================================

# Security group ID
output "security_group_id" {
  description = "ID of the Redis Enterprise security group"
  value       = aws_security_group.redis_sg.id
}

# Security group name
output "security_group_name" {
  description = "Name of the Redis Enterprise security group"
  value       = aws_security_group.redis_sg.name
}

# ============================================
# OTHER OUTPUTS
# ============================================

# Internet Gateway ID
output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.redis_igw.id
}

# Route table ID
output "route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rt.id
}

# AMI ID used for instances
output "ubuntu_ami_id" {
  description = "Ubuntu AMI ID used for Redis nodes"
  value       = data.aws_ami.ubuntu.id
}

# ============================================
# CONNECTION INFORMATION
# ============================================

# SSH connection commands
output "ssh_connection_commands" {
  description = "SSH commands to connect to each Redis node"
  value = [
    for i in range(var.instance_count) :
    "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.redis_nodes[i].public_ip}"
  ]
}

# Redis Enterprise UI URLs
output "redis_ui_urls" {
  description = "URLs to access Redis Enterprise web UI for each node"
  value = [
    for i in range(var.instance_count) :
    "https://${aws_instance.redis_nodes[i].public_ip}:8443"
  ]
}

# Summary output
output "cluster_summary" {
  description = "Summary of the Redis Enterprise cluster deployment"
  value = {
    cluster_name   = var.project_name
    region         = var.aws_region
    instance_type  = var.instance_type
    node_count     = var.instance_count
    vpc_id         = aws_vpc.redis_vpc.id
    security_group = aws_security_group.redis_sg.id
  }
}
