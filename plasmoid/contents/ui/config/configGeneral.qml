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
    
    GridLayout {
        Layout.fillWidth: true
        columns: 2
         
        PlasmaComponents.Label {
            id: websocketLabel
            text: "Websocket Address"
        }
            
        PlasmaComponents.TextField {
                id: websocketAddress
                Layout.fillWidth: true
                
                Component.onCompleted: {
                    websocketAddress.text = Mycroft.GlobalSettings.webSocketAddress
                }
            }
        
        ColumnLayout{
        Layout.fillWidth: true
        
            PlasmaComponents.Switch {
                    id: notificationSwitch
                    Layout.fillWidth: true
                    text: i18n("Enable Notifications")
                    checked: true
            }
            
            RowLayout {
                Layout.fillWidth: true
                
                PlasmaComponents.Label {
                    id: selectViewLabel
                    Layout.fillWidth: true
                    text: "Select Default View:"
                }
                
                PlasmaComponents.ComboBox{
                        id: selectView
                        Layout.fillWidth: true
                        model: ["Conversation View", "Dashboard View"]
                }
            }
        }
    }
}
