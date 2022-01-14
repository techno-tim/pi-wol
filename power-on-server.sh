#!/bin/bash
# this runs as a @hourly cron task
#run
# cronetab -e
# @hourly bash /home/pi/power-on-server.sh > power-on-server.log
# requires etherwake and wakeonlan (apt-get)
# installed etherwake and wakeonlan beacuse I had some issues with one or the other between updates, so I added both

HOSTNUM=0
HOSTS=(192.168.0.1 192.168.0.2 192.168.0.3)
HOSTSDOWN=0
MACADDRS=(mac.address.1 mac.address.2 mac.address.3)
PING="/bin/ping -q -c1"
WAITTIME=10

### functions

function wake_up() {
  echo wakeonlan ${MACADDRS[${HOSTNUM}]}
  echo wakeonlan -p 9 ${MACADDRS[${HOSTNUM}]}
  echo sudo etherwake ${MACADDRS[${HOSTNUM}]}
}

# first sleep to allow system to connect to network and time to break out if needed
#sleep 60

for HOST in ${HOSTS[*]}; do
  if ! ${PING} ${HOST} > /dev/null
  then
    HOSTSDOWN=$((${HOSTSDOWN}+1))
    echo "${HOST} is down $(date)"
    # try to wake
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    wake_up ${HOSTNUM}
    sleep 10
    #restart networking
    /etc/init.d/networking reload
    sleep 15
    # try to wake
    wake_up ${HOSTNUM}
    sleep 2
    wake_up ${HOSTNUM}
    sleep 2
    HOSTNUM=$(($HOSTNUM+1))
  else
    echo "${HOST} was up at $(date)"
  fi
done

# reboot
if [[ ${HOSTSDOWN} -eq ${#HOSTS[@]} ]]
then
  echo "Pi is rebooting"
  /sbin/shutdown -r now
fi

