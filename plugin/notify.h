#ifndef NOTIFY_H
#define NOTIFY_H

#include <QObject>
#include <QStringList>

class Notify : public QObject
{
    Q_OBJECT

public:
    explicit Notify(QObject *parent = Q_NULLPTR);

public Q_SLOTS:
    void mycroftResponse(const QString &title, const QString &notiftext);
};

#endif // NOTIFY_H
