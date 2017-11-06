#ifndef PROTOTYPEPLASMOIDPLUGIN_H
#define PROTOTYPEPLASMOIDPLUGIN_H

#include <QQmlExtensionPlugin> 
#include <QDBusAbstractAdaptor>
#include <Plasma/Applet>

class QQmlEngine;

class MycroftPlasmoidPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
    
Q_SIGNAL
};

#endif // PROTOTYPEPLASMOIDPLUGIN_H
