#!/bin/bash

project_dir=$(dirname $(dirname $(readlink -fm "$0")))
template_dir=${project_dir}/templates
html_dir=${project_dir}/html

# User
user=''
if [ "$#" -eq 0 ]
then
    user='ec2-user'
else
    user=$1
fi

# Test existence user
if [ "$(cat /etc/passwd | grep $user | wc -l)" -eq "0" ]
then
    echo "User does not exist"
    exit 1
fi

echo ${html_dir}/site.lst

if [ -f ${html_dir}/site.lst ]
then
    for folderline in $(cat ${html_dir}/site.lst)
    do
	echo $folderline
	site=$(echo $folderline | cut -d':' -f1)
	port=$(echo $folderline | cut -d':' -f2)
	if [ ! -d ${html_dir}/$site ]
	then
	    # Directory Creation
	    mkdir -p ${html_dir}/$site
	    echo "Welcome !" > ${html_dir}/$site/index.html
	    chown -R $user:$user ${html_dir}/$site

	    # Compose Generation from Template
	    if [ ! -d ${template_dir}/generated ]; then
	     	mkdir -p ${template_dir}/generated	
	    fi
	    sed -e "s/INSTANCE_NAME/${site}/g" \
  		-e "s/INSTANCE_PORT/${port}/" \
		 ${template_dir}/instance.tpl >> ${template_dir}/generated/instance.yaml
	fi
    done
else
    echo "file site.lst missing"
fi

