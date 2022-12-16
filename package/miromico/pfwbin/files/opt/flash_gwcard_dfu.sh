#!/bin/sh

# This little script is inteded to flash the PicoGW card with a stm32 .dfu file.
# Use https://github.com/majbthrd/elf2dfuse to create a .dfu file from the .elf
# from your build. After that, upload the .dfu to the picogw and pass it as an
# arguemnt to this script.

file="$1"

if [ -e "$file" ]
then
    echo "Flashing PicoGW card!"
else
    echo "File ${file} not found, please pass a .dfu file as the first and only argument"
    exit 1
fi

GPIOBASE=480
NRST_PIN=$((14+GPIOBASE))
BOOT_PIN=$((17+GPIOBASE))

# init gpios
echo $NRST_PIN > /sys/class/gpio/export
echo out > "/sys/class/gpio/gpio$NRST_PIN/direction"

echo $BOOT_PIN > /sys/class/gpio/export
echo out > "/sys/class/gpio/gpio$BOOT_PIN/direction"

/etc/init.d/lora stop

# set in
sleep 1
echo 0 > "/sys/class/gpio/gpio$NRST_PIN/value"
sleep 1
echo 1 > "/sys/class/gpio/gpio$BOOT_PIN/value"
sleep 1
echo 1 > "/sys/class/gpio/gpio$NRST_PIN/value"
sleep 1
dfu-util -a 0 -D  $1
sleep 1
echo 0 > "/sys/class/gpio/gpio$NRST_PIN/value"
echo 0 > "/sys/class/gpio/gpio$BOOT_PIN/value"
sleep 1
echo 1 > "/sys/class/gpio/gpio$NRST_PIN/value"
sleep 10
echo "done ..."

/etc/init.d/lora start

