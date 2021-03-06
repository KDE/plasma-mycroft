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

#include "mycroftplasmoid_dbus.h"
#include "mycroftplasmoidplugin.h"
#include <QMetaObject>
#include <QByteArray>
#include <QList>
#include <QMap>
#include <QString>
#include <QStringList>
#include <QVariant>
#include <QtDBus>

/*
 * Implementation of adaptor class MycroftDbusAdapterInterface
 */

MycroftDbusAdapterInterface::MycroftDbusAdapterInterface(QObject *parent)
    : QDBusAbstractAdaptor(parent)
{
    // constructor
    QDBusConnection dbus = QDBusConnection::sessionBus();
    dbus.registerObject("/mycroftapplet", this, QDBusConnection::ExportScriptableSlots | QDBusConnection::ExportNonScriptableSlots);
    dbus.registerService("org.kde.mycroftapplet");
    setAutoRelaySignals(true);
}

MycroftDbusAdapterInterface::~MycroftDbusAdapterInterface()
{
    // destructor
}

void MycroftDbusAdapterInterface::showMycroft()
{
    // handle method call org.kde.mycroft.showMycroft
    emit sendShowMycroft("Show");
    QMetaObject::invokeMethod(this, "getMethod", Qt::DirectConnection, Q_ARG(QString, "Show"));
}

void MycroftDbusAdapterInterface::showSkills()
{
    // handle method call org.kde.mycroft.showSkills
    emit sendShowSkills("ShowSkills");
    QMetaObject::invokeMethod(this, "getMethod", Qt::DirectConnection, Q_ARG(QString, "ShowSkills"));
}

void MycroftDbusAdapterInterface::showSkillsInstaller()
{
    // handle method call org.kde.mycroft.showSkillsInstaller
    emit installList("ShowInstallSkills");
    QMetaObject::invokeMethod(this, "getMethod", Qt::DirectConnection, Q_ARG(QString, "ShowInstallSkills"));
}

void MycroftDbusAdapterInterface::showRecipeMethod(const QString &recipeName)
{
    // handle method call org.kde.mycroft.showRecipeMethod
    emit recipeMethod(recipeName);
    QMetaObject::invokeMethod(this, "getMethod", Qt::DirectConnection, Q_ARG(QString, recipeName));
}

void MycroftDbusAdapterInterface::sendKioMethod(const QString &kioString)
{
    // handle method call org.kde.mycroft.showRecipeMethod
    emit kioMethod(kioString);
    QMetaObject::invokeMethod(this, "getMethod", Qt::DirectConnection, Q_ARG(QString, kioString));
}

Q_INVOKABLE QString MycroftDbusAdapterInterface::getMethod(const QString &method)
{
    QString str = method;
    return str;
}

