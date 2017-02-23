/* Copyright 2016 Aditya Mehra <aix.m@outlook.com>                            

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.
    
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import QtQml.Models 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Qt.WebSockets 1.0
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa

Item {
    id: main
    Layout.fillWidth: true;
    Plasmoid.toolTipMainText: i18n("Mycroft")
    Plasmoid.switchWidth: units.gridUnit * 15
    Plasmoid.switchHeight: units.gridUnit * 15
    Layout.minimumHeight: units.gridUnit * 14
    Layout.minimumWidth: units.gridUnit * 22
    
    property alias cbwidth: rectangle2.width
    property string defaultmcorestartpath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh"
    property string defaultmcorestoppath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh"
    property string packagemcorestartcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh"
    property string packagemcorestopcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh"
    property string customlocstartpath: startsrvcustom.text
    property string customlocstoppath: stopsrvcustom.text
    property string customloc: " "
    property string coreinstallstartpath: defaultmcorestartpath
    property string coreinstallstoppath: defaultmcorestoppath
    
        function isBottomEdge() {
        return plasmoid.location == PlasmaCore.Types.BottomEdge;
    }
    
        function clearList() {
            inputlistView.clear()
        }
        
        Timer {
           id: timer
       }

       function delay(delayTime, cb) {
               timer.interval = delayTime;
               timer.repeat = false;
               timer.triggered.connect(cb);
               timer.start();
        }
    
    Item {
        id: root        
        Layout.fillWidth: true;
        Layout.fillHeight: true;
        property int minimumHeight: inputlistView.height ? inputlistView.height : rectanglebottombar.height + 30
        
        property int maximumHeight: minimumHeight
        
        anchors { 
            fill: parent
            topMargin: isBottomEdge() ? 0 : 7
            bottomMargin: isBottomEdge() ? 7 : 0
        }
        
        WebSocket {
        id: socket
        url: "ws://0.0.0.0:8181/core"
        onTextMessageReceived: {
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            if (msgType === "speak") {
                var post = somestring.data.utterance;
                conversationInputList.append({author:"Mycroft", recipient:"User", InputQuery:post})
                inputlistView.positionViewAtEnd()
                var title = "Mycroft's Reply:"
                var notiftext = " "+ post;
                
                if (!plasmoid.expanded && notificationswitch.checked == true) {
                    PlasmaLa.Notify.mycroftResponse(title, notiftext);
}
            }
             barAnim.wsocmsganimtoggle()
        }
                
        onStatusChanged: if (socket.status == WebSocket.Error) {
                                statusId.text = "Connection Error"
                                statusId.color = "red"
                                barAnim.wsocerroranimtoggle()
                         } else if (socket.status == WebSocket.Open) {
                                statusId.text = "Mycroft is Ready"
                                statusId.color = "green"
                                barAnim.wsocrunninganimtoggle()
                         } else if (socket.status == WebSocket.Closed) {
                                statusId.text = "Mycroft is Disabled"
                                statusId.color = "#f4bf42"
                                barAnim.wsocclosedanimtoggle()
                         } else if (socket.status == WebSocket.Connecting) {
                                statusId.text = "Starting Up"
                                statusId.color = "grey"
                         } else if (socket.status == WebSocket.Closing) {
                                statusId.text = "Shutting Down"
                                statusId.color = "grey"
                         }
                         
        
        active: false;
    }
    
 Rectangle {
        id: rectangletopbar
        height: 40
        color: "#00000000"
        anchors.top: root.top
        anchors.right: root.right
        anchors.rightMargin: 0
        anchors.left: root.left
        anchors.leftMargin: 0
        border.width: 0
        border.color: "#80000000"
        z: 2
        
        
        RowLayout {
            id: topbarinnergridLayout
            anchors.right: parent.right
            anchors.left: parent.left
            Layout.fillHeight: true
            Layout.fillWidth: true
        
                PlasmaComponents.ToolButton {
                anchors.left: parent.left
                id: mycroftSettingsTab
                iconSource: "games-config-options"
                flat: true
                checked: false
                focus: false
                minimumHeight: 4
                minimumWidth: 4
                
                onClicked: {
                     mycroftSettingsColumn.visible = !mycroftSettingsColumn.visible
                     if (mycroftSettingsColumn.visible === true) {
                         mycroftanimbar.visible = false
                    } else if (mycroftSettingsColumn.visible === false) {
                        mycroftanimbar.visible = true
                    }
                  }
                }

            
                PlasmaComponents.ToolButton {
                anchors.left: mycroftSettingsTab.right
                anchors.leftMargin: 2
                id: mycroftstartservicebutton
                iconSource: "media-playback-start"
                flat: true
                checked: false
                focus: false
                minimumHeight: 4
                minimumWidth: 4
                
                onClicked: {
                    console.log(coreinstallstartpath);
                    mycroftstartservicebutton.checked = !mycroftstartservicebutton.checked
                    if (mycroftstartservicebutton.checked === false) {
                        mycroftstartservicebutton.iconSource = "media-playback-start"
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstoppath);
                        socket.active = false;
                    }
                    
                    if (mycroftstartservicebutton.checked === true) {
                        mycroftstartservicebutton.iconSource = "media-playback-pause"
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstartpath);
                        conversationInputList.clear()
                        delay(12000, function() {
                        socket.active = true;
                        })
                    }

                }
                
                }
            
            
                PlasmaComponents.Label {
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -10
                id: statusId
                text: "Mycroft is disabled"
                font.bold: false;
                font.pixelSize: 14
                color: "#f4bf42"
                } 
                
                PlasmaComponents.TabBar {
                id: tabBar
                anchors.right: parent.right
            
            PlasmaComponents.TabButton {
                id: mycroftTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "system-search"
                }
        
            PlasmaComponents.TabButton {
                id: mycroftSkillsTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "games-hint"
            }
                }
            }
        }

Rectangle {
        id: mycroftanimbar
        height: 80
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rectangletopbar.bottom
        anchors.topMargin: -20;
        color: "#00000000"
        z: 3
        
        TopBarAnim {
            id: barAnim
            z: 6
        }
}
        
ColumnLayout {
id: mycroftcolumntab    
visible: tabBar.currentTab == mycroftTab;
anchors.top: mycroftanimbar.bottom
anchors.left: root.left
anchors.right: root.right
anchors.bottom: rectanglebottombar.top

 Rectangle {
                id: rectangle2
                color: "#00000000"
                anchors.fill: parent
    
    ListModel{
    id: conversationInputList
    }

        Rectangle {
            id: messageBox
            anchors.fill: parent
            anchors.right: rectangle2.right
            color: "#00000000"

            ColumnLayout {
                id: colconvo
                anchors.fill: parent

                ListView {
                    id: inputlistView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    verticalLayoutDirection: ListView.TopToBottom
                    //clip: true;
                    spacing: 12
                    model: conversationInputList
                    delegate: Column {
                    spacing: 6
                    anchors.right: parent.right

                    readonly property bool sentByMe: model.recipient !== "User"
                        
                    Row {
                        id: messageRow
                        spacing: 6
                            
                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: messageText.implicitHeight + 24
                        color: theme.backgroundColor

                    PlasmaComponents.Label {
                        id: messageText
                        text: model.InputQuery
                        anchors.fill: parent
                        anchors.margins: 12
                        wrapMode: Label.Wrap
                        }
                            }
                                }
                                    }

                    ScrollBar.vertical: ScrollBar {}

                    onCountChanged: {
                        inputlistView.positionViewAtEnd()  
                        var root = inputlistView.visibleChildren[0]
                        var listViewHeight = 0
                        var boxrowheight = 150
                        for (var i = 0; i < root.visibleChildren.length; i++) {
                        listViewHeight += root.visibleChildren[i].height
                        }
                            }
                                }
                                    }
                                        }
                                            }
                                                }
        
ColumnLayout {
id: mycroftSkillscolumntab    
visible: tabBar.currentTab == mycroftSkillsTab;
anchors.top: mycroftanimbar.bottom
anchors.left: root.left
anchors.right: root.right
anchors.bottom: rectanglebottombar.top
anchors.bottomMargin: 5

Rectangle {
        anchors.top: mycroftSkillscolumntab.top
        id: skillsrectmain
        color: "#00000000"
        
    Component {
            id: skillDelegate
            Rectangle {
                id: skillcontent
                Layout.fillWidth: true;
                anchors { left: parent.left; right: parent.right }
                height: 80 
                border.width: 0        
                border.color: "lightsteelblue"
                radius: 2
                color: theme.backgroundColor
                z: -99

                Column {
                id: skillcolumn
                Layout.fillWidth: true;
                PlasmaComponents.Label { wrapMode: Text.WordWrap; font.bold: true; text: '<b>Skill:</b> ' + Skill }

                Row {
                id: skillTopRowLayout
                height: skillimage.height
                spacing: 10
                                   
                Column {
                id: skillinnercolumn

                PlasmaComponents.Label {wrapMode: Text.WordWrap; width: main.width; text: '<b>Command:</b> ' + CommandList.get(0).Commands}
                PlasmaComponents.Label {wrapMode: Text.WordWrap; width: main.width; text: '<b>Command:</b> ' + CommandList.get(1).Commands}
                PlasmaComponents.Label { wrapMode: Text.WordWrap; width: main.width; text: '<b>Command:</b> ' + CommandList.get(2).Commands}
                PlasmaComponents.Label { wrapMode: Text.WordWrap; width: main.width; text: '<b>Command:</b> ' + CommandList.get(3).Commands}
                PlasmaComponents.Label { wrapMode: Text.WordWrap; width: main.width; text: '<b>Command:</b> ' + CommandList.get(4).Commands}
                }
                    }
                        }
                            }
                                }
                                    }

            ListView {
                id: skillslistmodelview
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                model: SkillModel{}
                delegate: skillDelegate
                spacing: 4
                focus: false
                interactive: true
            }
                }

ColumnLayout {
id: mycroftSettingsColumn
anchors.top: rectangletopbar.bottom
anchors.left: root.left
anchors.right: root.right
anchors.bottom: rectanglebottombar.top
anchors.bottomMargin: 5
visible: false;

Rectangle {
                id: settingscontent
                Layout.fillWidth: true;
                Layout.fillHeight: true;
                anchors.fill: parent;
                color: theme.backgroundColor
                
                
                PlasmaComponents.Label {
                    id: settingsTabTopLabel
                    anchors.top: parent.top;
                    anchors.topMargin: 5;
                    text: "<b>Plasmoid Settings</b>"
                }
                
                PlasmaComponents.Label {
                    id: settingsTabUnits
                    anchors.top: settingsTabTopLabel.bottom
                    anchors.topMargin: 5
                    text: "<i>Your Mycroft Core Installation Path</i>"
                }
                
               PlasmaComponents.ButtonColumn {
                id: radiobuttonColoumn
                anchors.top: settingsTabUnits.bottom
                anchors.topMargin: 5
                   
                PlasmaComponents.RadioButton {
                    id: settingsTabUnitsOpZero
                    exclusiveGroup: installPathGroup
                    text: "Default Path"
                    checked: true
                    
                    onCheckedChanged: {
                        
                        if (settingsTabUnitsOpZero.checked === true && coreinstallstartpath === packagemcorestartcmd) {
                            coreinstallstartpath = defaultmcorestartpath;
                        }
                        else if (settingsTabUnitsOpZero.checked === true && coreinstallstartpath === customlocstartpath) {
                            coreinstallstartpath = defaultmcorestartpath;   
                        }
                        
                        if (settingsTabUnitsOpZero.checked === true && coreinstallstoppath === packagemcorestopcmd) {
                            coreinstallstoppath = defaultmcorestoppath;
                        }
                        
                        else if (settingsTabUnitsOpZero.checked === true && coreinstallstoppath === customlocstoppath) {
                            coreinstallstoppath = defaultmcorestoppath;   
                        }
                    }
                }
                
                PlasmaComponents.RadioButton {
                    id: settingsTabUnitsOpOne
                    exclusiveGroup: installPathGroup
                    text: "Installed Using Mycroft Package"
                    checked: false
                    
                    onCheckedChanged: {
                        
                        if (settingsTabUnitsOpOne.checked === true && coreinstallstartpath === defaultmcorestartpath) {
                            coreinstallstartpath = packagemcorestartcmd;
                        }
                        else if (settingsTabUnitsOpOne.checked === true && coreinstallstartpath === customlocstartpath) {
                            coreinstallstartpath = packagemcorestartcmd;   
                        }
                        
                        if (settingsTabUnitsOpOne.checked === true && coreinstallstoppath === defaultmcorestoppath) {
                            coreinstallstoppath = packagemcorestopcmd;
                        }
                        
                        else if (settingsTabUnitsOpOne.checked === true && coreinstallstoppath === customlocstoppath) {
                            coreinstallstoppath = packagemcorestopcmd;   
                        }
                    }
                }
                
                PlasmaComponents.RadioButton {
                    id: settingsTabUnitsOpTwo
                    exclusiveGroup: installPathGroup
                    text: "Manual Install Path of Mycroft.sh"
                    checked: false
                    
                    onCheckedChanged: {
                        
                        if (settingsTabUnitsOpTwo.checked === true && coreinstallstartpath === defaultmcorestartpath) {
                            coreinstallstartpath = customlocstartpath;
                        }
                        else if (settingsTabUnitsOpTwo.checked === true && coreinstallstartpath === packagemcorestartcmd) {
                            coreinstallstartpath = customlocstartpath;   
                        }
                        
                        if (settingsTabUnitsOpTwo.checked === true && coreinstallstoppath === defaultmcorestoppath) {
                            coreinstallstoppath = customlocstoppath;
                        }
                        
                        else if (settingsTabUnitsOpTwo.checked === true && coreinstallstoppath === packagemcorestopcmd) {
                            coreinstallstoppath = customlocstoppath;   
                        }
                        
                    }
                } 
                    }
                
                PlasmaComponents.TextField {
                    id: settingsTabUnitsOpThree
                    width: settingscontent.width / 1.1
                    anchors.top: radiobuttonColoumn.bottom
                    anchors.topMargin: 10
                    placeholderText: i18n("/home/<Your UserName>/mycroft-core/mycroft.sh")
                    text: ""
                    
                    onTextChanged: {
                        var cstloc = settingsTabUnitsOpThree.text
                        customloc = cstloc
                        
                    }
                }
                
               PlasmaComponents.Button {
                   id: acceptcustomPath
                   anchors.left: settingsTabUnitsOpThree.right
                   anchors.verticalCenter: settingsTabUnitsOpThree.verticalCenter
                   anchors.right: parent.right
                   iconSource: "checkbox"
                   
                   onClicked: {
                       var cstlocl = customloc
                       var ctstart = cstlocl + " " + "start"
                       var ctstop = cstlocl + " " + "stop"
                        startsrvcustom.text = ctstart
                        stopsrvcustom.text = ctstop
                        console.log(startsrvcustom.text)                    
                    }
                } 
                
               PlasmaComponents.Switch {
                    id: notificationswitch
                    anchors.top: settingsTabUnitsOpThree.bottom
                    anchors.topMargin: 5
                    text: "Enable Notifications"
                    checked: true
                }
                
               PlasmaExtras.Paragraph {
                    id: settingsTabTF2
                    anchors.top: notificationswitch.bottom
                    anchors.topMargin: 5
                    text: "<i>Please Note: Default path is set to /home/$USER/mycroft-core/mycroft.sh. Change the above settings to match your installation</i>"
                }
                
              PlasmaComponents.Label {
                  id: startsrvcustom
                  visible: false
            }
            
            PlasmaComponents.Label {
                  id: stopsrvcustom
                  visible: false
            }   
    }
}
        
        
Rectangle {
        id: rectanglebottombar
        height: 30
        color: "#00000000"
        radius: 0
        anchors.bottom: root.bottom
        anchors.bottomMargin: 0
        anchors.right: root.right
        anchors.rightMargin: 0
        anchors.left: root.left
        anchors.leftMargin: 0
        border.color: "#80000000"
        border.width: 0
        z: 4


        RowLayout {
            id: rla1
            anchors.fill: parent
            Rectangle{
                anchors.fill: parent
                color: "#00000000"
                z: 5
   
                
            PlasmaComponents.TextField {
                
                id: qinput
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                placeholderText: i18n("Enter Query or Say 'Hey Mycroft'")
                clearButtonShown: true

                onAccepted: {
                conversationInputList.append({author:"User", recipient:"Mycroft", InputQuery:qinput.text})
                inputlistView.positionViewAtEnd()
                var socketmessage = {};
                socketmessage.type = "recognizer_loop:utterance";
                socketmessage.data = {};
                socketmessage.data.utterances = [qinput.text];
                socket.sendTextMessage(JSON.stringify(socketmessage));
                qinput.text = "";                
                if (socket.status == WebSocket.Error) {
                                barAnim.wsocerroranimtoggle()
                         }                
                else {
                    barAnim.wsocmsganimtoggle();                    
                }
                
                
                } 
                }            
            
            }

        }
     }
}
Settings {
     property alias customsetuppath: settingsTabUnitsOpThree.text
     property alias notifybool: notificationswitch.checked
     property alias radiobt1: settingsTabUnitsOpOne.checked
     property alias radiobt2: settingsTabUnitsOpTwo.checked
     property alias radiobt3: settingsTabUnitsOpZero.checked
    }
}
