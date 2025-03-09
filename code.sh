#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<html><head><style>body {background-color: purple; color: white; }</style></head><body><h1><p> Welcome to Utrains. This is Barry i am a nice student. <br>You are redirected to ${HOSTNAME} to see how the load balancer is sharing the traffic.</p></h1></html>" > /var/www/html/index.html