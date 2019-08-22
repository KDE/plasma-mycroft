# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 2.8.12)
project(plasma-mycroft VERSION "2.0.0")

option(BUILD_GUI_DEPS "Build Mycroft-GUI Dependencies" OFF)
set(QT_MIN_VERSION "5.9.0")
set(KF5_MIN_VERSION "5.0.0")
 
# Use Extra CMake Modules (ECM) for common functionality.
# See http://api.kde.org/ecm/manual/ecm.7.html
# and http://api.kde.org/ecm/manual/ecm-kde-modules.7.html 
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})
set(VERSION 2.1.0)

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMInstallIcons)
include(ExternalProject)

# Locate plasma_install_package macro.
find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS
    Plasma
    I18n
    Notifications
)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Quick
    Core
    Qml
    DBus
    Network
    WebSockets
)

add_subdirectory(icons)
add_subdirectory(plugin)

find_program(MycroftGUI mycroft-gui-app)

if(NOT MycroftGUI)
    message(STATUS "IMPORTANT: MYCROFT GUI DEPENDENCY NOT FOUND, PLEASE INSTALL MYCROFT-GUI & LOTTIE-QML MANUALLY")
endif()

if(MycroftGUI)
    message(STATUS "IMPORTANT: MYCROFT GUI DEPENDENCY FOUND, SKIPPING BUILDING DEPENDENCIES")
endif()

if(BUILD_GUI_DEPS)
ExternalProject_Add(mycroft-gui
    GIT_REPOSITORY https://github.com/MycroftAI/Mycroft-Gui
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON -DBUILD_REMOTE_TTS=ON
    BUILD_COMMAND make
    INSTALL_COMMAND sudo make install
)

ExternalProject_Add(lottie-qml
    GIT_REPOSITORY https://github.com/kbroulik/lottie-qml
    CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
    BUILD_COMMAND make
    INSTALL_COMMAND sudo make install
)
endif()

plasma_install_package(plasmoid org.kde.plasma.mycroftplasmoid)

install( DIRECTORY mycroft DESTINATION ${SYSCONF_INSTALL_DIR})
