# Declare VPC resource
resource "aws_vpc" "ot_microservices_dev" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ot-microservices-dev"
  }
}

# Declare Subnet Resource
resource "aws_subnet" "application_subnet" {
  vpc_id            = aws_vpc.ot_microservices_dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "application-subnet"
  }
}

# Declare ALB Security Group
resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
  name   = "alb-security-group"

  tags = {
    Name = "alb-security-group"
  }
}

# Declare Bastion Security Group
resource "aws_security_group" "bastion_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
  name   = "bastion-security-group"

  tags = {
    Name = "bastion-security-group"
  }
}

# Declare EMPLOYEE Security Group
resource "aws_security_group" "employee_security_group" {
  vpc_id = aws_vpc.ot_microservices_dev.id
  name   = "employee-security-group"

  tags = {
    Name = "employee-security-group"
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = [aws_security_group.alb_security_group.id]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  = [aws_security_group.bastion_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Declare ALB Load Balancer
resource "aws_lb" "front_end" {
  name               = "front-end-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]
  subnets            = [aws_subnet.application_subnet.id]

  enable_deletion_protection = false
  enable_http2              = true

  tags = {
    Name = "front-end-lb"
  }
}

# Declare ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }
}

# Declare Instance
resource "aws_instance" "employee_instance" {
  ami                   = "ami-04a81a99f5ec58529" # Replace with actual AMI
  subnet_id             = aws_subnet.application_subnet.id
  vpc_security_group_ids = [aws_security_group.employee_security_group.id]
  instance_type         = "t2.micro"
  key_name              = "backend"

  tags = {
    Name = "employee"
  }
}

# Declare Target Group and Attachment
resource "aws_lb_target_group" "employee_target_group" {
  name        = "employee-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.ot_microservices_dev.id
}

resource "aws_lb_target_group_attachment" "employee_target_group_attachment" {
  target_group_arn = aws_lb_target_group.employee_target_group.arn
  target_id        = aws_instance.employee_instance.id
  port             = 8080
}

# Declare Listener Rule
resource "aws_lb_listener_rule" "employee_rule" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.employee_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/v1/employee/*"]
    }
  }
}

# Declare Launch Template for Employee
resource "aws_launch_template" "employee_launch_template" {
  name = "employee-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 10
      volume_type = "gp3"
    }
  }

  network_interfaces {
    subnet_id                   = aws_subnet.application_subnet.id
    associate_public_ip_address = false
    security_groups             = [aws_security_group.employee_security_group.id]
  }

  key_name      = "backend"
  image_id      = "ami-0cc489ff5815b317c" # Replace with actual AMI
  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "employeeASG"
    }
  }
}

# Declare Auto Scaling for Employee
resource "aws_autoscaling_group" "employee_autoscaling" {
  name                      = "employee-autoscale"
  max_size                  = 2
  min_size                  = 0
  desired_capacity          = 0
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.employee_launch_template.id
    version = "$Default"
  }
  vpc_zone_identifier = [aws_subnet.application_subnet.id]
  target_group_arns   = [aws_lb_target_group.employee_target_group.arn]
}

resource "aws_autoscaling_policy" "employee_scaling_policy" {
  name                   = "employee-autoscaling-policy"
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  estimated_instance_warmup = 300
  autoscaling_group_name = aws_autoscaling_group.employee_autoscaling.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}
