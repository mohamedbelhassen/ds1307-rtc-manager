## Description

"Raspberry-pi-rtc-management-web-app" is free open source project which let you easily set the date and time of your Raspberry Pi and persisting the date/time in the connected Real Time Clock (RTC) Module.

Note: This app could be used to test if the your raspberry Pi fan (connected to GPIO and not directly connected to VCC) is working or not by the means of a test button.

# impotant infos:

This web app is tested with the  DS 1307 RTC module. But, normally, it should work with any RTC model. 

The steps required to connect and configure the used RTC Module are out the scope of this help file. But, we will point out some links to useful tutorials dedicated to DS 1307 RTC module.

The steps required to connect and configure the Raspberry Pi fans are out the scope of this help file. 
But, we will point out some info/links to useful tutorials permitting to show you how to achieve this.
To make your Raspberry Pi device able to automatically activate the fan using a dedicated GPIO pin, just activate the fan control using the raspi-config command then wire your fan as it is shown in the following tutorial:
https://howchoo.com/pi/control-raspberry-pi-fan-temperature-python/ 

To be able to execute this app without requiring an infrastructure based wifi connection, you will need to install and configure "RaspAp" (https://raspap.com/) which let you easily transform your raspberry pi info an access point which will expose the instelled webapp to either mobile or desktop users.

## Prerequisities

Since this web app is based on NestJS, to run it, you have to install Node. 

Node 18 could be installed using the follozing tutorial:
https://pimylifeup.com/raspberry-pi-nodejs/

Instead of npm package manager, we will use yarn, so just install yarn (without node) as depicted in the following tutorial:
https://lindevs.com/install-yarn-on-raspberry-pi

## Installation

-Step 1: To clone this app, navigate to your raspberry pi home folder (/home/pi), then clone the app repository using the following command :

```bash
$ git clone https://github.com/mohamedbelhassen/raspberry-pi-rtc-management-web-app.git
```

-Step 2: rename the cloned app folder (recommended but optional step)
To shorten the app folder name, just execute the following command while changing the folder name (ds1307-rtc-manage) to what ever suit you:
 
```bash
$ mv raspberry-pi-rtc-management-web-app ds1307-rtc-manager
```

-Step 3: change the path of your app used in the web app code. Just open the app.controller.ts file using the following command:

```bash
$ cd /home/pi/ds1307-rtc-manager
$ nano src/app.controller.ts
```
then, update the following lines to reflect the used folders paths:
```js
const piUserHomeFolderPath = '/home/pi/';  //this is the path to the root folder in which you cloned the app 
const appFolder = 'ds1307-rtc-manager/';   //this is the name of the cloned app folder (after renamig it)
```

-Step 4: Install the app dependencies:
 
```bash
$ yarn install
```

-Step 5: Running the app (for development or demo)

To run the app, just use one of the three commands depending on your needs:

```bash
# development
$ yarn run start

# watch mode
$ yarn run start:dev

# production mode
$ yarn run start:prod
```

-Step 6: Open the web app in the Raspberry Pi browser:

Once installed, configured, and started, you can browse the app in the following URL: 
http://localhost:3000

If you have well installed and configured RaspAp, you can browse the webapp from your mobile phone (or desktop ) connected to the created access point (by default it is called raspi-webgui) using the following address:
http://10.3.141.1:3000

The default password of the created access point is: ChangeMe. 

It is recommended to change this password through the RaspAp Web app. To access the RaspAp Dashboard, use the following link/credentials:

IP address: 10.3.141.1   --> http://10.3.141.1:4040/
Username: admin
Password: secret 

## Auto start the app when rebooting your Raspberry Pi 

After being sure that the app is well started (Step 1 to 6 completed successfully), we need to request the system to automatically start the web app after rebooting. To do so, we just need to add the following line to the Pi user crontab. To do so, execute the following commands:
```bash
$ cronatb -e 
```
then, in your text editor, browse to the last line and add the following line:

```bash
@reboot cd /home/pi/ds1307-rtc-manager; /usr/bin/yarn run start:prod 2>/home/pi/ds1307-rtc-manager/booterror.log
```
Note: If you used a path different of the one used above (/home/pi/ds1307-rtc-manager), you have to rectify the previous line with the correct path. If some thing get wrong, you will find a log output in the following file (/home/pi/ds1307-rtc-manager/booterror.log)

## Stay in touch

- Author - [Mohamed Belhassen](https://https://www.facebook.com/mohamedbelhassen)

## License

"Raspberry-pi-rtc-management-web-app" is [MIT licensed](LICENSE).
