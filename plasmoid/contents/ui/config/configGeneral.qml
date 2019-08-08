import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Item {
    id: page
    property alias cfg_websocketAddress: websocketAddress.text
    property alias cfg_notificationSwitch: notificationSwitch.checked
    property alias cfg_selectView: selectView.currentIndex
    property alias cfg_enableRemoteTTS: enableRemoteTTS.checked
    property alias cfg_enableRemoteSTT: enableRemoteSTT.checked
    
    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right
                    
        PlasmaComponents.TextField {
            id: websocketAddress
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n("Websocket Address:")       
            Component.onCompleted: {
                websocketAddress.text = Mycroft.GlobalSettings.webSocketAddress
            }
        }
        
        CheckBox {
            id: notificationSwitch
            Kirigami.FormData.label: i18n ("Additional Settings:")
            text: i18n("Enable Notifications")
            checked: true
        }
        
        CheckBox {
            id: enableRemoteTTS
            text: i18n("Enable Remote TTS")
            checked: Mycroft.GlobalSettings.usesRemoteTTS
            onCheckedChanged: Mycroft.GlobalSettings.usesRemoteTTS = checked
        }
        
        CheckBox {
            id: enableRemoteSTT
            text: i18n("Enable Remote STT")
            checked: false
        }
        
        PlasmaComponents.ComboBox{
            id: selectView
            Layout.fillWidth: true
            Kirigami.FormData.label: i18n ("Default View:")
            model: ["Conversation View", "Dashboard View"]
        }
    }
}

