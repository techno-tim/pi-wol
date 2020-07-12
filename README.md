# pi-wol

It’s the hail Mary of wake on lan commands for my raspberry pi / pi zero.

I use this to ping my servers and wake them up if they are off.  They should never be.

## install

`sudo apt-get install etherwake`

`sudo apt-get install wakeonlan`

## cron job

`cronetab -e`

`@reboot bash /home/pi/power-on-server.sh > power-on-server.log`
(will run at reboot and will pipe out logs)

Requires `etherwake` and `wakeonlan` (apt-get).

Installed `etherwake` and `wakeonlan` beacuse I had some issues with one or the other between updates, so I added both so that I don't have to worry when updating.
