#!/bin/bash/

git checkout master
git branch -D gh-pages
git checkout -b gh-pages
git filter-branch --subdirectory-filter _site/ -f
git checkout smaster
git push --all origin