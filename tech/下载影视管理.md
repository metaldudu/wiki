---
title: 下载影视管理
date: 2022-12-04
---

# 下载影视管理

## youtube-dl

下载在线视频或youtube上的音频。~~速度太慢弃了~~ 可以下载 m3u 地址。

`youtube-dl -F --proxy socks5://127.0.0.1:1087 https://www.youtube.com/watch?v=JbUMcGCagN8`

- -F 列出所有格式
- -f 140 一般m4a格式
- --proxy 代理
- --playlist-start 33 --playlist-end 35 下载playlist指定部分
- -o '%(title).60s.%(ext)s' 截取标题前60个字符并重命名

## yt-dlp

速度稳定，参数可看帮助

`yt-dlp --proxy socks5://127.0.0.1:1080 https://www.youtube.com/watch?v=e_p_l9jIi5M`

## lux

b站下载神器。 https://github.com/iawia002/lux

## Jellyfin

- Server端安装，可以直接web播放。配置刮削影片信息。注册 opensubtitles 并获取API，可以抓取字幕
- Windows 有桌面客户端 [https://github.com/jellyfin/jellyfin-media-player](https://github.com/jellyfin/jellyfin-media-player) 
- 安装插件：[Kodi Sync Quene](https://repo.jellyfin.org/releases/plugin/kodi-sync-queue/) 配合 Kodi 同步

## Tiny Meida Manager

- 需要注册 themoviedb.org 的api，但被墙，所以需要修改host。[https://dnschecker.org/#A/themoviedb.org ](https://dnschecker.org/#A/themoviedb.org) 可以查询可用IP
- 刮削生成 nfo 文件到本地，可以方便其他播放器使用

## Kodi

- Win/Linux 安装，支持手柄操作
- 安装 jellyfin 插件  https://repo.jellyfin.org/releases/client/kodi/repository.jellyfin.kodi.zip
- 电视盒安卓版本4.4，找到一个解决方案 https://www.cnblogs.com/turingguo/p/15517481.html 
- 安装 zimukux 插件，需要在arch源里安装 `kodi-addon-vfs-rar-git` 


## 手机端

- Jellyfin 安卓客户端 https://f-droid.org/en/packages/org.jellyfin.mobile/ 

## XSS

- XSS 商店里的 kodi 功能有限，但可以用 samba 或者 nfs 共享方式。
- nfs 据说比较稳定，win下用这个工具 [haneWIN NFS Server
for Windows](https://www.hanewin.net/nfs-e.htm) 免费一个月

## 极米Z4X

- 安卓4.3，刷了精简包也无法安装 Jellyfin 和 Kodi 客户端，只能通过 DLNA 投屏，但软字幕无法显示。
- 当贝市场安装了 MXplayer ，解决了极米内置视频播放器字幕编码的问题。用插U盘方式播放。


## 视频囤积的几个思路


### 1. 付费会员

，几大平台年费都有促销，但往往要多个会员才行。网飞这样在外面，需要手段。豆瓣条目下面可以显示哪个平台可以播放，很方便。

### 2. 热门资源

BT或磁力直接下载。压制组要吃饭所以广告越来越多，不能忍的话，就找上游的种子配字幕。

### 3. 冷门资源

微博可能有人打包收集，网盘居多。走迅雷、百度云会员等等。

### 4. 大网站

有些视频可能过段时间就被删了，或者离线观看更方便。[youtube-dl ](https://youtube-dl.org/)/ [annie](https://github.com/iawia002/annie) 等命令行工具好用。flv格式可以转mp4，用ffmpeg很方便。youtube工具更多。如果不用命令行，可以用：

- b站下载助手：https://csser.top/
- https://weibo.iiilab.com/
- http://www.flvcd.com/

### 5. 小网站

带澳门赌场硬广告。直接可以找到视频地址的，在线播放或axel下载；m3u8格式的，查看源码找到m3u8地址，用youtube-dl下载。可能会用到类似“Stream Video Downloader”这样的Chrome扩展。

### 6. 搜索

多用搜索引擎，无论是找资源还是找方法。

---

### 参考：

- [https://post.smzdm.com/p/a99vlpmp/](https://post.smzdm.com/p/a99vlpmp/)
- [https://igloo302.github.io/2020/724-jellyfin-kodi打造个人媒体中心/](https://igloo302.github.io/2020/724-jellyfin-kodi打造个人媒体中心/)