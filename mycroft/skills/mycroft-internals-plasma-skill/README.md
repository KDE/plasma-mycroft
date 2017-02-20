# mycroft-internals-plasma-skill
This skill integrates Plasma 5 Desktop Internals with Mycroft which enables users to Lock Screen, Switch Users and Logout of the Desktop.

#### Installation of skill:
* Download or Clone Git
* Create /opt/mycroft/skills folder if it does not exist
* Extract Downloaded Skill into a folder. "mycroft-internals-plasma-skill". (Clone does not require this step)
* Copy the mycroft-internals-plasma-skill folder to /opt/mycroft/skills/ folder

#### Installation of requirements:
##### Fedora: 
- sudo dnf install dbus-python
- From terminal: cp -R /usr/lib64/python2.7/site-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib64/python2.7/site-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

##### Kubuntu / KDE Neon: 
- sudo apt install python-dbus
- From terminal: cp -R /usr/lib/python2.7/dist-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib/python2.7/dist-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

* For other distributions:
- Python Dbus package is required and copying the Python Dbus folder and lib from your system python install over to /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/.

##### How To Use: 
###### Lockscreen
- "Hey Mycroft, lock the screen"
- "Hey Mycroft, lock screen "

###### Switch Users
- "Hey Mycroft, switch current user "
- "Hey Mycroft, switch user "

###### Logout Users
- "Hey Mycroft, logout of the current session "
- "Hey Mycroft, logout session "

## Current state

Working features:
* Lock Screen
* Switch Users
* Logout

Known issues:
* None

TODO:
* None
