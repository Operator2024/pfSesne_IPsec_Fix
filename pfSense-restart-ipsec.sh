#!/bin/sh

fileName="ipsec-restart.txt"
fullPath=""

rc_start(){
    header="=== START $(eval date) TIME ==="
    echo $header > "$fullPath$fileName"
    echo "" >> "$fullPath$fileName"
    echo "Date was written to the file -> \"$fullPath$fileName\""
    echo "Now a two minute (120 secs) delay has begun!"
    
    TotalDelay=120
    OneTick=5
    TotalTicks=$(($TotalDelay/$OneTick))
    RemainingTicks=$TotalTicks
    while [ "$RemainingTicks" -gt 0 ]; do {

      _date="date \"+%D %H:%M:%S\""
      RemainingTicks=$(( RemainingTicks - 1 ))
      output="Remaining ticks - $RemainingTicks, $(eval ${_date})"

      echo $output >> "$fullPath$fileName"
      sleep $OneTick
    }
    done
    echo "pfSense restart ipsec 3 2 1 ... wait"
    echo "==== pfSsh.php playback command output ====" >> $fullPath$fileName
    cmd="pfSsh.php playback svc stop ipsec"
    echo $(eval ${cmd}) >> "$fullPath$fileName"
    echo "==== pfSsh.php playback command output end ====" >> $fullPath$fileName
    echo "" >> $fullPath$fileName
    footer="=== END $(eval date) TIME ==="
    echo $footer >> "$fullPath$fileName"
}

rc_info(){
  echo "$1 command doesn't exist, only - start"
}

case $1 in
        start)
              rc_start
            ;;
        stop)
              rc_info
            ;;
        status)
              rc_info
            ;;
        *)
          echo "Re-run script with 'start' flag!, ex. yourscriptname.sh start"
esac

