#!/bin/bash
# this runs as a @reboot cron task
#run
# cronetab -e
# @reboot bash /home/pi/power-on-server.sh > power-on-server.log
# requires etherwake and wakeonlan (apt-get)

PING="/bin/ping -q -c1"
HOST=192.168.0.20
WAITTIME=10
HOSTISUP=true

### functions

function wake_up() {
wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address

wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address

wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address

wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address

wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address

wakeonlan mac.address
wakeonlan -p 9 mac.address
sudo etherwake mac.address
}


# first sleep to allow system to connect to network and time to break out if needed
sleep 60

while [ ${HOSTISUP}  ]
do
        ${PING} ${HOST} > /dev/null
        if [ $? -ne 0 ]; then
                echo "${HOST} is down $(date)"
		# try to wake
		wake_up
		sleep 10
                wake_up
		sleep 10
                wake_up
                sleep 10
                wake_up
                sleep 10
		#restart networking
		/etc/init.d/networking reload
		sleep 15
		# try to wake
                wake_up
                sleep 2
                wake_up
                sleep 2
		# rebooting
		echo "Pi is rebooting"
		/sbin/shutdown -r now
        fi
        sleep $WAITTIME
	echo "${HOST} is up $(date)"
done
