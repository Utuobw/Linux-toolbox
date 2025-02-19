#!/bin/sh

#版权©West2Cloud 作者QQ：3485938889 修改脚本有母的请留下版权信息

# 显示主菜单
echo "==========================="
echo "Linux工具箱菜单            "
echo "==========================="
echo "West2Cloud官网 west2cloud.cn          "
echo "QQ：3485938889"
echo "==========================="
echo "1) 一键更换DNS（谷歌）"
echo "2) 一键更换DNS（阿里）"
echo "---------------------------"
echo "3) 安装宝塔面板（Centos/Open/Alibaba）"
echo "4) 安装宝塔面板（Ubuntu/Deepin）"
echo "5) 安装宝塔面板（Debian）"
echo "---------------------------"
echo "6) 安装魔方云"
echo "7) 安装魔方云（备用）"
echo "---------------------------"
echo "8) 安装小皮面板（Centos/麒麟/统信）"
echo "9) 安装小皮面板（Ubuntu）"
echo "10) 安装小皮面板（Debian）"
echo "---------------------------"
echo "11) 一键换源"
echo "12) 一键换源（备用）"
echo "---------------------------"
echo "13) 安装xui面板"
echo "---------------------------"
echo "14) 修改ssh端口"
echo "---------------------------"
echo "15) 宝塔面板破解版"
echo "16) 宝塔面板国际版（Ubantu）"
echo "---------------------------"
echo "17) 查看本机IP"
echo "18) 安装旧版工具箱"
echo "19) 安装1Panel（Centos）"
echo "20) 重启服务器"
echo "---------------------------"
echo "q) 退出"
echo "==========================="

# 读取用户输入
read -p "请输入对应的序列号: " choice

# 根据用户输入执行对应脚本
case $choice in
    1)
        echo "正在更换DNS（谷歌）"
        echo "nameserver 8.8.8.8" > /etc/resolv.conf
   echo "nameserver 8.8.4.4" >> /etc/resolv.conf
        ;;
    2)
        echo "正在更换DNS（阿里）"
        echo "nameserver 223.5.5.5" > /etc/resolv.conf
   echo "nameserver 223.6.6.6" >> /etc/resolv.conf
        ;;
    3)
        echo "正在安装宝塔面板"
        url=https://download.bt.cn/install/install_panel.sh;if [ -f /usr/bin/curl ];then curl -sSO $url;else wget -O install_panel.sh $url;fi;bash install_panel.sh ed8484bec
        ;;
    4)
        echo "正在安装宝塔面板"
        if [ -f /usr/bin/curl ];then curl -sSO https://download.bt.cn/install/install_nearest.sh;else wget -O install_nearest.sh https://download.bt.cn/install/install_nearest.sh;fi;bash install_nearest.sh ed8484bec
        ;;
    5)
        echo "正在安装宝塔面板"
        if [ -f /usr/bin/curl ];then curl -sSO https://download.bt.cn/install/install_nearest.sh;else wget -O install_nearest.sh https://download.bt.cn/install/install_nearest.sh;fi;bash install_nearest.sh ed8484bec
        ;;
    6)
        echo "正在安装魔方云"
        curl https://raw.githubusercontent.com/aazooo/zjmf/main/install-zjmf-cloud_new -O install-zjmf-cloud_new && chmod +x install-zjmf-cloud_new && ./install-zjmf-cloud_new
        ;;
    7)
        echo "正在安装魔方云"
        curl https://raw.githubusercontent.com/aazooo/zjmf/main/install-zjmf-cloud_new -O install-zjmf-cloud_new && chmod +x install-zjmf-cloud_new && ./install-zjmf-cloud_new
        ;;
    8)
        echo "正在安装小皮面板"
        sudo curl -O https://dl.xp.cn/dl/xp/install.sh && sudo bash install.sh
        ;;
    9)
        echo "正在安装小皮面板"
        sudo curl -O install.sh https://dl.xp.cn/dl/xp/install.sh && sudo bash install.sh
        ;;
    10)
        echo "正在安装小皮面板"
        sudo curl -O install.sh https://dl.xp.cn/dl/xp/install.sh && sudo bash install.sh
        ;;
    11)
        echo "正在换源"
        curl -sSL https://gitee.com/SuperManito/LinuxMirrors/raw/main/ChangeMirrors.sh -o main.sh && chmod +x main.sh && ./main.sh
        ;;
    12)
        echo "正在换源"
        curl -sSL https://raw.githubusercontent.com/Utuobw/Linux-toolbox/main/ChangeMirrors.sh -o main.sh && chmod +x main.sh && ./main.sh
        ;;
    13)
        echo "正在安装xui面板"
        curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh  -o main.sh && chmod +x main.sh && ./main.sh
        ;;
    14)
        echo "正在更换ssh端口"
        change_ssh_port() {
    read -p "请输入新的 SSH 端口: " new_port
    sed -i "s/Port [0-9]*/Port $new_port/" /etc/ssh/sshd_config
    systemctl restart sshd
    echo "SSH 端口已修改为 $new_port"
}
        ;;
    15)
        echo "正在安装宝塔面板破解版"
        curl -O install.sh http://www.bt5.me/install.sh && sh install.sh
        ;;
    16)
        echo "正在安装宝塔面板国际版"
        URL=https://www.aapanel.com/script/install_7.0_en.sh && if [ -f /usr/bin/curl ];then curl -ksSO "$URL" ;else wget --no-check-certificate -O install_7.0_en.sh "$URL";fi;bash install_7.0_en.sh aapanel
        ;;
    17)
        echo "正在查看本机IP"
        curl ifconfig.me
        ;;
    18)
        echo "正在安装旧版工具箱"
        sudo curl -O https://raw.githubusercontent.com/Utuobw/Linux-toolbox/main/install.sh && sudo bash install.sh
        ;;
    19)
        echo "正在安装1panel面板"
        curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sh quick_start.sh
        ;;
    20)
        echo "重启服务器"
        reboot
        ;;
    q)
        echo "退出工具箱"
        exit 0
        ;;
    *)
        echo "无效的选项，请重新运行脚本并选择有效的序列号"
        ;;
esac