#!/bin/bash

if [ $# -lt 2 ]
then 
	echo "Usage: $0 <user> <group>"
	exit 1
fi

a_user=$1
a_group=$2

function random_string
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

echo "add account ..."
useradd -g $a_group $a_user

echo "change passwd ..."
a_pwd=`random_string`
echo $a_user
echo $a_pwd
echo $a_pwd | passwd --stdin $a_user

echo "set directories ..."
mkdir -p /WPSnew/$a_user
chown -R $a_user:$a_group  /WPSnew/$a_user
edquota -p zeminz $a_user

echo "add to the queue ..."
qconf -au $a_user bpq

echo "add to ssh.d ..."
sed -i '/AllowUsers/s/$/ '$a_user'/' /etc/ssh/sshd_config
service sshd restart



