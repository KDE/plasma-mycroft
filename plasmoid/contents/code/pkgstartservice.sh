#!/bin/bash

service mycroft-messagebus start
service mycroft-skills start
service mycroft-speech-client start
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
