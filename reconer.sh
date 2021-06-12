#!/usr/bin/bash

gau -subs $1 >> $1 &
assetfinder $1 | grep -E '*' | waybackurls >> $1 &
waybackurls $1 >> $1 &
assetfinder $1 | sort | uniq | httpx -silent >> asset.$1 & #1 nuclei
wait

cat $1 | sort | uniq | httpx -silent >> httpx.$1 #2 corsfinder
rm $1

cat httpx.$1 | qsreplace 'xsst"><>' >> xss.$1 #3 xssfinder
