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

#include "mycroftplasmoidplugin.h"
#include "mycroftplasmoid_dbus.h"
#include "notify.h"
#include <QtQml>
#include <QtDebug>
#include <QtDBus>

static QObject *notify_singleton(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return new Notify;
}

void MycroftPlasmoidPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("org.kde.private.mycroftplasmoid"));
    qmlRegisterSingletonType<Notify>(uri, 1, 0, "Notify", notify_singleton);
}

void MycroftPlasmoidPlugin::initializeEngine(QQmlEngine* engine, const char* uri)
{
  QQmlExtensionPlugin::initializeEngine(engine, uri);
  auto mycroftDbusAdapterInterface = new MycroftDbusAdapterInterface(engine);
  engine->rootContext()->setContextProperty("main2", mycroftDbusAdapterInterface);
}
