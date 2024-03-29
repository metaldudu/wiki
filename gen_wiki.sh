#!/bin/bash
# 20220312

#  转换wiki页
# cd content
for dir in `ls .`
 do
   if [ -d $dir ]
   then
     echo $dir
     cd $dir
     for i in *.md ; do pandoc -s $i -o ${i%.*}.html --css ../assets/wikicss.css --template ../assets/template.html; done
     
     cd ..
   fi
done
# cd ..

# credit: https://github.com/sunxvming/blog_mdwiki
python makeindex.py

# 转换并处理主页
cp index.md index_tmp.md
sed -i 's/.md)/.html)/g' index_tmp.md #修订链接
# sed -i '$d' index_tmp.md #删除最后一行
# d=`date +%Y-%m-%d` #日期格式
# sed -i '$a '$d index_tmp.md #添加日期到最后一行

# 转换主页
pandoc -s index_tmp.md -o index.html --metadata title="LAODU WIKI" --css assets/wikicss.css 
# sed -i 's/.html">/.html" target="frame-right">/g' index.html #增加iframe链接
rm -f index_tmp.md
echo "finish!"

