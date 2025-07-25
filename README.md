# plant-hydra
IoT Project of Automated Plant-Watering System 

## Required hardware components: 
- An ESP32 microcontroller
- An 18650 lithium-ion battery 
- A capacitive soil moisture sensor v.1.2
- An air temperature and humidity sensor ASAIR DHT11
- A 5V mini-water pump
- An ARCELI water-level sensor
- A LED indicator for water tank status
- Diodes, transmitters and resistors 

The prototype uses an ESP32 development board with 18650 lithium-ion battery, a capacitive soil moisture sensor, water level sensor, temperature and humidity DHT-11 sensors, a 5V water pump, and an LED indicator. The sensor connects to the ESP32’s analogue input. The pump is controlled via a transistor. The ESP32 runs a program that reads the sensor, compares the value to a threshold, and activates the pump if needed. The LED is connected to a digital output and lights up when the water tank is low. The ESP32 can be powered by a rechargeable battery and monitor the battery charge.
