# 电子书相关

## 工具

- 管理工具：Calibre
- 编辑器：Sigil / Pandoc 
- [EasyPub](http://www.hi-pda.com/forum/viewthread.php?tid=645717) windows下的txt转换工具，最新版 v1.50
- 阅读器：桌面平台用 Calibre 内置阅读器，或者 kindle。安卓平台推荐 [静读天下 Moon+ Reader](https://moondownload.com/chinese.html) : 排版优秀、支持格式丰富，支持OPDS

## Calibre

### 传输

1. Calibre 点击“连接/共享”图标，支持web访问，或者 OPDS 服务
2. 配置邮件，通过邮箱推送t到kindle，[配置方法教程](https://bookfere.com/tools#calibre) 实测 azw3 格式才能良好支持字体，不能通过邮件推送
3. usb连接，kindle、手机都可以识别

### 插件

- EpubSplit - 分割epub电子书，适合对合集电子书拆分
- Find Duplicate - 清理重复电子书
- DeDRM - 移除DRM（数字版权保护），购买正版书后可以去除保护并编辑修改

### calibre-web

[calibre-web](https://github.com/janeczku/calibre-web) 可以使用Calibre 生成的数据库和电子书文件，发布成在线图书馆，通过浏览器或OPDS服务访问。

## epub制作

### 文本来源

- txt
- 网页抓取
- OCR：ABBYY FineReader / [百度AI](https://cloud.baidu.com/product/ocr/general)

### 正则表达式

使用正则表达式来修改txt文档。以vscode为例：

- 替换“第一章”为“## 第一章”，替换`(第.*章)` 为 `## $1`
- 换行后插入空白行，替换`\n` 为 `\n\n`
- 匹配数字开头的行：`^[0-9][\s\S]*` 或 `^[0-9]+.*`
- 非负整数 \d+
- 以“aaa”开始的行 ^aaa.*$
- 以“aaa”结尾的行 .*aaa$

文档：[Regular Expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions)

### Siglil 的正则替换

Sigil 编辑 epub 要比 Calibre 编辑器好用，我常用它来去广告，或者处理合集 epub 拆开后的文件。

原文用小括号，替换用/1/2。例子：

	<p height="2em" width="2em" align="justify"><font size="4">(.*)</font></p>
	<h3>\1</h3>
	
## 转换格式

- calibre 的命令行模式：`ebook-convert "book.epub" "book.mobi"`
- kindlegen ，某些epub用 calibre 转换会失败

### 使用pandoc转换文档

pandoc可以方便的生成带有目录的epub文档，以修改的好的markdown文本文档进行转换，例如

`pandoc 1.md -o 1.epub`

### 自写的python脚本

- [txt2md.py](https://github.com/metaldudu/py/blob/master/txt2md.py)
- [md2epub.py](https://github.com/metaldudu/py/blob/master/md2epub.py)

### 修正编码

显示编码： `fiel -i 1.txt` ，或者安装 enca

- 显示编码： `enca 1.txt`
- 转换成UTF-8： `enca -x UTF-8 1.txt`
- 转换多个文件： `enca -x UTF-8 *`
- 另存： `enca -x UTF-8 <1.txt> 2.txt`
- 最好指定定语言： `enca -L zh_CN -x UTF-8 1.txt`


### 封面图片

图片大小：1570 x 2500

## 漫画
[Tachiyomi](https://tachiyomi.org/) ：漫画神器


---

- 20170307 建立
- 20210313 更新
