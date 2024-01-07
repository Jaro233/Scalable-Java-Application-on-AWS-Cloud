resource "aws_launch_configuration" "my_lc" {
  name_prefix     = "my-launch-config-"
  image_id        = var.ami_id  # ID of the AMI created by Packer
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance_sg.id]
  iam_instance_profile  = var.iam_role
  key_name = "ec2_apache"
  user_data = <<-EOF
  #!/bin/bash
  bash /home/ubuntu/start.sh
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "my_asg" {
  launch_configuration    = aws_launch_configuration.my_lc.id
  vpc_zone_identifier     = var.subnets
  target_group_arns       = [aws_lb_target_group.my_tg.arn]
  min_size                = 1
  max_size                = 3
  desired_capacity        = 2
  health_check_type       = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "my-instance"
    propagate_at_launch = true
  }
}
