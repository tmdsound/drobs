#!/bin/bash/

git checkout source
git branch -D master
git checkout -b master
git filter-branch --subdirectory-filter _site/ -f
git branch -D gh-pages
git checkout -b gh-pages
git checkout source
git push --all origin -f