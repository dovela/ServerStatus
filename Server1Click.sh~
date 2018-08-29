#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

###########施工中#########

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
sepa="———————————-"

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
    echo 'ServerStatus下载完成,正在进行配置...'
}

add_node(){
    clear
    stty erase '^H' && read -p "节点名称 name (例:node1):" sname
    stty erase '^H' && read -p "节点虚拟化类型 type (例:kvm):" stype
    stty erase '^H' && read -p "节点 host (例:host1):" shost
    stty erase '^H' && read -p "节点位置 location (例:hk):" slocation
    stty erase '^H' && read -p "节点用户名 username (例:s01):" susername    
    stty erase '^H' && read -p "节点密码 password :" spasswd
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
#    echo -e ' 节点 '${sname}' 添加成功!'
}

view_node(){
    clear
    server_text=`cat ${server_conf} | grep "username" -A 5 | sed 's/"/ /g;/-/d' | awk '{print $3}'`
    [[ -z ${server_text} ]] && echo -e "Error, 没有发现监控节点!" && exit 1
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
    server_list=${server_list}${count}". 名称: "${server_name}"  类型: "${server_type}"  host: "${server_host}"  位置: "${server_location}"  用户名: "${server_username}"  密码: "${server_password}"\n"
    done
    echo -e ${server_list}
    echo -e "\n当前有 "${server_total}" 个监控节点\n"
}

del_node(){
    view_node
    stty erase '^H' && read -p "输入 数字 删除对应的节点 [1-${server_total}] (默认回车取消): " del_num
    [[ -z "${del_num}" ]] && del_num="0"
    expr ${del_num} + 0 &>/dev/null
    if [[ $? -eq 0 ]]; then
        if [[ ${del_num} -ge 1 ]] && [[ ${del_num} -le ${server_total} ]]; then
           echo -e "${server_text}" | sed -n "$"
}

clear
echo -e " 
${sepa}
 1.安装 ServerStatus 服务端
${sepa}
 2.添加 监控节点
 3.删除 监控节点
 4.查看 监控节点
${sepa}
 输入 数字+Enter 开始，或任意键退出
"
echo && stty erase '^H' && read -p " 请输入数字[1-4]:" dovela
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
    echo -e "Error, 请输入正确的数字[1-4]!"
    ;;
 esac
