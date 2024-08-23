#!/bin/bash

homeproject="/home/ec2-user/php-mysql-datas"

if [ -f ${homeproject}/html/site.lst ]
then
    for folder in $(cat ${homeproject}/html/site.lst)
    do
	echo "Test création $folder :"
	if [ ! -d ${homeproject}/html/$folder ]
	then
	    mkdir -p  ${homeproject}/html/$folder
	    chown -R ec2-user:ec2-user $folder
    	    echo "ok"
	else
	    echo "ko"
	fi
    done
else
    echo "fichier site.lst absent"
fi

