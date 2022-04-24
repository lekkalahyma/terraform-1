provider "aws" {
  region = var.region
}
resource "aws_instance" "apache" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.hyma-sg.id]
  key_name               = var.key_name
  user_data              = <<EOF
  #!/bin/bash
yum update -y
yum install httpd -y 
systemctl enable httpd
systemctl start httpd
mkdir -p  /var/www/html/cricket/
echo "this is cricket" >/var/www/html/cricket/index.html
EOF

  tags = {
    Name = "apache"
  }
}