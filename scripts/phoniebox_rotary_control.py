#!/usr/bin/python3
# -*- coding: iso-8859-15 -*-
# 1.0.24

#!/usr/bin/env python

import os
from RPi import GPIO
from KY040 import KY040
import os, time

def readVolume():
    value = os.popen("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=getvolume").read()
    return int(value)
def getBootVolume():
    bootvol = os.popen("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=getbootvolume").read()
    return int(bootvol)
def checkIfMuted():
    if readVolume() > 1: 
        return False
    else:
        return True
def rotaryChange(direction):
    volume_step = 5
    volume = readVolume()
    if direction == 1:
        os.system("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=setvolume -v="+str(min(100,max(0,volume + volume_step))))
    else:
        os.system("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=setvolume -v="+str(min(100,max(0,volume - volume_step))))
def switchPressed(pos):
    if checkIfMuted() == False:
        os.popen("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=mute")
    else:
        bootvol = getBootVolume()
        os.popen("sudo /home/pi/RPi-Jukebox-RFID/scripts/playout_controls.sh -c=setvolume -v="+str(bootvol)) 
 
if __name__ == "__main__":
 
    CLOCKPIN = 5
    DATAPIN = 6
    SWITCHPIN = 13

    GPIO.setmode(GPIO.BCM)
    
    ky040 = KY040(CLOCKPIN, DATAPIN, SWITCHPIN, rotaryChange, switchPressed)
 
    ky040.start()
 
    try:
        while True:
            time.sleep(0.05)
    finally:
        ky040.stop()
        GPIO.cleanup()