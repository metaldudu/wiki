
## youtube-dl

下载在线视频或youtube上的音频

`youtube-dl -F --proxy socks5://127.0.0.1:1080 https://www.youtube.com/watch?v=d-diB65scQU`

- -F 列出所有格式
- -f 140 一般m4a格式
- --proxy 代理
- --playlist-start 33 --playlist-end 35 下载playlist指定部分
-  -o '%(title).60s.%(ext)s' 截取标题一部分并重命名