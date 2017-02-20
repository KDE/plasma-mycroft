#include "notify.h"
#include <QIcon>
#include <KNotification>

Notify::Notify(QObject *parent)
    : QObject(parent)
{
}

void Notify::mycroftResponse(const QString &title, const QString &notiftext)
{
    KNotification *notification = new KNotification(QStringLiteral("MycroftResponse"),
                                                    KNotification::CloseOnTimeout, this);
    notification->setComponentName(QStringLiteral("mycroftPlasmoid"));
    notification->setTitle(title);
    notification->setText(notiftext);
    notification->sendEvent();
}
