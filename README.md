# web-apps-ec2-instance-autoscal-elb-on-AWS

ssh into the instance created via asg then install an apps called stress

$ apt-get install stress
$ strees --cpu 2 --timeout 300

with that, you can increase the work load of your instance cpu so you can see if the asg work.


aws ELB
- For elb, user must specify one public subnet for at least two availability zones.
- elb accepts incoming traffic from client and routes to targets
- elb monitors the health of registered target and sends traffic to the healthy targets only
- elb supports SSL offloading

aws Auto Scaling
- ASG ensures that ec2 instances are sufficient to run your application
- when the number of requests increases, the load on the VMs increases, AWS will identify and autoscale the resources as per the defined config.
- autoscaling group

components of autoscaling
-Groups: a collection of instances with similar characteristics
- Launch configurations: a template for launching EC2 instances
- scaling plan :
   - auto-scaling
   - manual-scaling
   - schedule-based scaling
   - demand-based scaling

