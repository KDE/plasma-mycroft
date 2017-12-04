#!/bin/bash

service mycroft-messagebus stop
service mycroft-skills stop
service mycroft-speech-client stop
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
