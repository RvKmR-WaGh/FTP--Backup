##############################
#Name of script : pass_reset
#Author : Ravikumar Wagh
##############################
FS=":"
function conf_cron
{
echo -e "0\t0\t*/15\t*\t0\t $PWD/pass_reset" >> /var/spool/cron/root
/etc/init.d/crond restart
echo "Crontab configured"
echo "\n\n\t\tThanks for using script"	
echo -e "\t\t\t\t\t-RvKmR"

}
function change_pass()
{
echo "Changing Password of : $server"
pass=$(makepasswd)
ssh $server 'passwd' "<< EOF
$old_pass
$pass
$pass
EOF"
echo $server$FS$pass >> updated_server_details
}
function read_pass 
{
	if [ -f $PWD/server_details ]
	then
		echo "old server details found in $PWD/"
		while read line
		do
			echo $line > tmp
			server=$(awk -F':' '{print $1}' tmp)
			old_pass=$(awk -F':' '{print $2}' tmp)
			echo "server : $server"
			echo "old_pass : $old_pass"
			change_pass
		done <server_details
	fi
	rm -rf tmp
}
####Main####	
if [ -f '/usr/bin/makepasswd' ]; 
then  
	read_pass
	if [ $(crontab -l | grep pass_reset.sh | wc -l) == 0 ]
	then
		echo "Configuring crontab for this script"
		conf_cron
	else
		echo "\n\n\t\tThanks for using script"	
		echo -e "\t\t\t\t\t-RvKmR"
else  
	sudo apt-get install makepasswd  
	#sudo yum install makepasswd
	read_pass	
fi
	
