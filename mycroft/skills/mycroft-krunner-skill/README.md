# mycroft-krunner-skill
This skill integrates Plasma 5 Krunner with Mycroft which enables users to search their local desktop for files, images, recent documents, bookmarks and utilize other krunner plugins.

#### Installation of skill:
* Download or Clone Git
* Create /opt/mycroft/skills folder if it does not exist
* Extract Downloaded Skill into a folder. "mycroft-krunner-skill". (Clone does not require this step)
* Copy the mycroft-krunner-skill folder to /opt/mycroft/skills/ folder

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
###### General Search
- "Hey Mycroft, search this computer for 'Your Filename' "
- "Hey Mycroft, find file 'Your Filename' "

###### Recent Documents
- "Hey Mycroft, display recent documents "
- "Hey Mycroft, display recent files "

###### Bookmarks
- "Hey Mycroft, search the computer for bookmarks "

## Current state

Working features:
Search the KDE Plasma 5 Desktop Environment for:
* Files
* Documents
* Bookmarks
* Recent Documents / Recent Files
* Images

Known issues:
* None

TODO:
* Seperate image search from File Search
* Narrow down integration to specific individual runners
* Add ability to select a specific file from search list and exec through mycroft
