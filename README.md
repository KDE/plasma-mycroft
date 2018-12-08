# Mycroft Plasmoid

_Mycroft AI Plasmoid and Skills for KDE Plasma 5 Desktop_

* [Installation Requirements](#installation-requirements)
  + [KDE Neon/Kubuntu](#kde-neon-kubuntu)
  + [Fedora](#fedora)
* [Installation Instructions](#installation-instructions)
* [Upgrade from Previous Plasmoid Instructions](#upgrade-from-previous-plasmoid-instructions)
* [Skills Installation](#skills-installation)
  + [Install Skills from the Plasmoid](#install-skills-from-the-plasmoid)
  + [Install Skills with HTML Data](#install-skills-with-html-data)
  + [To Install Plasma Desktop Skills (Manually)](#to-install-plasma-desktop-skills--manually-)
* [Skills Dependency Requirements](#skills-dependency-requirements)
* [Skills Dependencies for Other Distributions](#skills-dependencies-for-other-distributions)

## Installation Requirements

1. This plasmoid requires [Mycroft Core](https://github.com/MycroftAI/mycroft-core) installed using the GIT Method.

```bash
cd /home/$USER/
git clone https://github.com/MycroftAI/mycroft-core
./dev_setup.sh
```

2. Download or clone this repository.
3. Unzip to a folder.

### KDE Neon/Kubuntu

```bash
sudo apt-get install libkf5notifications-data libkf5notifications-dev qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtwebsockets qml-module-qt-websockets qtdeclarative5-qtquick2-plugin qtdeclarative5-models-plugin cmake cmake-extras cmake-data qml-module-qtquick-layouts libkf5plasma-dev extra-cmake-modules qtdeclarative5-dev build-essential g++ gettext libqt5webkit5 libqt5webkit5-dev libkf5i18n-data libkf5i18n-dev libkf5i18n5 qml-module-qtgraphicaleffects libqt5dbus5 libkf5dbusaddons-dev libdbus-1-dev libdbus-glib-1-dev -y
```

### Fedora

```bash
sudo dnf install kf5-knotifications-devel qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquick1-devel qt5-qtquickcontrols qt5-qtquickcontrols2 qt5-qtwebsockets cmake extra-cmake-modules kf5-plasma-devel kf5-i18n-devel qt5-qtwebkit qt5-qtwebkit-devel
```

## Installation Instructions

1. Go to the downloaded plasmoid folder and run the following commands:

  ```bash
  mkdir build
  cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  make
  sudo make install
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh
  ```

2. Log out and log in or restart the Plasma shell.

Note: This plasmoid's default find location for `mycroft-core` services is `/home/$USER/mycroft-core/`. This can be changed as per your installation path of `mycroft-core` in the settings tab.

## Upgrade from Previous Plasmoid Instructions 

1. Install additional dependencies:

  - KDE Neon/Kubuntu

  ```bash
  sudo apt-get install libqt5webkit5 libqt5webkit5-dev libkf5i18n-data libkf5i18n-dev libkf5i18n5 libqt5dbus5 libkf5dbusaddons-dev qml-module-qtgraphicaleffects
  ```

  - Fedora

  ```bash
  sudo dnf install kf5-i18n-devel qt5-qtwebkit qt5-qtwebkit-devel
  Locate your plasma-mycroft folder
  cd plasma-mycroft
  git pull origin master
  cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
  make
  sudo make install
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh
  sudo chmod +x /usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh
  ```

2. Log out and log in or restart the Plasma shell.


## Skills Installation

### Install Skills from the Plasmoid

| Skill | Name | Instruction |
|---|---|---|
| Krunner Skill | `Krunner-Search-Skill` | Install from plasmoid (follow dependency installation below) |
| Activities Skill | `Plasma-Activities-Skill` | Install from plasmoid (follow dependency installation below) |
| User Control Skill | `Plasma-User-Control-Skill` | Install from plasmoid (follow dependency installation below) |
| Wallpaper Change Skill | `Unsplash-Wallpaper-Plasma-Skill` | Install from plasmoid (follow dependency installation below) |
| Image Recognition Skill |   | Follow instructions at [AIIX/clarifai-image-recognition-skill](https://github.com/AIIX/clarifai-image-recognition-skill) |


### Install Skills with HTML Data

- `skill-weather`:
  Replace `/opt/mycroft/skills/skill-weather` with `https://github.com/AIIX/skill-weather` by running:

  ```bash
  git clone https://github.com/AIIX/skill-weather
  cp -R skill-weather/* /opt/mycroft/skills/skill-weather/
  ```

- `skill-stocks`:
  Replace `/opt/mycroft/skills/skill-stock` with `https://github.com/AIIX/skill-stock` by running:

  ```bash
  git clone https://github.com/AIIX/skill-stock
  cp -R skill-stock/* /opt/mycroft/skills/skill-stock/
  ```

- `skill-wiki`:
  Replace `/opt/mycroft/skills/skill-wiki` with `https://github.com/AIIX/skill-wiki` by running:

  ```bash
  git clone https://github.com/AIIX/skill-wiki
  cp -R skill-wiki/* /opt/mycroft/skills/skill-wiki/
  ```

### To Install Plasma Desktop Skills (Manually)

If you do this, the step [Skills Dependency Requirements](#skills-dependency-requirements) is very important.

```bash
git clone https://github.com/AIIX/krunner-search-skill  
cp -R krunner-search-skill/* /opt/mycroft/skills/krunner-search-skill/
git clone https://github.com/AIIX/plasma-activities-skill  
cp -R plasma-activities-skill/* /opt/mycroft/skills/plasma-activities-skill/
git clone https://github.com/AIIX/plasma-user-control-skill
cp -R plasma-user-control-skill/* /opt/mycroft/skills/plasma-user-control-skill/
git clone https://github.com/AIIX/unsplash-wallpaper-plasma-skill  
cp -R unsplash-wallpaper-plasma-skill/* /opt/mycroft/skills/unsplash-wallpaper-plasma-skill/
git clone https://github.com/AIIX/clarifai-image-recognition-skill  
cp -R clarifai-image-recognition-skill/* /opt/mycroft/skills/clarifai-image-recognition-skill/
```

## Skills Dependency Requirements

For Skills (KDE Neon), run:

```bash
sudo apt install python-dbus python-pyqt5 pyqt5-dev python-sip python-sip-dev
cp -R /usr/lib/python2.7/dist-packages/dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
cp /usr/lib/python2.7/dist-packages/_dbus* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
cp -R /usr/lib/python2.7/dist-packages/PyQt5* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/    
cp /usr/lib/python2.7/dist-packages/sip* /home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/
```

## Skills Dependencies for Other Distributions

Python Dbus, PyQT5 and SIP packages are required.
Copy the Python Dbus, Python QT folder and SIP libs from your system Python installation to `/home/$USER/.virtualenvs/mycroft/lib/python2.7/site-packages/`.
