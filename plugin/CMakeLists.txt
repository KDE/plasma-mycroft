find_package(PkgConfig)

kde_enable_exceptions()

set(mycroftplasmoidplugin_SRCS mycroftplasmoidplugin.cpp launchapp.cpp notify.cpp filereader.cpp msmapp.cpp mycroftplasmoid_dbus.cpp)

add_library(mycroftplasmoidplugin SHARED ${mycroftplasmoidplugin_SRCS})

target_link_libraries(mycroftplasmoidplugin Qt5::Gui Qt5::Core Qt5::Qml Qt5::DBus KF5::Plasma KF5::I18n KF5::Notifications)

install(TARGETS mycroftplasmoidplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/private/mycroftplasmoid)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/private/mycroftplasmoid)

install(FILES mycroftPlasmoid.notifyrc DESTINATION ${KNOTIFYRC_INSTALL_DIR})
