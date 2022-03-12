# arch软件与优化

### 系统安装

按照wiki走一遍，不行就再来一遍。有可能踩坑：

- 和win10共享ESP分区的话，100Mb 不够用，而且win10更新会导致 grub 错误。建议扩大 ESP 分区
- 命令行状态下要装好网络包
- 自动挂载移动硬盘和U盘，安装 `ntfs-3g udevil` ，同时当前用户要增加权限

### 字体

查看中文字体： `fc-list :lang=zh` 可以看到字体名，便于配置软件

- 等宽字体： `pacman -S ttf-dejavu`
- emoji： `noto-fonts-emoji`
- 谷歌东亚字体：`noto-fonts-cjk`
- 文泉驿微米黑：`wqy-microhei`
- 思源宋体和黑体： adobe-source-han-serif-cn-fonts 和 adobe-source-han-sans-cn-fonts
- 简体中文等距更纱黑体+Nerd图标字体库。 `yay -S nerd-fonts-sarasa-mono`

### XFCE4

声音：安装 alsa-utils 和  pulseaudio。安装　`xfce4-pulseaudio-plugin` ，面板添加音量图标，安装 pavucontrol 控制音频输出。

主题： arc-gtk-theme 图标： papirus-icon-theme

配置桌面快捷键：

- 窗口移动：win+方向键
- 隐藏所有窗口：win+D
- 启动器：win+1
- 截图：flameshot gui > win+3

壁纸位置在：~/.local/share/xfce4/backdrops/

###  网络

查询本机ip： `$curl ipinfo.io`

### 启动

Uluancher https://ulauncher.io/　，简单高效。无论用哪个平台都应该又一款趁手的启动器。

### 文件管理

解压缩：xarchive ，文件搜索：catfish

### 浏览器

Chrome 同步难但易用，Firefox 在我这里总有小问题。

### 输入法

选择 fcitx5 和 rime ，使用：

- 四叶草拼音方案 https://github.com/fkxxyz/rime-cloverpinyin
- 皮肤 https://github.com/hosxy/Fcitx5-Material-Color

比起默认的拼音更适合简体中文用户。一些tips

- shift+空格 切换全角/半角

### 图片

编辑器用 GIMP，用惯了也还好。看图用 ristretto ，看漫画可以用 MComix 或 Foliate。截图用火焰截图 [Flameshot](https://github.com/lupoDharkael/flameshot) ，截图可以绑定快捷键到 `flameshot gui`

### 影音

MPV 主力播放， VLC 可以看网络直播流，也适合播放整个文件夹。音乐播放用 Audacious ，需要编辑音乐信息装一个 Kid3。听在线音乐可以用 [Listen 1 音乐播放器](https://listen1.github.io/listen1/) 。录音用 yAudacity。


#### mpv显示两个字幕

mpv some-video.mp4 --sub-file=sub1.srt --sub-file=sub2.srt --secondary-sid=2

在线工具合并两个字幕： https://easypronunciation.com/zh/merge-two-subtitle-files-online

mpv调整字幕大小，在 ~/.config/mpv/input.conf 加入：
```
# increase subtitle font size
ALT+k add sub-scale +0.1

# decrease subtitle font size
ALT+j add sub-scale -0.1
```


### 电子书

Calibre 安装好，导入书库。需要编辑epub 可以安装 Sigil，有打包电子书的需要装 pandoc 

pdf浏览就装 Evince ，剪裁工具 [krop](http://arminstraub.com/software/krop) 

### 编辑器

Typora 收费后，直接全部用 Obsidian 解决笔记问题，markdown无敌。单个文件用系统自带的 mousepad 打开。WPS 或者用在线文档对付msoffice格式。

### RSS

 [Liferea](https://lzone.de/liferea/) ，本地浏览够用了。

### 下载

wget  / [annie](https://github.com/iawia002/annie) / youtube-dl / qbittorrent  / [AriaNg](https://github.com/mayswind/AriaNg)

阿里云推荐用：阿里云盘小白羊版 https://github.com/liupan1890/aliyunpan

### 即时通讯

微信，尝试了几种包括统信UOS 版，现在使用web版凑合，使用率并不高。可以用下面命令开一个独立窗口。google-chrome-stable --new-window --app=https://wx.qq.com

### 网盘

坚果云强制关联 markdown 格式弃用。改用 syncthing ，配合GUI工具：https://github.com/Martchus/syncthingtray

### 外语学习

GoldenDict 配合词库。anki 要安装 aniki-bin ，否则插件可能版本不匹配。

### SSH and git

- 安装 openssh git
- 创建本地ssh key：` ssh-keygen -t rsa -C "youremail@example.com"`
- 复制 `~.ssh/id_rsa.pub` 内容到github-Account settings-SSH Keys，Title随意
- 配置git，参考：https://www.runoob.com/w3cnote/git-guide.html

### 其他问题

#### 浏览器无法打开telegram 链接

``~/.local/share/applications` 找到 userapp-Telegram Desktop-xxxx.desktop ,在文件的最后添加一行：

`MimeType=application/x-xdg-protocol-tg;x-scheme-handler/tg;`

#### pacman错误

invalid pgp key错误解决 : `$ sudo pacman-key --refresh-keys`

pacman -Syu 升级系统
pacman -Syy 同步软件列表
pacman -Scc 清理软件包
pacman -S xxx 安装
pacman -Ss xxx 查询
pacman -R xxx 卸载
pacman -Qs xxx 查询已安装包

#### 环境变量

编辑 `~/.bashrc`，加入

`export PATH=$PATH:/somepath`

## old


---

### 电源

编辑： /etc/systemd/logind.conf 加入以下两行，实现笔记本合盖挂起系统：

    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=suspend

然后执行：`systemctl restart systemd-logind`


使用xfce后默认锁屏是xfce4-screensaver，调用 xflock4，黑屏无提示。卸载掉 xfce4-screensaver ，安装 

`sudo pacman -S light-locker`
`yay light-locker-settings`

然后在 设置>配置编辑器>xfce4-session>general>LockCommand 加入

`light-locker-command --lock`

则可以使用 ctrl+alt +L 锁定，返回 lightdm登录界面。可以安装 lightdm-gtk-greeter-settings 进一步美化登录界面。



## 软件


### Syncthing

- 安装 syncthing / syncthing-gtk
- 加入服务： `sudo systemctl enable syncthing@laodu.service`
- 启动服务： `sudo systemctl start syncthing@laodu.service`
- 本机地址： http://127.0.0.1:8384/




---

## 结语

奥卡姆剃刀原则说：如无必要、勿增实体。够用好用，还要怎样？

- 20191029 创建
- 20220304 更新