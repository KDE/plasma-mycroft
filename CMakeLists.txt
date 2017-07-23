# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 2.8.12)
 
set(QT_MIN_VERSION "5.4.0")
set(KF5_MIN_VERSION "5.0.0")
 
# Use Extra CMake Modules (ECM) for common functionality.
# See http://api.kde.org/ecm/manual/ecm.7.html
# and http://api.kde.org/ecm/manual/ecm-kde-modules.7.html 
find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)

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
)

add_subdirectory(plugin)

plasma_install_package(plasmoid org.kde.plasma.mycroftplasmoid)

install( DIRECTORY image/breeze DESTINATION ${ICON_INSTALL_DIR})
install( DIRECTORY image/breeze-dark DESTINATION ${ICON_INSTALL_DIR})
