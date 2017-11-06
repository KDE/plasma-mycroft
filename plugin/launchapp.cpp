#include "launchapp.h"

#include <QProcess>

LaunchApp::LaunchApp(QObject *parent)
    : QObject(parent)
{
}

bool LaunchApp::runCommand(const QString &exe, const QStringList &args)
{
    return QProcess::startDetached(exe, args);
}
