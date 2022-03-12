# NAS

旧的PC安装 Ubuntu

## 目标功能

* samba 共享
* （完成） 实现邮件推送空气质量，依赖cron和python脚本
* calibre 电子书库，使用 [calibre-web](https://github.com/janeczku/calibre-web)
* ownCloud

---

## cablre-web配置

acer上网本安装 Debian 11 ，不选图形界面，选择 SSH server，重启后root登录。

### 添加wifi

`cd /etc/network/` ，编辑 `vi interfaces`

```
allow-hotplug wlp2s0
auto wlp2s0
iface wlan0 inet dhcp
wpa-conf /etc/wpa.conf
```

进入 `/etc` 目录，新建 wpa.conf 文件

`touch wpa.conf`

```
wpa_passphrase wifi名称 wifi密码 >> /etc/wpa.conf
```

启动网卡

`ifup wlp2s0`

提示没有ifup命令，需要添加PATH

`export PATH=$PATH:/sbin`

提示已经自动连接wifi

### 添加sudoer权限

`apt-get install sudo`

添加 /etc/sudoers 文件写属性

`chmod +w /etc/sudoers`

编辑 /etc/sudoers ，下面的user是你要添加的用户名

```
root ALL=(ALL)ALL
user ALL=(ALL)ALL
```

去掉 /etc/sudoers 文件写属性

`chmod -w /etc/sudoers`


### 安装 calibre-web 

`sudo apt-get install pip`

按照主页安装 [janeczku/calibre-web](https://github.com/janeczku/calibre-web)

`pip install calibreweb`

添加 ~/.local/bin/ 到系统 PATH，用 `cps` 命令启动，本地访问  http://localhost:8083

添加为系统服务： https://github.com/janeczku/calibre-web/wiki/Setup-Service-on-Linux

创建好服务脚本，启动即可

### frpc 反向代理

 [fatedier/frp](https://github.com/fatedier/frp)

palm给的frpc服务，下载到 ~/frpc ，配置 frpc.ini

```
[common]  
server_addr = 远程IP
server_port = 远程端口
token = 密码  
####上面都不用改#####  
  
[laodu]  
type = tcp ---改成需要配置的通信协议  
local_ip = 127.0.0.1   ----本地地址  
local_port = 8083       ------本地的端口  
remote_port = 30083    ------希望远程的端口
```

编辑 system 目录下的 frpc.service 文件

```
ExecStart=/home/laodu/frpc/frpc -c /home/laodu/frpc/frpc.ini
ExecReload=/home/laodu/frpc/frpc reload -c /home/laodu/frpc/frpc.ini
```

拷贝到系统目录

`sudo cp ~/frpc/systemd/frpc.service /usr/lib/systemd/system/`

启动服务，并允许开机运行

```
sudo systemctl start frpc
sudo systemctl enable frpc
```

现在，外网可以正常访问

### 配置calibre数据

拷贝文件使用 scp 命令

`scp -vrC folder user@192.168.2.114:/home/user/`


---

参考：https://wiki.e7zl.com/index.php/231.html

---

- 时间：20220208

>>> 以下为旧内容：

---

## 服务器配置

1. 上网本安装 Ubuntu server，负责文件/照片/电子书。
1. PC负责电影

### 配置网络

1. 默认无线不能启动，`sudo vi /etc/network/interfaces`
1. 添加如下内容，其中 wlp2s0 是无线网卡名。

```
auto wlp2s0
iface wlp2s0 inet static
address 192.168.1.133
netmask 255.255.255.0
gateway 192.168.1.1
wpa-essid YOURWIFI
wpa-psk WIFIPASSWORD
dns-nameservers 202.99.160.68

```
1. 启动网卡 `sudo ifup -v wlp2s0`
1. 重启 `sudo /etc/init.d/networking restart`

### 配置SSH

1.安装 `sudo apt-get install openssh-server`

2.修改配置文件，位置在：etc/ssh/sshd_config

3.服务控制：`sudo /etc/init.d/ssh start|stop|restart`

4.登录服务器：`ssh username@192.168.1.133`，退出 `logout`

5.拷贝文件：`scp -r localfolder username@192.168.1.133:remotefolder`

### 配置Samba

1. 安装 `sudo apt-get install samba cifs-utils`
2. 设置目录：`sudo mkdir /home/share`
3. 修改权限：`sudo chmod 777 /home/share`
4. 修改配置文件，位置在：/etc/samba/smb.conf

#### 配置文件修改

1.保存现有文件 `sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak`

2.创建新文件 `sudo vi /etc/samba/smb.conf`

3.增加以下内容

````
[myshare]
      path = /home/share
      available = yes
      browsealbe = yes
      public = yes
      writable = yes
````

4.创建Samba账户，替换下面的yourusername，根据提示输入密码

````
sudo touch /etc/samba/smbpasswd
sudo smbpasswd -a yourusername
````

5.重启Samba `sudo /etc/init.d/samba restart`

6.测试连接 `smbclient -L //localhost/myshare`

7.其他

+ Linux计算机连接，使用 `ssh user@IP`，退出使用 `exit`
+ 拷贝文件夹 使用 cp -r 
+ Debian优盘没有写权限解决方法：https://askubuntu.com/questions/296331/how-to-mount-a-hard-disk-as-read-only-from-the-terminal 


### MediaTomb

[MediaTomb](http://mediatomb.cc/) 是支持 [UPnP](https://zh.wikipedia.org/zh-cn/UPnP) 的媒体服务端。

`sudo apt-get install mediatomb`

默认页面：`http://localhost:49152`，配置文件在：/etc/mediatomb/config.xml

* 测试中命令行启动正常，菜单点击启动失败
* web界面内可以制定媒体目录
* 可以定时扫描目录，便于跟下载配合

### aria2

[aria2](https://aria2.github.io/) 用来下载bt/磁力，配合 [webui-aria2](https://github.com/ziahamza/webui-aria2)，安装方法：

1. `apt-get install aria2`
2. 参考这篇配置脚本：[https://blog.ghostry.cn/server/746.html](https://blog.ghostry.cn/server/746.html)
3. 配合百度云下载

### qbittorrent

安装和运行 qbittorrent-nox ，本地8080端口，默认用户名admin，密码adminadmin (https://github.com/qbittorrent/qBittorrent/wiki/Running-qBittorrent-without-X-server)

### 播放端

### 安卓

1. VLC，直接可以访问MediaTomb和SMB
2. Es浏览器，访问SMB，图片/视频/文件

### iOS

1. VLC
1. AcePlayer，免费但有显示条数限制

### 其他

1. Arch linux 下安装 `gvfs-smb`，即可在 Thunar 中访问SMB，如 `smb://192.168.1.127/myshare/`
1. windows 下直接使用网上邻居
1. 投影仪DLNA功能，待测试

参考资料

* [Creating A Home Media & File Server With Ubuntu](https://www.howtoforge.com/creating-a-home-media-and-file-server-with-ubuntu)
* [Ubuntu下配置samba实现文件夹共享](http://www.cnblogs.com/phinecos/archive/2009/06/06/1497717.html)
* [知乎：自己家里搭建NAS服务器有什么好方案？](https://www.zhihu.com/question/21359049)
- [skylake架构DIY NAS 篇二：打造属于自己的私人云书库](http://post.smzdm.com/p/534074/p2/)
