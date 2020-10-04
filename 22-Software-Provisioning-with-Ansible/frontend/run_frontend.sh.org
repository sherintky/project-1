#!/bin/bash

yum update -y 
yum install httpd -y
systemctl start httpd
systemctl status httpd
systemctl enable httpd
mkdir -p  /var/www/html/terraform
echo "Hello World" > /var/www/html/terraform/01-Hello.html
cp -rf  ./base.svg   /var/www/html/terraform/02-base.svg
