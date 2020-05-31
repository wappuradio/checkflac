#!/usr/local/bin/bash
tail -f "/home/wappuradio/irc/192.98.101.230/#radiontoimitus/out" | \
    while read -r time nick mesg; do
    	regex='^(<.*> )?!kanta levyt$'
	#echo "$mesg"
        if [[ "$mesg" =~ $regex ]]; then
          dbcount=$(awk '{print $1}' < /home/flac/dbcount.txt)
          hddspace=$(df -h|grep upload|awk '{print $3 "/" $2}')
          discs=$(find /home/wappuradio/db -type d -not -name CD1 2>/dev/null|wc -l)
          echo "/notice #radiontoimitus :$dbcount albums, $discs discs, hdd space $hddspace"
        fi
    done > "/home/wappuradio/irc/192.98.101.230/#radiontoimitus/in"
