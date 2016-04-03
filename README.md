? Problem : I want to reset password of my 100's no of linux servers.                                                                 
  Tradiational solution : Log in to each server manually and the then reste password, but this process is time consuming.

    My solution : Written an bash script for resetting ssh password of Linux servers.

      To work this script you have to put IP address and working root password of remote Linux servers in a file 
      "server_details", please check "server_details" file format in same branch. Format must be like 
      "<IP>:<old_password>"

    After executing script successfully it will create new file "updated_server_details" at same location where 
    is your main script. You can find password details as "<IP>:<new_password>"
    
    Also in this script I have written code for cron scheduling i.e to schedule this script for each 15 days.
    that mean script will reset password of servers on every 15th day of month.

