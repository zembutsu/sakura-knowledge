#!/bin/sh

### Whois Expire Checker
### MIT License
### Masahito Zembutsu <github.com/zembutsu>


### Variables
DOMAIN="pocketstudio.net"
NOTICE="30"
CHECK="/usr/share/nginx/html/check_whois-tld.dat"

# whois and calcurate
EXPIRE_DATE=`date '+%s' -d \`whois $DOMAIN | grep "Registrar Registration Expiration Date" | awk '{print $5}'\``

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
