#----------------------------------------------------------------
#                                                               -
#                        WebServer                              -
#                                                               -
#----------------------------------------------------------------

provider "aws" {}

resource "aws_instance" "WebServer" {
  count                  = 2
  instance_type           = "t3.micro"
  ami                     = "ami-0f1d8c8ad70ce9c62"
  key_name                = "WindowsServer16WithConteiners"
  private_ip             = "172.31.31.${count.index +10}"
  subnet_id              = "subnet-4e55a335"
  vpc_security_group_ids  = [aws_security_group.web.id]
  user_data = <<EOF
#!/bin/bash
sudo -s
yum -y update
yum -y install httpd
myip=`curl http://ipv4.icanhazip.com`
echo "<h2>IP: $myip </h2><br> " > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

tags = {
    Name = "WebServer"
    Owner = "Denis Scherbakov"
}
} 

resource "aws_security_group" "web" {
  name        = "Web security_group"
  description = "Web security_group"

  ingress {
    
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

  }
}

output "ip" {
  value = aws_instance.WebServer.public_ip
}
