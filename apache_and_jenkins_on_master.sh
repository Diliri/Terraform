#This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system (for the Weekly Release Line):
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  
#Then add a Jenkins apt repository entry:
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
  
#Update your local package index, then finally install Jenkins:
sudo apt-get update
sudo apt-get install fontconfig openjdk-17-jre
sudo apt-get install jenkins


# Install Apache2 if not already installed
sudo apt install apache2 -y

# Enable Apache2 proxy and proxy_http modules
sudo a2enmod proxy
sudo a2enmod proxy_http

# Configure Apache2 as a reverse proxy for Jenkins
echo "
<VirtualHost *:80>
    ServerName your-domain.com

    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/

    ErrorLog \${APACHE_LOG_DIR}/jenkins_error.log
    CustomLog \${APACHE_LOG_DIR}/jenkins_access.log combined
</VirtualHost>
" | sudo tee /etc/apache2/sites-available/jenkins.conf

# Enable the Jenkins virtual host
sudo a2ensite jenkins.conf

# Reload Apache2 to apply changes
sudo systemctl reload apache2

echo "Jenkins installation with Apache2 proxy completed. Access Jenkins at http://your-domain.com"

sudo systemctl reload apache2
