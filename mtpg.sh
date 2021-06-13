#!/bin/sh
#一键安装mtproxy-go脚本

#清屏
clear

#显示脚本信息
echo '**********************************'
echo '* MTProxy_go一键安装脚本 @ nbyhc *'
echo '* v1.0                 2021-06-12 *'
echo '***************************************'

#输入需要使用的端口
read -p "使用端口(建议:443/2053/2083/2087/2096/8443)：" PORT_NO

echo '更新APT源/软件'
apt update && apt upgrade -y

echo '安装git/wget'
apt install git wget -y

echo '安装Golang'
#这里需要去官网确认最新的go文件安装包的名字
GO_FILE=go1.16.5.linux-amd64.tar.gz
wget https://golang.org/dl/${GO_FILE}
tar -C /usr/local -xzf ${GO_FILE}
export PATH=$PATH:/usr/local/go/bin

echo '安装mtg'
git clone https://github.com/9seconds/mtg.git
cd mtg
go build
cp mtg /usr/local/bin


#生成密钥（这将返回一个ee开头的密钥，ee表示支持Fake TLS，将生成的密钥保存好，一会儿需要填入toml配置文件中）
echo '生成密钥'
#命令的输出赋值给一个变量,方法为把命令用反引号(在Esc下方)引起来
SECRET=`mtg generate-secret --hex auca.com`
echo $SECRET

#为mtg创建一个系统服务文件
#vim 命令，按 i 进入插入模式，此时可以将内容粘贴进去。如果是在其他VPS，鼠标右键粘贴时还需要按住shift键。然后按ESC键退出，按 :wq 保存。
echo '创建系统服务'
cat >>/usr/lib/systemd/system/mtg.service<<EOF
[Unit]
Description=mtg

[Service]
ExecStart=/usr/local/bin/mtg run /etc/mtg.toml
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

#最简单：只需要配置密钥和端口便可以成功运行mtg。
echo '配置mtg.toml'
cat >>/etc/mtg.toml<<EOF
secret = "${SECRET}"
bind-to = "0.0.0.0:${PORT_NO}"
EOF

echo '启动mtg'
systemctl daemon-reload
systemctl enable mtg
systemctl start mtg
