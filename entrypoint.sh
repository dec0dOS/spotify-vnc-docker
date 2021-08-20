#!/bin/sh -x

eval $(fixuid)

sudo chown -R docker:docker /home/docker/.config/spotify

# Update spotify
sudo apt-get update
sudo apt-get install -y spotify-client

sudo mkdir -p /var/run/dbus
sudo dbus-daemon --system --fork &
sleep 1

sudo Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
sleep 1
sudo x11vnc -display $DISPLAY -nopw -forever -quiet &

#pulseaudio &
# Wait for PA to start and write to FIFO
#while [ ! -p /tmp/snapfifo_pa ]; do sleep 1; done
#if [ -p /tmp/snapfifo ]; then
#    cat /tmp/snapfifo_pa >> /tmp/snapfifo &
#fi

while true; do sudo spotify --disable-gpu --disable-software-rasterizer --no-zygote; sleep 10000; done
