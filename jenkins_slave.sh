#!/bin/bash
#Replace "your-jenkins-master" with the actual hostname or IP address of your Jenkins Master, and "your-agent-secret-token" with the actual secret token for connecting the agent to the master.

function jenkins_slave(){
  
  # Replace with your Jenkins Master URL and secret token
  JENKINS_MASTER_URL="http://your-jenkins-master:8080"
  AGENT_SECRET="your-agent-secret-token"
  
  # Install Java Development Kit (JDK)
  sudo apt update
  sudo apt install openjdk-17-jre -y
  
  # Create a Jenkins agent directory
  sudo mkdir -p /var/lib/jenkins/agent
  cd /var/lib/jenkins/agent
  
  # Download Jenkins agent JAR
  wget "${JENKINS_MASTER_URL}/jnlpJars/agent.jar"
  
  # Create a Jenkins agent service file
  echo "
  [Unit]
  Description=Jenkins Agent
  
  [Service]
  ExecStart=/usr/bin/java -jar /var/lib/jenkins/agent/agent.jar -jnlpUrl ${JENKINS_MASTER_URL}/computer/Agent/slave-agent.jnlp -secret ${AGENT_SECRET}
  Restart=always
  RestartSec=3
  User=jenkins-agent
  Group=jenkins-agent
  
  [Install]
  WantedBy=multi-user.target
  " | sudo tee /etc/systemd/system/jenkins-agent.service
  
  # Create Jenkins agent user and group
  sudo groupadd jenkins-agent
  sudo useradd -m -g jenkins-agent -s /bin/bash jenkins-agent
  
  # Set permissions
  sudo chown -R jenkins-agent:jenkins-agent /var/lib/jenkins/agent
  
  # Reload systemd
  sudo systemctl daemon-reload
  
  # Enable and start Jenkins agent service
  sudo systemctl enable jenkins-agent
  sudo systemctl start jenkins-agent
  
  echo "Jenkins agent installation completed. Check Jenkins Master for the agent connection status."
}

jenkins_slave
