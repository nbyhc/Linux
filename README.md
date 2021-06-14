#一键安装  
wget -N --no-check-certificate https://raw.githubusercontent.com/nbyhc/Linux_Shell/main/mtpg.sh && chmod +x mtpg.sh && bash mtpg.sh


#输出 MTProxy 代理链接(支持tg、t.me格式链接还有二维码)  
mtg access /etc/mtg.toml


#运行以下命令查看mtg运行状态：  
systemctl status mtg


#查看systemd单元的mtg消息，命令如下：  
journalctl -u mtg
