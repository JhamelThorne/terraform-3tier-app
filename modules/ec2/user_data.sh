#!/bin/bash
yum update -y
yum install -y aws-cli

DB_USER=$(aws ssm get-parameter --name "/project2/db_username" --with-decryption --query Parameter.Value --output text)
DB_PASS=$(aws ssm get-parameter --name "/project2/db_password" --with-decryption --query Parameter.Value --output text)

echo "Database User: $DB_USER"
echo "Database Password: $DB_PASS"

# You can expand this later to export vars or pass them into your application 
