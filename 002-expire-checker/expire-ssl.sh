#!/bin/sh

### SSL Expire Checker
### MIT License
### Masahito Zembutsu <github.com/zembutsu>


### Variables
HOST="secure.zem.jp"
PORT="443"
NOTICE="30"
CHECK="/usr/share/nginx/html/check_ssl.dat"

# fetch ssl certificate and calcurate
EXPIRE_DATE=`date '+%s' -d "\` echo | \
        openssl s_client -connect $HOST:$PORT -showcerts  2>/dev/null | \
        openssl x509 -noout -dates | \
        grep notAfter | \
        sed 's/notAfter=//' \`"`
# how many days to expire
EXPIRE=$((($EXPIRE_DATE-`date '+%s'`)/86400))

# left days
DIFF=$(($EXPIRE-$NOTICE))

if [ $DIFF -gt 0 ];  then
        # ok
        echo $EXPIRE > $CHECK
else
        # notice
        if [ -e $CHECK ]; then
                rm -f $CHECK
        fi
fi
