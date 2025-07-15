#include <Arduino.h>
#include <SoftwareSerial.h>
#define RX_PIN 26//27//14
#define TX_PIN 27 //14 //15

EspSoftwareSerial::UART myPort;

#include <stdio.h>


void setup() {

  Serial.begin(9600);
  myPort.begin(9600, SWSERIAL_8N1, RX_PIN, TX_PIN, true);
  delay(100);
  pinMode(12, PULLUP);
  pinMode(33,PULLUP);


}
void loop() {

  if (Serial.available())  { // If data comes in from serial monitor (PC), send it out to softserial port
    myPort.write(Serial.read());
  }
 if (myPort.available())  { // If data comes in from serial monitor (PC), send it out to softserial port
    Serial.write(myPort.read());
  }
}