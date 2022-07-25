 # GPS logging using Teltonika devices
 Scrip to track your Teltonika device within your private nextcloud (phonetrack app)<br>

 ## Installation
 Login via ssh<br>
 ```
 curl https://raw.githubusercontent.com/f-io/RUTX-GPS/main/gps_nextcloud.sh --output /root/gps_nextcloud.sh
 ```

 Change (vi) these parameters to your needs<br>
 ```
 URL,SESSION,NAME,DELAY                                         
 ```

 Make the script executeable<br>
 ```
 chmod a+x /root/gps_nextcloud.sh
 ```

 Add this line (vi) at the end of your /etc/rc.local<br>
 ```
 /root/gps_nextcloud.sh &
 ```
 Example rc.local

 ```
 # Put your custom commands here that should be executed once
 # the system init finished. By default this file does nothing.
 /root/gps_nextcloud.sh &
 exit 0
 ```
 ## Tested devices

 | Device | Firmware |
 |-|-|
 |RUTX11|RUTX_R_00.07.02.2|

 ###
 Based on https://github.com/G4Cab/TeltonikaNMEAlogger
