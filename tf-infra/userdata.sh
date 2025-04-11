#!/bin/bash

echo "HOST=${HOST}" | sudo tee -a /opt/csye6225/src/.env 
echo "DATABASE_PORT=${DB_PORT}" | sudo tee -a /opt/csye6225/src/.env 
echo "DATABASE_USERNAME=${DB_USER}" | sudo tee -a /opt/csye6225/src/.env 
echo "DATABASE_PASSWORD=${DB_PASSWORD}" | sudo tee -a /opt/csye6225/src/.env
echo "DATABASE_NAME=${DATABASE_NAME}" | sudo tee -a /opt/csye6225/src/.env 
echo "DIALECT=${DB_DIALECT}" | sudo tee -a /opt/csye6225/src/.env 
echo "PORT=${SERVER_PORT}" | sudo tee -a /opt/csye6225/src/.env 
echo "BUCKET_NAME=${S3_BUCKET_NAME}" | sudo tee -a /opt/csye6225/src/.env 

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -c file:/opt/cw-config.json -s
