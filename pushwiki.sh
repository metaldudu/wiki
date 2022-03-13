#!/bin/bash

bash md2html.sh

git add .
git commit -m “update wiki”
git push origin main
