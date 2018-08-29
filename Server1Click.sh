#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

###########ʩ����#########

#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+/others(test)
#	Description: Auto-install the ServerStatus Client
#	Version: 0.0.1
#	Author: dovela
#=================================================
sh_ver="0.0.1"

file="/home/ServerStatus"
server="/home/ServerStatus/server"
server_conf="/home/ServerStatus/server/config.json"
server_sergate="/home/ServerStatus/server/sergate"
server_web="/home/ServerStatus/web/"
sepa="����������������������-"

check_pid(){
	PID="35601"
}

get_para(){
    Name=`awk '{if($0~"name") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
    Type=`awk '{if($0~"type") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
    Host=`awk '{if($0~"host") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
    Location=`awk '{if($0~"location") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
    Username=`awk '{if($0~"username") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
    Password=`awk '{if($0~"password") print}' ${server_conf} | sed 's/"/ /g' | awk '{print $3}' | head -n 1`
}

install_sss(){
    clear
    cd /home && git clone https://github.com/cppla/ServerStatus.git && cd ServerStatus
    echo 'ServerStatus�������,���ڽ�������...'
}

add_node(){
    clear
    stty erase '^H' && read -p "�ڵ����� name (��:node1):" sname
    stty erase '^H' && read -p "�ڵ����⻯���� type (��:kvm):" stype
    stty erase '^H' && read -p "�ڵ� host (��:host1):" shost
    stty erase '^H' && read -p "�ڵ�λ�� location (��:hk):" slocation
    stty erase '^H' && read -p "�ڵ��û��� username (��:s01):" susername    
    stty erase '^H' && read -p "�ڵ����� password :" spasswd
    add_info=${sepa}"\n\tname: "${sname}"\n\ttype: "${stype}"\n\thost: "${shost}"\n\tlocation: "${slocation}"\n\tpassword: "${spasswd}"\n"${sepa}
    insert_info="{
            "username": "${susername}",
			"name": "${sname}",
			"type": "${stype}",
			"host": "${shost}",
	    	"location": "${slocation}",
			"password": "${spasswd}"
		}"
    echo -e "${add_info}"
  #  sed -i 's/\]/'"${susername}&"'/' ${server_conf}
    sed -i 's/\]/'"${insert_info}&"'/' ${server_conf}
    sed -i 's/\]/'"${insert_info}&"'/' ${server_conf}
    sed -i 's/\]/'"${insert_info}&"'/' ${server_conf}
    sed -i 's/\]/'"${sname}&"'/' ${server_conf}
    sed -i 's/\]/'"${susername}&"'/' ${server_conf}
#    echo -e ' �ڵ� '${sname}' ��ӳɹ�!'
}

view_node(){
    clear
    server_text=`cat ${server_conf} | grep "username" -A 5 | sed 's/"/ /g;/-/d' | awk '{print $3}'`
    [[ -z ${server_text} ]] && echo -e "Error, û�з��ּ�ؽڵ�!" && exit 1
    server_total=`echo -e "${server_text}" | expr $(wc -l) / 6`
    server_list=""
    for((count = 1; count <= ${server_total}; count++))
    do
    server_num=`expr \( ${count} - 1 \) \* 6 + 1`
    server_name=`echo -e "${server_text}" | sed -n "$(expr ${server_num} + 1)p"`
    server_type=`echo -e "${server_text}" | sed -n "$(expr ${server_num} + 2)p"`
    server_host=`echo -e "${server_text}" | sed -n "$(expr ${server_num} + 3)p"`
    server_location=`echo -e "${server_text}" | sed -n "$(expr ${server_num} + 4)p"`
    server_username=`echo -e "${server_text}" | sed -n "${server_num}p"`
    server_password=`echo -e "${server_text}" | sed -n "$(expr ${server_num} + 5)p"`
    server_list=${server_list}${count}". ����: "${server_name}"  ����: "${server_type}"  host: "${server_host}"  λ��: "${server_location}"  �û���: "${server_username}"  ����: "${server_password}"\n"
    done
    echo -e ${server_list}
    echo -e "\n��ǰ�� "${server_total}" ����ؽڵ�\n"
}

del_node(){
    view_node
    stty erase '^H' && read -p "���� ���� ɾ����Ӧ�Ľڵ� [1-${server_total}] (Ĭ�ϻس�ȡ��): " del_num
    [[ -z "${del_num}" ]] && del_num="0"
    expr ${del_num} + 0 &>/dev/null
    if [[ $? -eq 0 ]]; then
        if [[ ${del_num} -ge 1 ]] && [[ ${del_num} -le ${server_total} ]]; then
           echo -e "${server_text}" | sed -n "$"
}

clear
echo -e " 
${sepa}
 1.��װ ServerStatus �����
${sepa}
 2.��� ��ؽڵ�
 3.ɾ�� ��ؽڵ�
 4.�鿴 ��ؽڵ�
${sepa}
 ���� ����+Enter ��ʼ����������˳�
"
echo && stty erase '^H' && read -p " ����������[1-4]:" dovela
 case "${dovela}" in
    1)
    install_sss
    ;;
    2)
    add_node
    ;;
    3)
    del_node
    ;;
    4)
    view_node
    ;;
    *)
    echo -e "Error, ��������ȷ������[1-4]!"
    ;;
 esac
