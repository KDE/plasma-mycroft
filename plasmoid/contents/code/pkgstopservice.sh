#!/bin/bash

systemctl --user stop mycroft.target
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
