#ifndef LAUNCHAPP_H
#define LAUNCHAPP_H

#include <QObject>
#include <QStringList>

class LaunchApp : public QObject
{
    Q_OBJECT

public:
    explicit LaunchApp(QObject *parent = Q_NULLPTR);

public Q_SLOTS:
    bool runCommand(const QString &exe, const QStringList &args = QStringList());
};

#endif // LAUNCHAPP_H
