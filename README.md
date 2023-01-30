# web-apps-ec2-instance-autoscal-elb-on-AWS

ssh into the instance created via asg then install an apps called stress

$ apt-get install stress
$ strees --cpu 2 --timeout 300

with that, you can increase the work load of your instance cpu so you can see if the asg work.
