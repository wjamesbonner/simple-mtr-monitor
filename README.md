# simple-mtr-monitor
This repo holds the scripts for the simple route monitor described at https://ternary.tech/quick-and-easy-route-monitoring/. The tool was built on Amazon Linux in AWS, 
and the instructions below reflect that. To get the tool up and going on your own Linux host, do the following.

* Make sure your host is up to date: sudo yum update -y
* Install Netcat: sudo yum install nc -y
* Upload the bash files (.sh) into the user directory the process will run under. The scripts assume ec2-user; change as appropriate.
* Make the script files executable:

	 chmod u+x generator.sh
	 
	 chmod u+x lifecycle.sh
	 
	 chmod u+x netcat.sh
	 
	 chmod u+x set_targets.sh
	 
	 chmod u+x startup.sh
	 
	 chmod u+x trace.sh
  
* Edit the set-targets.sh file so that the targets array holds the hosts you wish to monitor. (See https://ternary.tech/quick-and-easy-route-monitoring/ for details)
* Run ./set-targets.sh
* Edit your cront tab (sudo nano /etc/crontab) and paste in the scheduled task lines from the crontab file included in this repo. Edit the user name as appropriate.
* Reboot the server (sudo reboot)
* Wait 5-10 minutes for the traces to generate.
* Navigate to http://host-ip:8080 to view the traces.
