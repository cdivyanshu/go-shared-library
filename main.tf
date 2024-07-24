provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "ot_microservices_dev" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "application_subnet" {
  vpc_id            = aws_vpc.ot_microservices_dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "secondary_subnet" {
  vpc_id            = aws_vpc.ot_microservices_dev.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
}

resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
}

resource "aws_security_group" "bastion_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
}

resource "aws_security_group" "employee_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
}

resource "aws_lb" "front_end" {
  name               = "front-end"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [aws_subnet.application_subnet.id, aws_subnet.secondary_subnet.id]
}

resource "aws_instance" "employee_instance" {
  ami                    = "ami-0ad21ae1d0696ad58"
  instance_type          = "t2.micro"
  key_name               = "devinfra"
  vpc_security_group_ids = [aws_security_group.employee_security_group.id]
  subnet_id              = aws_subnet.application_subnet.id
}

resource "aws_launch_template" "employee_launch_template" {
  name          = "employee-launch-template"
  image_id      = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  key_name      = "devinfra"
}

resource "aws_autoscaling_group" "employee_autoscaling" {
  launch_template {
    id      = aws_launch_template.employee_launch_template.id
    version = "$Latest"
  }
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  vpc_zone_identifier = [aws_subnet.application_subnet.id, aws_subnet.secondary_subnet.id]
}

resource "aws_lb_target_group" "employee_target_group" {
  name     = "employee-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ot_microservices_dev.id
}
