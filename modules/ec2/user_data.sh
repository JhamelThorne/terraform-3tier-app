#!/bin/bash
# Install updates and MySQL client
yum update -y
yum install -y mysql
# Install AWS CLI (if not already installed)
yum install -y aws-cli
# Retrieve secrets from Parameter Store
DB_USER=$(aws ssm get-parameter --name "/project2/db_username" --with-decryption --region us-east-1 --query "Parameter.Value" --output text)
DB_PASS=$(aws ssm get-parameter --name "/project2/db_password" --with-decryption --region us-east-1 --query "Parameter.Value" --output text)
# Log for visibility during testing (remove or secure later!)
echo "Database Username: $DB_USER"
echo "Database Password: $DB_PASS"
# (Optional) Connect test (replace with actual endpoint later)
# mysql -h your-rds-endpoint.amazonaws.com -u $DB_USER -p$DB_PASS -e "SHOW DATABASES;"
# You could also write these into a config file for your backend app
