#include "msmapp.h"

#include <QProcess>

MsmApp::MsmApp(QObject *parent) : 
    QObject(parent),
    m_process(new QProcess(this))
{
}

QString MsmApp::msmapp(const QString &program)
{
    m_process->start(program);
    m_process->waitForFinished(-1);
    QByteArray bytes = m_process->readAllStandardOutput();
    QString output = QString::fromLocal8Bit(bytes);
    return output;
}
 
