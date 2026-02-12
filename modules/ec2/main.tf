resource "aws_instance" "this" {
  ami                        = var.ami_id
  instance_type              = var.instance_type
  subnet_id                  = var.subnet_id
  private_ip                 = var.private_ip
  key_name                   = var.key_name
  vpc_security_group_ids     = [var.security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    exec > /var/log/user-data.log 2>&1
    set -xe

    apt update -y
    apt install -y openjdk-11-jdk wget curl mysql-server

    cd /opt
    wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89.tar.gz
    tar -xzf apache-tomcat-9.0.89.tar.gz
    chmod +x apache-tomcat-9.0.89/bin/*.sh
    /opt/apache-tomcat-9.0.89/bin/startup.sh

    systemctl enable mysql
    systemctl start mysql
  EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_ebs_volume" "this" {
  availability_zone = aws_instance.this.availability_zone
  size              = var.ebs_size
  type              = "gp3"
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.this.id
  instance_id = aws_instance.this.id
}

