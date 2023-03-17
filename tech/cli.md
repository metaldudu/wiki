---
title: CLI
date: 2023-01-03
---

## 常用工具

### 显示主机信息

neofetch [https://github.com/dylanaraps/neofetch](https://github.com/dylanaraps/neofetch)

### 显示天气

ansiweather [https://github.com/fcambus/ansiweather](https://github.com/fcambus/ansiweather)

### 显示时钟

tty-clock，大字体、多种颜色 [https://github.com/xorg62/tty-clock](https://github.com/xorg62/tty-clock)

### 显示音乐波动

cava [https://github.com/karlstav/cava](https://github.com/karlstav/cava)

### 词典

cambrinary，查询剑桥在线词典 [https://github.com/xueyuanl/cambrinary](https://github.com/xueyuanl/cambrinary)

### RSS阅读器

newsboat [https://github.com/newsboat/newsboat](https://github.com/newsboat/newsboat)

## 音乐

cmus [https://github.com/cmus/cmus](https://github.com/cmus/cmus)

### 音乐转换处理

参考[wiki](https://wiki.archlinux.org/title/CUE_Splitting) ，安装 shntool `yay -S shntool`

分割音频文件为flac ，注意 cue 文件编码为 UTF-8

`shnsplit -f CDImage.cue -t "%n - %t" -o flac CDImage.wav`

如果操作ape文件需要装 mac `yay -S mac`

## 重命名

### rename重命名

`rename`命令，archlinux的版本是C语言的，man查看例子：`rename .htm .html *.htm`

perl版本的rename 支持正则匹配，C版本不行

### 批量添加扩展名

`for f in *; do mv "$f" "$f.mp3"; done`

### 按照001/002这样排序：

`for f in *; do mv "$f" "00$f"; done`

### 把空格替换成.

`for f in *; do mv -i "$f" "${f// /.}"; done`

