# -*- coding: utf-8 -*- 
#!/usr/bin/python3

#https://www.framboise314.fr/controle-dun-dispositif-basse-tension-via-raspberry-pi-et-un-relais/
#on lance le script avec: sudo python3 test_led.py ou on le rend exécutable et lexécuter avec sudo
# voir ce lien pour trouver la correspondance entre les pins de la biblio de wiring pi (name) et celles écrites sur la carte de forme T (BCM GPIO)
#http://wiringpi.com/pins/

import RPi.GPIO as gpio
import time
from signal import signal, SIGINT
from sys import exit

import subprocess

#rfPath ="/home/pi/sirene/v2/tmp/pipeLCD" #"/root/sir/v2/tmp/pipeLCD" # "/tmp/pipeLCD"    /home/pi/sirene/v2/
#rfPath ="/dev/shm/pipeLCD" #"/root/sir/v2/tmp/pipeLCD" # "/tmp/pipeLCD"    /home/pi/sirene/v2/

#projectPath="/home/pi/sirene/v2"

def handler(signal_received, frame):
    # on gère un cleanup propre
    print('')
    print('SIGINT or CTRL-C detected. Exiting gracefully')
    gpio.cleanup()
    exit(0)
#def writeToLCD(lineNumber, centering, text, display):
#    wp = open(rfPath, 'w')
#    wp.write("{0},{1},{2},{3}".format(lineNumber,centering,text,display))	
    #print("{0},{1},{2},{3}".format(lineNumber,centering,text,display))	
#    wp.close()

def main():
    sireneRelay1Pin=14 #23
    gpio.setmode(gpio.BCM)
    # defini le port GPIO 4 comme etant une sortie output
    gpio.setup(sireneRelay1Pin, gpio.OUT)
    # Mise a 1 pendant 2 secondes puis 0 pendant 2 seconde
    #print("sirene on")
    #time.sleep(0.3)
    #writeToLCD(3,2,"",1)	
    #time.sleep(0.3)

    #subprocess.run ( [ f"{projectPath}/sir_log/generalLogger.sh", "lancer_sirene.py" , "début lancement sirene "] )

    #writeToLCD(4,2,"lancement sirene",1)	
    #time.sleep(60)
	
    gpio.output(sireneRelay1Pin, gpio.HIGH)
    time.sleep(10)
    #print("off")
    gpio.output(sireneRelay1Pin, gpio.LOW)
    time.sleep(1)
    gpio.output(sireneRelay1Pin, gpio.HIGH)

    #print("sirene off")
    #subprocess.run ( [ f"{projectPath}/sir_log/generalLogger.sh", "lancer_sirene.py" , "fin lancement sirene "] )

    #time.sleep(1)

    gpio.cleanup()

    #time.sleep(2)
    #writeToLCD(4,2,"",1)	

if __name__ == '__main__':
    # On prévient Python d'utiliser la method handler quand un signal SIGINT est reçu
    signal(SIGINT, handler)
    main()

