#!/usr/local/bin/bash
tail -f "/home/wappuradio/irc/192.98.101.230/#radiontoimitus/out" | \
    while read -r time nick mesg; do
	#echo "$mesg"
        if [[ "$mesg" = "!kanta levyt" ]]; then
          dbcount=$(cat /home/flac/dbcount.txt|cut -d ' ' -f 5)
          dfused=$(df -h |grep upload |cut -d ' ' -f 9)
          dftotal=$(df -h |grep upload |cut -d ' ' -f 5)
          finddirs=$(find /home/wappuradio/db -type d 2>/dev/null|wc -l)
          discs=0
          let "discs = $dbcount + ($finddirs - $dbcount)"
          echo "/notice #radiontoimitus :$dbcount albums, $discs discs, hdd space $dfused/$dftotal"
        fi
    done > "/home/wappuradio/irc/192.98.101.230/#radiontoimitus/in"
