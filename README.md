#一键安装  
wget -N --no-check-certificate https://raw.githubusercontent.com/nbyhc/Linux_Shell/main/mtpg.sh && chmod +x mtpg.sh && bash mtpg.sh

#禁止Ping,保护端口被扫描到  
sysctl -w net.ipv4.icmp_echo_ignore_all=1  
sysctl -p  


#输出 MTProxy 代理链接(支持tg、t.me格式链接还有二维码)  
mtg access /etc/mtg.toml


#运行以下命令查看mtg运行状态：  
systemctl status mtg


#查看systemd单元的mtg消息，命令如下：  
journalctl -u mtg



-------------绿争手动安装MTProxy---------------
#【创建程序目录并进入】  
mkdir /home/mtproxy && cd /home/mtproxy  

#【下载程序并配置安装】  
curl -s -o mtproxy.sh https://raw.githubusercontent.com/sunpma/mtp/master/mtproxy.sh && chmod +x mtproxy.sh && bash mtproxy.sh  


----------【配置】-----------  
【port：不能与其他程序的端口重复】 = 443  
【manage port：】 = 8888  
【伪装域名（说明：自定义TLS伪装域名）】 = azure.microsoft.com  
【PROXY TAG：默认跳过或输入TAG】 =   
------------END---------------  

#【进入程序目录】  
cd /home/mtproxy  
#【运行】  
bash mtproxy.sh start  
#【调试】  
bash mtproxy.sh debug  
#【停止】  
bash mtproxy.sh stop  
#【重启】  
bash mtproxy.sh restart  
#【卸载】  
rm -rf /home/mtprox  

-----------MTProxy安装（无法启动）-----------------
curl -L -o mtp_install.sh https://git.io/fj5ru && bash mtp_install.sh
