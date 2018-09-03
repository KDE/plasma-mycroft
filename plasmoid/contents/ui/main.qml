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
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import "Applet.js" as Applet
import "Autocomplete.js" as Autocomplete
import "Conversation.js" as Conversation
import "ConversationLogic.js" as ConversationLogic
import "Dashboard.js" as Dash

Item {
    id: main
    Layout.fillWidth: true;
    Plasmoid.toolTipMainText: i18n("Mycroft")
    Plasmoid.switchWidth: units.gridUnit * 15
    Plasmoid.switchHeight: units.gridUnit * 15
    Layout.minimumWidth: units.gridUnit * 26
    
    Component.onCompleted: {
        mycroftStatusCheckSocket.active = true
        Applet.detectInstallType();
        Applet.refreshAllSkills();
    }
    
    property var skillList: []
    property alias cbwidth: conversationViewFrameBox.width
    property var cbwidthmargin: conversationViewFrameBox.width - units.gridUnit * 0.25
    property alias cbheight: conversationViewFrameBox.height
    property var dwrpaddedwidth: main.width + units.gridUnit * 1
    property var cbdrawercontentheight: parent.height + units.gridUnit * 0.5 - rectanglebottombar.height
    property string defaultmcorestartpath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh"
    property string defaultmcorestoppath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh"
    property string packagemcorestartcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh"
    property string packagemcorestopcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh"
    //property string customlocstartpath: startsrvcustom.text
    //property string customlocstoppath: stopsrvcustom.text
    property string customloc: " "
    property string coreinstallstartpath: defaultmcorestartpath
    property string coreinstallstoppath: defaultmcorestoppath
    property variant searchIndex: []
    property variant results: []
    property var smintent
    property var dataContent
    property alias textInput: bottomBarView.queryInput
    property alias dashLmodel: dashListModel
    property bool intentfailure: false
    property bool locationUserSelected: false
    property bool connectCtx: false
    property bool micIsMuted
    property var geoLat
    property var geoLong
    property var globalcountrycode
    property var weatherMetric: "metric"
    property date currentDate: new Date()
    
    Connections {
        target: plasmoid
        onExpandedChanged: {
            if (plasmoid.expanded) {
                Dash.checkDashStatus()
            }
        }
    }
    
    Connections {
        target: PlasmaLa.Notify
        onNotificationStopSpeech: {
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = ["stop"];
            socket.onSendMessage(JSON.stringify(socketmessage));
        }
        onNotificationShowResponse: {
           plasmoid.expanded = !plasmoid.expanded
           tabBar.currentTab = mycroftTab
        }
    }
    
    Connections {
        target: main2
        ignoreUnknownSignals: true
        
        onSendShowMycroft: {
            plasmoid.expanded = !plasmoid.expanded
            tabBar.currentTab = mycroftTab
        }
        onSendShowSkills: {
            tabBar.currentTab = mycroftSkillsTab
            if(plasmoid.expanded = !plasmoid.expanded){
                plasmoid.expanded
            }
        }
        onInstallList: {
            tabBar.currentTab = mycroftMSMinstTab
            if(plasmoid.expanded = !plasmoid.expanded){
                plasmoid.expanded
            }
        }
        onKioMethod: {
            var sentFromKio = msgKioMethod
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [sentFromKio];
            socket.onSendMessage(JSON.stringify(socketmessage));
        }
    }
        
    PlasmaCore.DataSource {
        id: geoDataSource
        dataEngine: "geolocation"
    
        onSourceAdded: {
            connectSource(source)
        }
        
        onNewData: {
            mycroftConversationComponent.conversationModel.clear()
            if (sourceName == "location"){
            geoLat = data.latitude
            geoLong = data.longitude
            var globalcountry = data.country
            globalcountrycode = globalcountry.substring(0, 2)
            Dash.showDash("setVisible")
                }
            }
        }

ListModel {
         id: dashListModel
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
    id: topBar
    Layout.fillWidth: true
    height: units.gridUnit * 2
    z: 101
    anchors {
        top: main.top
        topMargin: -1
        left: main.left
        leftMargin: -1
        right: main.right
        rightMargin: -1
    }
    
    TopBarViewComponent {
        id: topBarView
    }
}

PlasmaCore.SvgItem {
    anchors {
        left: main.left
        right: main.right
        top: root.top
    }
    width: 1
    height: horlinetopbarSvg.elementSize("horizontal-line").height

    elementId: "horizontal-line"
    z: 110
    svg: PlasmaCore.Svg {
        id: horlinetopbarSvg;
        imagePath: "widgets/line"
    }
}  
    
Item {
    id: root                
    anchors { 
      top: topBar.bottom
      bottom: rectanglebottombar.top
      left: parent.left
      right: parent.right
    }
        
    //WebSocket {
      //  id: mycroftStatusCheckSocket
       // url: appletSettings.innerset.wsurl
       // active: true
       // property bool _socketIsAlreadyActive: false
        //onStatusChanged: Applet.preSocketStatus()
       // }
        
    PlasmaLa.WSocket {
        id: socket
        onMessageReceived: {
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            Applet.playwaitanim(msgType);
            ConversationLogic.filterConversation(msgType, somestring)
            topBarView.animateTalk()
        }
        onSocketStatusChanged: {
            Applet.mainSocketStatus()
        }
    }    
        
    ColumnLayout {
        id: sidebar
        height: units.gridUnit * 6
        width: units.gridUnit * 2
        
        PlasmaComponents.TabBar {
            id: tabBar
            anchors.fill: parent
            tabPosition: Qt.LeftEdge;
            
            PlasmaComponents.TabButton {
                id: mycroftTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "go-home"
                
                PlasmaCore.ToolTipArea {
                        id: tooltiptab1
                        mainText: i18n("Conversation")
                        anchors.fill: parent
                }
            }
                    
            PlasmaComponents.TabButton {
                id: mycroftSkillsTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "games-hint"
                
                PlasmaCore.ToolTipArea {
                        id: tooltiptab2
                        mainText: i18n("Hints/Tips")
                        anchors.fill: parent
                }
            }
                
            PlasmaComponents.TabButton {
                id: mycroftSettingsTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "games-config-options"
                
                PlasmaCore.ToolTipArea {
                        id: tooltiptab3
                        mainText: i18n("Settings")
                        anchors.fill: parent
                }
            }
                
            PlasmaComponents.TabButton {
                id: mycroftMSMinstTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "kmouth-phresebook-new"
                
                PlasmaCore.ToolTipArea {
                    id: tooltiptab4
                    mainText: i18n("Skill Browser")
                    anchors.fill: parent
                }
            }  
        }
    }

    PlasmaCore.SvgItem {
        anchors {
            left: parent.left
            leftMargin: sidebar.width
            top: parent.top
            topMargin: 1
            bottom: parent.bottom
            bottomMargin: 1
        }

        width: lineSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: lineSvg;
            imagePath: "widgets/line"
        }
    }        
                
    ColumnLayout {
        id: mycroftcolumntab    
        visible: tabBar.currentTab == mycroftTab;
        anchors.top: root.top
        anchors.left: sidebar.right
        anchors.leftMargin: units.gridUnit * 0.25
        anchors.right: root.right
        anchors.bottom: root.bottom

        Item {
            id: conversationViewFrameBox
            anchors.top: mycroftcolumntab.top
            anchors.topMargin:15
            anchors.left: mycroftcolumntab.left
            anchors.right: mycroftcolumntab.right
            anchors.bottom: mycroftcolumntab.bottom
                    
            Disclaimer{
                id: disclaimbox
                visible: false
            }

            ConversationView{
                id: mycroftConversationComponent
                anchors.fill: parent
            }
        }
    }
                                                    
    ColumnLayout {
        id: mycroftSkillscolumntab    
        visible: tabBar.currentTab == mycroftSkillsTab;
        anchors.top: root.top
        anchors.left: sidebar.right
        anchors.leftMargin: units.gridUnit * 0.25
        anchors.right: root.right
        anchors.bottom: root.bottom

        SkillsTipViewComponent {
            id: skillTipsView
        }
    }

    ColumnLayout {
        id: mycroftSettingsColumn
        visible: tabBar.currentTab == mycroftSettingsTab;
        anchors.top: root.top
        anchors.left: sidebar.right
        anchors.leftMargin: units.gridUnit * 0.25
        anchors.right: root.right
        anchors.bottom: root.bottom
        
        SettingsComponent{
            id: appletSettings
        }
    }

    ColumnLayout {
        id: mycroftMsmColumn
        visible: tabBar.currentTab == mycroftMSMinstTab;
        anchors.top: root.top
        anchors.left: sidebar.right
        anchors.leftMargin: units.gridUnit * 0.25
        anchors.right: root.right
        anchors.bottom: root.bottom
        
        SkillsInstallerComponent{
            id: skillsInstallerView 
        }
    }
}
                
    PlasmaCore.SvgItem {
        anchors {
            left: main.left
            right: main.right
            bottom: root.bottom
        }
        width: 1
        height: horlineSvg.elementSize("horizontal-line").height

        elementId: "horizontal-line"
                z: 110
        svg: PlasmaCore.Svg {
            id: horlineSvg;
            imagePath: "widgets/line"
        }
    }        
                       
                
Item {
    id: rectanglebottombar
    height: units.gridUnit * 3.5
    anchors.left: main.left
    anchors.right: main.right
    anchors.bottom: main.bottom
    z: 110
    
        BottomBarViewComponent {
            id: bottomBarView
        }
    }
}
