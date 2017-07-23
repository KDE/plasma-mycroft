#ifndef MSMAPP_H
#define MSMAPP_H

#include <QObject>
#include <QProcess>

class MsmApp : public QObject
{
    Q_OBJECT
public:
    explicit MsmApp(QObject *parent = 0);
    Q_INVOKABLE QString msmapp(const QString &program);

private:
    QProcess *m_process;
};

#endif // MSMAPP_H
