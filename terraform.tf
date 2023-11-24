# --------- apache_and_jenkins_master ---------

provider "aws" {
    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_SECRET_KEY"
    region     = "eu-north-1"
}

resource "aws_instance" "apache-jenkins-master" {
    ami                    = "ami-0fe8bec493a81c7da"
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.apache-jenkins-master.id] 
    # прив'язали security group до інстанса
    key_name               = "jenkins_Stockholm"
    user_data              = file("apache_and_jenkins_master.sh")
    # using external bash script, тобто внутрішній статичний файл
}

resource "aws_security_group" "apache-jenkins-master" {
  name        = "Apache With Jenkins Master Security Group"
  description = "My first SecurityGroup"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# --------- apache_and_wildfly ---------
resourse "aws_instance" "apache-wildfly" {
    ami                    = "ami-0fe8bec493a81c7da"
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.apache-wildfly.id] 
    # прив'язали security group до інстанса
    key_name               = "jenkins_Stockholm"
    user_data              = file("apache_and_wildfly.sh")
    # using external bash script, тобто внутрішній статичний файл
}

resource "aws_security_group" "apache-wildfly" {
  name        = "Apache With WildFly Security Group"
  description = "My second SecurityGroup"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# --------- jdk_and_jenkins_slave ---------

resource "aws_instance" "jdk-jenkins-slave" {
    ami                    = "ami-0fe8bec493a81c7da"
    instance_type          = "t3.micro"
    vpc_security_group_ids = [aws_security_group.jdk-jenkins-slave.id] 
    # прив'язали security group до інстанса
    key_name               = "jenkins_Stockholm"
    user_data              = file("jenkins_slave.sh")
    # using external bash script, тобто внутрішній статичний файл
}

resource "aws_security_group" "jdk-jenkins-slave" {
  name        = "JDK With Jenkins Slave Security Group"
  description = "My third SecurityGroup"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

output "webserver_ip" {
    value = aws_instance.webserver-test.public_ip
}
