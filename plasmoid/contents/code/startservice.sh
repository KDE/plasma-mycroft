#!/bin/bash

cd /home/$USER/mycroft-core*/
./mycroft.sh start
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
