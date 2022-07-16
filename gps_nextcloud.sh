#!/bin/sh

# nextcloud url 
URL="https://nextcloud.com"                
                                          
# put your Session ID in here             
SESSION="SESSION_ID"

# put your device name in here            
NAME="DEVICE_NAME"                            
                                          
# log file for offline logging              
OFFLINELOGFILE="/tmp/offline.log"         
                                 
# update delay in seconds
DELAY=5                                   
                                          
while :                                   
  do                                      
    FIX=$(/usr/sbin/gpsctl -s)  # get GPS status
    if [ $FIX = "1" ]           # if GPS signal is present
        then                                       
                LAT=$(/usr/sbin/gpsctl -i) # get latitude
                if [ "$LAT" != "$LATOLD" ] # check if new latitude is different from old latitude
                then                                                                             
                        LATOLD=$LAT # set old latitude to new one                                
                        SPD=$(/usr/sbin/gpsctl -v) # get ground speed                            
                        LON=$(/usr/sbin/gpsctl -x) # get longitude                               
                        SAT=$(/usr/sbin/gpsctl -p) # get connected sattelites                    
                        ALT=$(/usr/sbin/gpsctl -a) # get altitude                                
                        ACC=$(/usr/sbin/gpsctl -u) # get accuracy            
                        TIMESTAMP=$(/usr/sbin/gpsctl -t) # get gps timestamp 
                        GPSResults="$URL/apps/phonetrack/log/gpslogger/$SESSION/$NAME?lat=$LAT&lon=$LON&sat=$SAT&alt=$ALT&acc=$ACC&speed=$SPD&timestamp=$TIMESTAMP"
                        DataCheck=$(ip addr show wwan0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)                                                           
                        ip_full=$(echo $DataCheck | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])') # validate IP         
                        if [ $ip_full != "" ] #If Valid IP                                                                                                         
                        then                                                                                                                                       
                                curl --insecure ${GPSResults// /} # send data to nextcloud                                                                          
                                if [ -f $OFFLINELOGFILE ] # if file exists                                                                                          
                                then                                                                                                                      
                                        while IFS= read -r line                                                                                           
                                        do                                               
                                                curl -k $line                            
                                        done <"$OFFLINELOGFILE"                          
                                        rm $OFFLINELOGFILE # remove file                  
                                fi                                       
                        else                                             
                                echo ${GPSResults// /} >> $OFFLINELOGFILE # log GPS data in file
                        fi                                                                      
                fi                                                                              
    fi                                                                                          
  sleep $DELAY                                                                                  
 done 
