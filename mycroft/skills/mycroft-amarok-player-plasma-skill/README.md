# mycroft-amarok-player-plasma-skill
This skill integrates Amarok Music Player with Mycroft which enables users to Play Local Music.

#### Installation of skill:
* Download or Clone Git
* Create /opt/mycroft/skills folder if it does not exist
* Extract Downloaded Skill into a folder. "mycroft-amarok-player-plasma-skill". (Clone does not require this step)
* Copy the mycroft-internals-plasma-skill folder to /opt/mycroft/skills/ folder

#### Installation of requirements:
##### Fedora: 
- sudo dnf install dbus-python
- sudo dnf install python-psutil
- From terminal: cp -R /usr/lib64/python2.7/site-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib64/python2.7/site-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

##### Kubuntu / KDE Neon: 
- sudo apt install python-psutil
- sudo apt install python-dbus
- From terminal: cp -R /usr/lib/python2.7/dist-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib/python2.7/dist-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

* For other distributions:
- Python Dbus and Python Psutil package is required and copying the Python Dbus folder and lib from your system python install over to /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/.

##### How To Use: 
###### Play Music/Song
- "Hey Mycroft, amarock play music"
- "Hey Mycroft, amarock play song"

###### Pause Music/Song
- "Hey Mycroft, amarock pause music"
- "Hey Mycroft, amarock pause song"

###### Stop Music/Song
- "Hey Mycroft, amarock stop music"
- "Hey Mycroft, amarock stop song"

###### Next Song
- "Hey Mycroft, amarock next song"

###### Previous Song
- "Hey Mycroft, amarock previous song"

## Current state

Working features:
* Play Music
* Pause Music
* Stop Music
* Next Song
* Previous Song

Known issues:
* None

TODO:
* None
