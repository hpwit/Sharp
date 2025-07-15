# Introduction
Here is the first part of connecting the esp32 or any other microcontrollers.

I have chosen the esp32 as it is my favorite mcu but no hard feeling if it's not yours :)

THis is based on the work of [Chris Herman](https://github.com/chrisherman/PC-G850V-InvertedSerial)

# Hardware part

Here are the connections I have chosen due to the disposition of the pin in my esp32 dev kit rev4. But chose the pins you prefer


|ESP32|SHARP PC 850VS|
|:----|:----:|
|GND|PIN 3|
|PIN 12|PIN 4|
|PIN 27|PIN 6|
|PIN 26|PIN 7|
|PIN 33|PIN 9|


If you want to power the esp32 with the Sharp connect the esp32 5V to the pin 2 of the SHARP PC 850VS.

You can use simple Dupont connectors
![Sync](images/IMG_7494.HEIC)

![Sync](images/IMG_7495.HEIC)

# Software part

## ESP32
You will need ESPSoftwareSerial  V8.1.0 library (available via Arduino library manager).

download the code `sendtosharp.ino` to the esp

## Computer
You'll need python on you computer

# Prepare your SHARP

On the SHARP
Go to 'TEXT' -> 'SIO' -> 'Format'

make sure the following parameters are set
*  baud rate = 9600
* data bit = 8
* stop bit = 1
* parity  = none
* end of line = CD LF
* end of file  = 1A

PS: to validate your choice do not forget to type 'ENTER'

# Send a text file to the sharp

Go to 'TEXT' -> 'SIO' -> 'Load'
On yout computer launch
`python sendtext.py name_of_the_file usb_port`
Once the file has been sent the Sharp will go back to the SIO menu.

## Send the program to allow binary uplaods

`python sendtext.py sendtosharp.asm usb_port`

then in basic Mode
type: 
* MON
* USER 2FFF

Than assemble the program

## send binary to your sharp

On your sharp in basic mode
 type
 * MON
 * G2000

![Sync](images/IMG_7492.heic)


On your computer
`python sendbin.py thebinary usb_port  address`


like 


`python sendbin.py tunnel.bin /dev/cu.usbserial-210 0x100`


![Sync](images/IMG_7493.heic)


You can in that case  execute to program by doing `G100`

PS: you can stop the program by clicking the 'ON' key

let me know







