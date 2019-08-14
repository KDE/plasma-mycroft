# Mycroft Plasmoid v2.x

1. Installation Requirements

  + This plasmoid requires Mycroft Core Installed from http://github.com/MycroftAi/Mycroft-Core using the GIT Method:
    + cd /home/$USER/
    + git clone https://github.com/MycroftAI/mycroft-core
    + Run: ./dev_setup.sh
  + This plasmoid requires Mycroft-GUI Installed from http://github.com/MycroftAi/Mycroft-GUI.
  + This plasmoid requires Lottie-QML Installed from https://github.com/kbroulik/lottie-qml.
  
  + Download / Clone Mycroft Plasmoid from this REPO.
  + Unzip to folder if Downloaded

  + For KDE NEON / Kubuntu: sudo apt-get install libkf5notifications-data libkf5notifications-dev qml-module-qtquick2 qml-module-qtquick-controls2 qml-module-qtquick-controls qml-module-qtwebsockets qml-module-qt-websockets qtdeclarative5-qtquick2-plugin qtdeclarative5-models-plugin cmake cmake-extras cmake-data qml-module-qtquick-layouts libkf5plasma-dev extra-cmake-modules qtdeclarative5-dev build-essential g++ gettext libqt5webkit5 libqt5webkit5-dev libkf5i18n-data libkf5i18n-dev libkf5i18n5 qml-module-qtgraphicaleffects libqt5dbus5 libkf5dbusaddons-dev libdbus-1-dev libdbus-glib-1-dev kio-dev pkg-config pkg-kde-tools qtbase5-dev libkf5kio-dev libqt5websockets5-dev -y

2. Installation Instructions [Go To Downloaded Plasmoid Folder and run the following commands]

  + mkdir build
  + cd build
  + cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON -DBUILD_GUI_DEPS=ON("-DBUILD_GUI_DEPS" Only required if Mycroft-GUI is not installed)
  + make
  + sudo make install
  + Logout / Login or Restart Plasma Shell
