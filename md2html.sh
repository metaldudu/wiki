#!/bin/bash
# 20220312


cd content
for i in *.md ; do pandoc -s $i -o ${i%.*}.html --css ../wikicss.css ; done

cd ..


# 转换主页
cp index.md index_tmp.md

sed -i 's/.md)/.html)/g' index_tmp.md
pandoc -s index_tmp.md -o index.html --css wikicss.css
rm -f index_tmp.md