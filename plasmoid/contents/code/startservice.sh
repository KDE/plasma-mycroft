#!/bin/bash

cd /home/$USER/mycroft-core*/
./start-mycroft.sh all
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
