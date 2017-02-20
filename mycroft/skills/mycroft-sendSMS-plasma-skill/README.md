# mycroft-sendSMS-plasma-skill
This skill integrates KDE Connect with Mycroft to enable users to send SMS from their Desktop.

#### Installation of skill:
* Download or Clone Git
* Create /opt/mycroft/skills folder if it does not exist
* Extract Downloaded Skill into a folder. "mycroft-sendSMS-plasma-skill". (Clone does not require this step) (Follow the Folder Name [Important])
* Copy the mycroft-sendSMS-plasma-skill folder to /opt/mycroft/skills/ folder

#### Installation of requirements:
##### Fedora: 
- sudo dnf install PyQt5
- sudo dnf install SIP
- From terminal: cp -R /usr/lib64/python2.7/site-packages/PyQt5* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib64/python2.7/site-packages/sip* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

##### Kubuntu / KDE Neon: 
- sudo apt install python-pyqt5 pyqt5-dev
- sudo apt install python-sip python-sip-dev
- From terminal: cp -R /usr/lib/python2.7/dist-packages/PyQt5* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
- From terminal: cp /usr/lib/python2.7/dist-packages/sip* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/

* For other distributions:
- PyQT5 and SIP package is required and copying the Python QT folder and SIP libs from your system python install over to /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/.

##### How To Use: 
###### Send SMS
- "Hey Mycroft, send SMS'"
- "Hey Mycroft, send a SMS' "

## Current state

Working features:
* Sending SMS

Known issues:
* None

TODO:
* None
