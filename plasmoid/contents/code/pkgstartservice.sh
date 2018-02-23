#!/bin/bash
systemctl --user daemon-reload
systemctl --user start mycroft.target
paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
