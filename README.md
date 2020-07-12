# pi-wol

## install

`sudo apt-get install etherwake`

`sudo apt-get install wakeonlan`

## cron job

`cronetab -e`

`@reboot bash /home/pi/power-on-server.sh > power-on-server.log`

requires etherwake and wakeonlan (apt-get)

Installed `etherwake` and `wakeonlan` beacuse I had some issues with one or the other between updates, so I added both so that I don't have to worry when updating.
