import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import QtWebKit 3.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import "Applet.js" as Applet
import "Autocomplete.js" as Autocomplete
import "Conversation.js" as Conversation
import "Dashboard.js" as Dash

Item {
    id: topBarBGrect
    anchors.fill: parent
    z: 101
         
    Image {
            id: barAnim
            anchors.left: parent.left
            anchors.leftMargin: units.gridUnit * 0.1
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/mycroftsmaller.png"
            width: units.gridUnit * 1.4
            height: units.gridUnit * 1.5
        }
        
    ColorOverlay {
                    anchors.fill: barAnim
                    source: barAnim
                    color: theme.linkColor
    }
    
    PlasmaComponents.Label {
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.left: barAnim.right
                anchors.leftMargin: units.gridUnit * 0.25
                font.capitalization: Font.SmallCaps 
                id: logotextId
                text: i18n("Mycroft")
                font.bold: false;
                color: theme.textColor
    }
    
    PlasmaCore.SvgItem {
        id: topbarLeftDividerline
        anchors {
            left: logotextId.right
            leftMargin: units.gridUnit * 0.34
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linetopleftvertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linetopleftvertSvg;
            imagePath: "widgets/line"
        }
    }  

    PlasmaComponents.Label {
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.left: topbarLeftDividerline.right
                anchors.leftMargin: units.gridUnit * 0.25
                font.capitalization: Font.SmallCaps 
                id: statusId
                text: i18n("<b>Disabled</b>")
                font.bold: false;
                color: theme.textColor
    }
    
    PlasmaComponents.Button {
        id: statusRetryBtn
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: statusId.right
        anchors.leftMargin: units.gridUnit * 0.50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: units.gridUnit * 0.25
        text: i18n("Reconnect")
        width: units.gridUnit * 6
        visible: false
        focus: false
        enabled: false
        
        onClicked: {
            connectionObject.socket.active = false
            connectionObject.socket.active = true
            if (connectionObject.socket.active = false){
               mycroftConversationComponent.conversationModel.append({"itemType": "NonVisual", "InputQuery": connectionObject.socket.errorString})
            }
        }
    }
    
TopBarAnim {
    id: midbarAnim
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: statusId.left
    anchors.right:  topbarDividerline.left
    height: units.gridUnit * 4
    z: 6
}    
    
    PlasmaCore.SvgItem {
        id: topbarDividerline
        anchors {
            right: mycroftstartservicebutton.left
            rightMargin: units.gridUnit * 0.25
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linetopvertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linetopvertSvg;
            imagePath: "widgets/line"
        }
    }   
    
    
        SwitchButton {
                anchors.right: qinputmicbx.left
                anchors.verticalCenter: topBarBGrect.verticalCenter
                id: mycroftstartservicebutton
                checked: false
                width: Math.round(units.gridUnit * 2)
                height: width
                z: 102
                
                onClicked: {
                    if (mycroftstartservicebutton.checked === false) {
                        statusRetryBtn.visible = false
                        statusRetryBtn.enabled = false
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstoppath);
                        mycroftConversationComponent.conversationModel.clear()
                        suggst.visible = true;
                        connectionObject.socket.active = false;
                        midbarAnim.showstatsId()
                        Dash.showDash("setVisible")
                    }
                    
                    if (mycroftstartservicebutton.checked === true) {
                        disclaimbox.visible = false;
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstartpath);
                        if(appletSettings.innerset.dashboardSetting == "false"){
                        mycroftConversationComponent.conversationModel.clear()
                        }
                        suggst.visible = true;
                        statusId.color = theme.linkColor
                        statusId.text = i18n("<b>Starting up..please wait</b>")
                        statusId.visible = true
                        delay(15000, function() {
                        connectionObject.socket.active = true;
                        })
                    }
                }
            }
                
        PlasmaComponents.ToolButton {
                id: qinputmicbx
                anchors.right: pinButton.left
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "mic-on"
                tooltip: i18n("Toggle Mic")
                flat: true
                width: Math.round(units.gridUnit * 2)
                height: width
                z: 102
    
                onClicked: {
                    if (qinputmicbx.iconSource == "mic-on") {
                        Applet.muteMicrophone()
                    }
                    else if (qinputmicbx.iconSource == "mic-off") {
                        Applet.unmuteMicrophone()
                        }
                    } 
        }
    
    PlasmaComponents.ToolButton {
        id: pinButton
        anchors.right: parent.right
        anchors.verticalCenter: topBarBGrect.verticalCenter
        width: Math.round(units.gridUnit * 1.5)
        height: width
        checkable: true
        iconSource: "window-pin"
        onCheckedChanged: plasmoid.hideOnWindowDeactivate = !checked
        z: 102
        }
    }  
