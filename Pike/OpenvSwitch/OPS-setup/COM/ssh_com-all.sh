#!/bin/bash
#Author Son Do Xuan

source ../function.sh
source ../config.sh
source com_num.sh
source ../folder-name_config.sh

source sshkey_setup.sh

if [ $network_model = "provider" -o $network_model = "selfservice" ]
then
	echo -e "\e[32mScripts start install \e[0m"
else
	echo -e "\e[31mConfig wrong network_model variable in file config.sh:\e[0m \e[1;43;31mprovider\e[0m \e[31mor\e[0m \e[1;43;31mselfservice\e[0m"
	exit 1;
fi

scp -i ../$FOLDER_KEY_NAME/mykey -r ../../$FOLDER_ROOT_NAME root@${COM_EXT_IP[$COM_NUM]}:
ssh -t -t -i ../$FOLDER_KEY_NAME/mykey root@${COM_EXT_IP[$COM_NUM]} "cd $FOLDER_ROOT_NAME/$COM_FOLDER_NAME && source com-all.sh $network_model"
ssh -t -t -i ../$FOLDER_KEY_NAME/mykey root@$CTL_EXT_IP "cd $FOLDER_ROOT_NAME/$CTL_FOLDER_NAME && source ctl-4-nova_discoveryhost.sh"
cd ../$UPDATE_FOLDER_NAME
source ssh_update_hosts.sh
