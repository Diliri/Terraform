#!/bin/bash

function apache_with_wildfly(){
   
   # Update package list
   sudo apt update
   
   # Install Java Development Kit (JDK)
   sudo apt install openjdk-11-jdk -y
   
   # Download WildFly
   wget https://download.jboss.org/wildfly/24.0.1.Final/wildfly-24.0.1.Final.tar.gz
   
   # Extract the downloaded archive
   tar -zxvf wildfly-24.0.1.Final.tar.gz
   
   # Move WildFly to /opt directory
   sudo mv wildfly-24.0.1.Final /opt/wildfly
   
   # Create a new user and group for WildFly service
   sudo useradd --system --no-create-home --user-group wildfly
   
   # Start WildFly
   sudo /opt/wildfly/bin/standalone.sh -b 0.0.0.0 &
   
   # Install Apache2 if not already installed
   sudo apt install apache2 -y
   
   # Enable Apache2 proxy and proxy_http modules
   sudo a2enmod proxy
   sudo a2enmod proxy_http

   # Configure Apache2 as a reverse proxy for WildFly
   echo "
   <VirtualHost *:80>
       ServerName your-domain.com
       ProxyPass / http://localhost:8080/
       ProxyPassReverse / http://localhost:8080/
   </VirtualHost>
   " | sudo tee /etc/apache2/sites-available/wildfly.conf

   # Reload Apache2 to apply changes
   sudo systemctl reload apache2

   # Enable the WildFly virtual host
   sudo a2ensite wildfly.conf

   echo "WildFly installation with Apache2 proxy completed.”
}

apache_with_wildfly
