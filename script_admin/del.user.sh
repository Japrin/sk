#!/bin/bash

if [ $# -lt 1 ]
then 
	echo "Usage: $0 <user>"
	exit 1
fi

a_user=$1

echo "remove account ..."
userdel -r $a_user

echo "remove directories ..."
rm -i -rf /WPSnew/$a_user

echo "remove from the queue ..."
qconf -du $a_user bpq

echo "rm from ssh.d ..."
sed -i '/AllowUsers/s/ '$a_user'//' /etc/ssh/sshd_config
service sshd restart





