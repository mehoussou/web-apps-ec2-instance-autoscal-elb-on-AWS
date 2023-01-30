data "aws_availability_zones" "available" {}

#define AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["amazon"]
  filter {
      name = "name"
      values = [.............]
   }
   
  }
   resource "aws_key_pair" "my_key_pair" {
        key_name = "my_key_name"
        publick_key = file(var.PATH_TO_PUBLIC_KEY)
        
   #DEFINE ASG LAUCNH CONFIG
   
   resource "aws_lauch_configuration" "custom-launch-config"{
    name = "custom-launch-config"
    image_id = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_aws_key.key_name
     
    user_data = "#!/bin/bash................................"
     
    lifecycle {
      create_before_destroy = true
    }
  }
    

#     data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_launch_configuration" "as_conf" {
#   name_prefix   = "terraform-lc-example-"
#   image_id      = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

 #define autoscalling group


resource "aws_autoscaling_group" "cgasg" {
  name                 = "cgasg"
  vpc_zone_ididentifier = ["aws_subnet-customvpc-public-1.id, aws_subnet.customvpv-public-2.id"]
  launch_configuration = aws_launch_configuration.custom-launch-config.name
  min_size             = 2
  max_size             = 2
  health_check_grace_period = 100
#   health_check_type = "EC2"
  health_check_type = "ELB"
  load_balancers = [aws_elb.custom-elb.name]
  force_delete = true
  tags = {
    key = "Name"
    value = "custom_ec2_instance"
    propagate_at_launch = true
   }
}

 output "elb" {
     value = aws_elb.custom-elb.dns_name
 }
   
#   lifecycle {
#     create_before_destroy = true
#   }
# }
    
    
    #define as config policy
    
#   resource "aws_autoscaling_policy" "custom-cpu-policy" {
#   name                   = "custom-cpu-policy"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 60
#   policy_type = "SimpleScaling"
# }

  
    
    
    
    #define cloud watch monitoring
    
#   resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm" {
#   alarm_name                = "custom-cpu-alarm"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = "2"
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/EC2"
#   period                    = "120"
#   statistic                 = "Average"
#   threshold                 = "20"
#   alarm_description         = "This metric monitors ec2 cpu utilization"
#   dimensions = {
#     AutoScalingGroupName" :aws_autoscaling_group.custom-group-autoscaling.name
#    }
#    actions_enabled = true
#    alarm_actions = [aws_autoscaling_policy.custom-cpu-policy.arn]
    
    
    
#     #define auto descaling policy
    
#   resource "aws_autoscaling_policy" "custom-cpu-policy-scaledown" {
#   name                   = "custom-cpu-policy-scaledown"
#   scaling_adjustment     = -1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 60
#   policy_type = "SimpleScaling"
# }

#       #define descaling cloud watch
      
#   resource "aws_cloudwatch_metric_alarm" "custom-cpu-alarm-scaledown" {
#   alarm_name                = "custom-cpu-alarm-scaledown"
#   comparison_operator       = "LessThanOrEqualToThreshold"
#   evaluation_periods        = "2"
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/EC2"
#   period                    = "120"
#   statistic                 = "Average"
#   threshold                 = "10"
#   alarm_description         = "This metric monitors ec2 cpu utilization"
#   dimensions = {
#     AutoScalingGroupName" :aws_autoscaling_group.custom-group-autoscaling.name
#    }
#    actions_enabled = true
#    alarm_actions = [aws_autoscaling_policy.custom-cpu-policy-scaledown.arn]
