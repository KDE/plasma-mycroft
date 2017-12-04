# Mycroft Plasmoid
#### Mycroft Ai Plasmoid and Skills for KDE Plasma 5 Desktop

1. Installation Requirements

  + This plasmoid requires Mycroft Core Installed from http://github.com/MycroftAi/ using the GIT Method:
    + cd /home/$USER/
    + git clone https://github.com/MycroftAI/mycroft-core
    + Run: ./dev_setup.sh
    
  + Download / Clone Mycroft Plasmoid from this REPO.
  + Unzip to folder if Downloaded

  + For KDE NEON / Kubuntu 17.10: sudo apt-get install libkf5notifications-data libkf5notifications-dev qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtwebsockets qml-module-qt-websockets qtdeclarative5-qtquick2-plugin qtdeclarative5-models-plugin cmake cmake-extras cmake-data qml-module-qtquick-layouts libkf5plasma-dev extra-cmake-modules qtdeclarative5-dev build-essential g++ gettext libqt5webkit5 libqt5webkit5-dev libkf5i18n-data libkf5i18n-dev libkf5i18n5 qml-module-qtgraphicaleffects libqt5dbus5 libkf5dbusaddons-dev libdbus-1-dev libdbus-glib-1-dev -y

  + For Fedora 26: sudo dnf install kf5-knotifications-devel qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquick1-devel qt5-qtquickcontrols qt5-qtquickcontrols2 qt5-qtwebsockets cmake extra-cmake-modules kf5-plasma-devel kf5-i18n-devel qt5-qtwebkit qt5-qtwebkit-devel


2. Installation Instructions [Go To Downloaded Plasmoid Folder and run the following commands]

  + mkdir build
  + cd build
  + cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  + make
  + sudo make install
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh
  + Logout / Login or Restart Plasma Shell

Note: This plasmoids default find location for mycroft-core services is /home/$USER/mycroft-core/. This can be changed as per your installation path of mycroft-core in the settings tab.

3. Upgrade From Previous Plasmoid Instructions 

  + Install additional dependencies: 
  (Neon/Kubuntu): sudo apt-get install libqt5webkit5 libqt5webkit5-dev libkf5i18n-data libkf5i18n-dev libkf5i18n5 libqt5dbus5 libkf5dbusaddons-dev qml-module-qtgraphicaleffects
  (Fedora): sudo dnf install kf5-i18n-devel qt5-qtwebkit qt5-qtwebkit-devel
  + Locate your plasma-mycroft folder
  + cd plasma-mycroft
  + git pull origin master
  + cd build
  + cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  + make
  + sudo make install
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh
  + sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh
  + Logout / Login or Restart Plasma Shell


4. Skills Installation

 Install Skills from Plasmoid:
 + For Krunner Skill: Install from Plasmoid (Follow Dependency Installation Below). Skill Name: Krunner-Search-Skill
 + For Activities Skill: Install from Plasmoid (Follow Dependency Installation Below). Skill Name: Plasma-Activities-Skill
 + For User Control Skill: Install from Plasmoid (Follow Dependency Installation Below). Skill Name: Plasma-User-Control-Skill
 + For Wallpaper Change Skill: Install from Plasmoid (Follow Dependency Installation Below). Skill Name: Unsplash-Wallpaper-Plasma-Skill
 + For Image Recognition Skill: Follow Instructions at: https://github.com/AIIX/clarifai-image-recognition-skill

 To Install Skills With HTML Data:
 + skill-weather: Replace /opt/mycroft/skills/skill-weather with https://github.com/AIIX/skill-weather
    + git clone https://github.com/AIIX/skill-weather
    + cp -R skill-weather/* /opt/mycroft/skills/skill-weather/
 
 + skill-stocks: Replace /opt/mycroft/skills/skill-stock with https://github.com/AIIX/skill-stock
    + git clone https://github.com/AIIX/skill-stock
    + cp -R skill-stock/* /opt/mycroft/skills/skill-stock/
    
 + skill-wiki: Replace /opt/mycroft/skills/skill-wiki with https://github.com/AIIX/skill-wiki
    + git clone https://github.com/AIIX/skill-wiki
    + cp -R skill-wiki/* /opt/mycroft/skills/skill-wiki/

 To Install Plasma Desktop Skills(Manually) (Step 5. Dependency Install is Very Important):
    + git clone https://github.com/AIIX/krunner-search-skill  
    + cp -R krunner-search-skill/* /opt/mycroft/skills/krunner-search-skill/
    + git clone https://github.com/AIIX/plasma-activities-skill  
    + cp -R plasma-activities-skill/* /opt/mycroft/skills/plasma-activities-skill/
    + git clone https://github.com/AIIX/plasma-user-control-skill
    + cp -R plasma-user-control-skill/* /opt/mycroft/skills/plasma-user-control-skill/
    + git clone https://github.com/AIIX/unsplash-wallpaper-plasma-skill  
    + cp -R unsplash-wallpaper-plasma-skill/* /opt/mycroft/skills/unsplash-wallpaper-plasma-skill/
    + git clone https://github.com/AIIX/clarifai-image-recognition-skill  
    + cp -R clarifai-image-recognition-skill/* /opt/mycroft/skills/clarifai-image-recognition-skill/
    
5. Skills Dependency Requirements

 + For Skills (KDE Neon): sudo apt install python-dbus, python-pyqt5 pyqt5-dev, python-sip, python-sip-dev
 + From Konsole: cp -R /usr/lib/python2.7/dist-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
 + From Konsole: cp /usr/lib/python2.7/dist-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
 + From Konsole: cp -R /usr/lib/python2.7/dist-packages/PyQt5* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/    
 + From Konsole: cp /usr/lib/python2.7/dist-packages/sip* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
 
6. Skills Dependency for Other Distributions

Python Dbus, PyQT5 and SIP package is required and copying the Python Dbus, Python QT folder and SIP libs from your system python install over to /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/.
