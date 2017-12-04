/*
 *   Copyright (C) 2016 by Aditya Mehra <aix.m@outlook.com>                      *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#ifndef MYCROFTPLASMOID_DBUS_H
#define MYCROFTPLASMOID_DBUS_H

#include <QObject>
#include <QtDBus>
QT_BEGIN_NAMESPACE
class QByteArray;
template<class T> class QList;
template<class Key, class Value> class QMap;
class QString;
class QStringList;
class QVariant;
QT_END_NAMESPACE

/*
 * Adaptor class for interface org.kde.mycroftapplet
 */
class MycroftDbusAdapterInterface: public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.kde.mycroftapplet")
    Q_CLASSINFO("D-Bus Introspection", ""
"  <interface name=\"org.kde.mycroftapplet\">\n"
"    <signal name=\"sendShowMycroft\">\n"
"      <arg direction=\"out\" type=\"s\" name=\"msgShowMycroft\"/>\n"
"    </signal>\n"
"    <signal name=\"sendShowSkills\">\n"
"      <arg direction=\"out\" type=\"s\" name=\"msgShowSkills\"/>\n"
"    </signal>\n"
"    <signal name=\"sendShowInstallSkills\">\n"
"      <arg direction=\"out\" type=\"s\" name=\"msgShowInstallSkills\"/>\n"
"    </signal>\n"
"    <method name=\"showMycroft\"/>\n"
"    <method name=\"showSkills\"/>\n"
"    <method name=\"showSkillsInstaller\"/>\n"
"  </interface>\n"
        "")
public:
    MycroftDbusAdapterInterface(QObject *parent);
    virtual ~MycroftDbusAdapterInterface();
    Q_INVOKABLE QString getMethod(const QString &method);

public: // PROPERTIES
public Q_SLOTS: // METHODS
    void showMycroft();
    void showSkills();
    void showSkillsInstaller();
Q_SIGNALS: // SIGNALS
    void sendShowInstallSkills(const QString &msgShowInstallSkills);
    void sendShowMycroft(const QString &msgShowMycroft);
    void sendShowSkills(const QString &msgShowSkills);
};

#endif
