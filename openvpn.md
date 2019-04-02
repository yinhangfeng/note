## 使用 docker 安装

https://github.com/kylemanna/docker-openvpn


```
OpenVPN是一个用于创建虚拟专用网络(Virtual Private Network)加密通道的免费开源软件。使用OpenVPN可以方便地在家庭、办公场所、住宿酒店等不同网络访问场所之间搭建类似于局域网的专用网络通道。
    使用OpenVPN配合特定的代理服务器，可用于访问Youtube、FaceBook、Twitter等受限网站，也可用于突破公司的网络限制。
一、服务器端安装及配置
    服务器环境：CentOS6.8 64位系统
    OpenVPN版本：OpenVPN 2.4.3 x86_64-redhat-linux-gnu
    1、安装前准备

# 关闭selinux
https://www.zhihu.com/question/20559538
setenforce 0
sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
 
# 安装openssl
yum -y install openssl
 
# 安装epel源
http://blog.csdn.net/yasi_xi/article/details/11746255
rpm -ivh http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
sed -i 's/^mirrorlist=https/mirrorlist=http/' /etc/yum.repos.d/epel.repo

    2、安装及配置OpenVPN和easy-rsa

# 安装openvpn和easy-rsa
yum -y install openvpn easy-rsa
 
# 拷贝一份easy-rsa 到 /etc/openvpn 方便修改自定义配置
cp -R /usr/share/easy-rsa/ /etc/openvpn

# 修改vars文件
cd /etc/openvpn/easy-rsa/2.0/
vim vars


# 修改注册信息，比如公司地址、公司名称、部门名称等。
export KEY_COUNTRY="CN"
export KEY_PROVINCE=“ZJ"
export KEY_CITY=“HZ"
export KEY_ORG="MyOrganizat"
export KEY_EMAIL="me@myhost.mydomain"
export KEY_OU="MyOrganizationalUnit"


# 初始化环境变量
source vars
 
# 清除keys目录下所有与证书相关的文件
# 下面步骤生成的证书和密钥都在/usr/share/easy-rsa/2.0/keys目录里
./clean-all
 
# 生成根证书ca.crt和根密钥ca.key（一路按回车即可）
./build-ca
 
# 为服务端生成证书和密钥（一路按回车，直到提示需要输入y/n时，输入y再按回车，一共两次）
./build-key-server server
 
# 每一个登陆的VPN客户端需要有一个证书，每个证书在同一时刻只能供一个客户端连接，下面建立2份
# 为客户端生成证书和密钥（一路按回车，直到提示需要输入y/n时，输入y再按回车，一共两次）
./build-key client1
./build-key client2
 
# 创建迪菲·赫尔曼密钥，会生成dh2048.pem文件（生成过程比较慢，在此期间不要去中断它）
./build-dh
 
# 生成ta.key文件（防DDos攻击、UDP淹没等恶意攻击）
openvpn --genkey --secret keys/ta.key

    查看keys目录下生成的文件：

    3、创建服务器端配置文件

# 在openvpn的配置目录下新建一个keys目录
mkdir /etc/openvpn/keys
 
# 将需要用到的openvpn证书和密钥复制一份到刚创建好的keys目录中
cp /etc/openvpn/easy-rsa/2.0/keys/{ca.crt,server.{crt,key},dh2048.pem,ta.key} /etc/openvpn/keys/
 
# 复制一份服务器端配置文件模板server.conf到/etc/openvpn/
cp /usr/share/doc/openvpn-*/sample/sample-config-files/server.conf /etc/openvpn/
# 编辑server.conf
vim /etc/openvpn/server.conf


port 1194
# 改成tcp，默认使用udp，如果使用HTTP Proxy，必须使用tcp协议 TODO
proto tcp
dev tun
# 路径前面加keys，全路径为/etc/openvpn/keys/ca.crt
ca keys/ca.crt
cert keys/server.crt
key keys/server.key  # This file should be kept secret
dh keys/dh2048.pem
# 默认虚拟局域网网段，不要和实际的局域网冲突即可
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
# 10.0.0.0/8是我这台VPN服务器所在的内网的网段，读者应该根据自身实际情况进行修改 TODO
push "route 10.0.0.0 255.0.0.0"
# 可以让客户端之间相互访问直接通过openvpn程序转发，根据需要设置
client-to-client
# 如果客户端都使用相同的证书和密钥连接VPN，一定要打开这个选项，否则每个证书只允许一个人连接VPN
duplicate-cn
# 默认
keepalive 10 120
# 路径前面加keys
tls-auth keys/ta.key 0 # This file is secret
# 有需要添加
comp-lzo
# 默认
persist-key
# 默认
persist-tun
# OpenVPN的状态日志，默认为/etc/openvpn/openvpn-status.log
status openvpn-status.log
# OpenVPN的运行日志，默认为/etc/openvpn/openvpn.log 启动失败可以查看具体信息
log-append openvpn.log
# 改成verb 5可以多查看一些调试信息
verb 5

    4、配置内核和防火墙，启动服务

# 开启路由转发功能
sed -i '/net.ipv4.ip_forward/s/0/1/' /etc/sysctl.conf
sysctl -p
 
# 配置防火墙，别忘记保存 TODO 根据需求修改 -p tcp udp
https://arashmilani.com/post?id=53
iptables -I INPUT -p tcp --dport 1194 -m comment --comment "openvpn" -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j MASQUERADE
service iptables save
 
# 启动openvpn并设置为开机启动
service openvpn start
TODO
chkconfig openvpn on

    5、创建客户端配置文件

# 复制一份client.conf模板命名为client.ovpn
cp /usr/share/doc/openvpn-*/sample/sample-config-files/client.conf client.ovpn
# 编辑client.ovpn
vim client.ovpn

client
dev tun
# 改为tcp TODO
proto tcp
# OpenVPN服务器的外网IP和端口
remote xxx.xxx.xxx.xxx 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ca ca.crt
# client的证书
cert client.crt
# client的密钥
key client.key
ns-cert-type server
# 去掉前面的注释
tls-auth ta.key 1
# 有需要添加
comp-lzo
verb 3

6、参考
https://blog.cryse.org/article/centos7-openvpn
http://www.centoscn.com/CentosServer/test/2014/1120/4153.html
https://www.digitalocean.com/community/tutorials/how-to-setup-and-configure-an-openvpn-server-on-centos-6#initial-openvpn-configuration
https://www.digitalocean.com/community/tutorials/how-to-setup-and-configure-an-openvpn-server-on-centos-7

二、windows
https://openvpn.net/index.php/download/community-downloads.html
1. 安装
2. 将client.ovpn、ca.crt、client.crt、client.key、ta.key 放入安装目录下的config文件夹

附录
1. 局域网可用IP网段 http://blog.sina.com.cn/s/blog_5375d76b0101qdbp.html
C类局域网专用网段：192.168.0.1~192.168.255.254
B类局域网专用网段：172.16.0.1~172.31.255.254
A类局域网专用网段：10.0.0.1~10.255.255.254
几个特殊的IP地址：127.0.0.1为本地回路测试地址
255.255.255.255代表广播地址
0.0.0.0代表任何网络
网络号全为0的代表本地网络和本地网段
网络号全为1的代表所有的网络
主机位全为0的代表某个网段的任何主机地址
主机位全为1的代表该网段的所有主机

2.ip 地址 192.168.0.1/24 什么意思
https://zhidao.baidu.com/question/71308833.html
```
