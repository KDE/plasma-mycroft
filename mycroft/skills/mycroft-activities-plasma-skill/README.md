# mycroft-activities-plasma-skill
This skill integrates Plasma 5 Activities with Mycroft which enables users to create activities and display activities via Mycroft.

#### Installation of skill:
* Download or Clone Git
* Create /opt/mycroft/skills folder if it does not exist
* Extract Downloaded Skill into a folder. "mycroft-activites-plasma-skill". (Clone does not require this step)
* Copy the mycroft-activities-plasma-skill folder to /opt/mycroft/skills/ folder

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
###### Create Activities
- "Hey Mycroft, create a new activity 'Activity Name'"
- "Hey Mycroft, create activity 'Activity Name' "

###### Display Activities
- "Hey Mycroft, show current activities "
- "Hey Mycroft, display activities "

## Current state

Working features:
* Create Activities
* Show Activities

Known issues:
* None

TODO:
* Stop Activity
* Remove Activity
* Switch Activity
