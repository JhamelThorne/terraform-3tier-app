# 3-Tier AWS Web Application Deployment (Terraform)
## Project Overview
This project provisions a production-grade 3-Tier Web Application infrastructure on AWS using Terraform Cloud. It features a secure, scalable, and modular environment spanning networking, compute, and database services.
## Architecture
- **VPC**: Custom VPC with public and private subnets across multiple Availability Zones.
- **Compute Layer**: EC2 instances (frontend/backend) deployed in private subnets, connected via Systems Manager Session Manager (no public IPs).
- **Database Layer**: RDS MySQL instance hosted in private subnets, with credential retrieval from AWS Systems Manager Parameter Store.
- **Networking Layer**: NAT Gateway for secure outbound internet access from private subnets, Internet Gateway for public-facing resources.
- **Security**: Fine-grained Security Groups with least privilege access control for EC2 and RDS.
## Key Features
- Private, scalable multi-AZ network design
- Secure database credential management via SSM Parameter Store
- Modular Terraform code structure
- Infrastructure deployed through Terraform Cloud with remote backend state management
- DNS Resolution and NAT Gateway configured for private subnets
- Session Manager access without SSH keys
## Technologies Used
- Terraform
- AWS VPC, EC2, RDS, SSM Parameter Store
- NAT Gateway, Internet Gateway
- Terraform Cloud (Remote backend & Variables management)
## Deployment Steps
1. Set environment variables in Terraform Cloud for project, subnets, AMI ID, instance type, etc.
2. Run Terraform Cloud plan and apply to deploy infrastructure.
3. Verify EC2 to RDS connectivity through Systems Manager session.
## Future Enhancements
- Integrate Application Load Balancer (ALB)
- Implement Auto Scaling Groups for EC2 instances
- Add CloudWatch Alarms and enhanced logging
