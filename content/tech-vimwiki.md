# vimwiki

## 介绍

主页：https://github.com/vimwiki/vimwiki

## 安装

使用了 Vundle 安装

## 使用

- \ww 打开wiki
- \wh 转换当前页面为HTML
- \whh 转换并在浏览器打开

## 感受

- 顺畅方便
- 输出到HTML迅速清晰，便于整理
- 多记录




## markdown支持

修改 vimrc ，加入如下内容：

```
let g:vimwiki_list = [{'path': '~/vimwiki/', "维基目录
  \ 'path_html': '~/vimwikihtml', "输出HTML目录
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'custom_wiki2html': '~/.vim/vimwiki2html.py'}] "自定义转换脚本

" 快捷键生成HTML
map <S-F4> :VimwikiAll2HTML<cr>
map <F4> :Vimwiki2HTML<cr>

```

默认不支持markdown格式转换，用[官方的脚本](https://github.com/vimwiki/vimwiki/blob/master/autoload/vimwiki/customwiki2html.sh)不能转换页面内md文件链接

用自定义脚本，需要：

- 安装 pandoc
- vimwiki2html.py 需要 chmod+x 可执行
- 脚本地址：https://github.com/vimwiki/vimwiki/issues/642

## 美化

可以修改上面py文件，pandoc可以指定css文件，但只能用绝对地址，只测试了本地使用。

## 转换脚本

```
#!/usr/bin/env python3

from os import path
import re
import shutil
import subprocess
import sys
import tempfile


def convert(
    force,
    syntax,
    extension,
    output_dir,
    input_file,
    css_file,
    template_path,
    template_default,
    template_ext,
    root_path,
    custom_args,
):
    if shutil.which("pandoc") is None:
        print("Error: pandoc not found", file=sys.stderr)
        sys.exit(1)

    if syntax != "markdown":
        print("Error: Unsupported syntax", file=sys.stderr)
        sys.exit(1)

    input_file_name = path.splitext(path.basename(input_file))[0]
    output_file = path.join(output_dir, input_file_name) + path.extsep + "html"

    with open(input_file, "r", encoding="utf8") as f:
        lines = f.read()

    lines = re.sub(r"\[([^]]+)\]\((.+)\)", repl, lines)

    # Look for title in metadata
    match = re.search(
        "^(?:---|\.\.\.)$\n.*title: ([^\n]+)$\n.*^(?:---|\.\.\.)$",
        lines,
        re.MULTILINE | re.DOTALL,
    )
    title = match.group(1) if match else input_file_name.title()

    template = path.join(template_path, template_default + path.extsep + template_ext)
    command = [
        "pandoc",
        "--section-divs",
        "--template={}".format(template) if path.isfile(template) else "",
        "-s",
		"-c /home/laodu/vimwikihtml/style.css",
        "--highlight-style=pygments",
        "--metadata",
        "pagetitle={}".format(title),
        custom_args if custom_args != "-" else "",
        "-f",
        "markdown",
        "-t",
        "html",
        "-o",
        output_file,
        "-",
    ]

    # Prune empty elements from command list
    command = list(filter(None, command))

    # Run command
    subprocess.run(command, check=True, encoding="utf8", input=lines)


def repl(match):
    link = path.splitext(match.group(2))[0] + ".html"
    return "[{}]({})".format(match.group(1), link)


if __name__ == "__main__":
    convert(*sys.argv[1:])


```
---

参考链接：
- https://xbeta.info/vimwiki.htm


---

20201207 创建
20201208 更新
