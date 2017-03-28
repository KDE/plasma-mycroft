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
import org.kde.plasma.private.volume 0.1

Item {
    id: main
    Layout.fillWidth: true;
    Plasmoid.toolTipMainText: i18n("Mycroft")
    Plasmoid.switchWidth: units.gridUnit * 15
    Plasmoid.switchHeight: units.gridUnit * 15
    Layout.minimumHeight: units.gridUnit * 18
    Layout.minimumWidth: units.gridUnit * 22
    
    Component.onCompleted: {
    mycroftStatusCheckSocket.active = true
    console.log(mycroftStatusCheckSocket.status)
    }
    
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

    function muteMicrophone() {
        if (!sourceModel.defaultSource) {
            return;
        }
        var toMute = !sourceModel.defaultSource.muted;
        sourceModel.defaultSource.muted = toMute;
    }
    
        function filtersuggest() {
        var keywordToSearch = qinput.text;
        var result = wordSuggest(keywordToSearch);
        if(result.length>0){
                suggst.suggest1 = result[0];
                suggst.suggest2 = result[1];
                suggst.suggest3 = result[2];
                suggst.visible=true;
            }
        else{
            suggst.visible=false;
        }
    }
    function wordSuggest(keywordToSearch){
        var baseLocation = "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/ui/suggestion/";
        var files = [{
            "id" : "1",
            "category" : "math",
            "keywordFile" : baseLocation + "MathKeywords.txt",
            "listFile" : baseLocation + "MathList.txt",
            },
            {
            "id" : "2",
            "category" : "general",
            "keywordFile" : baseLocation + "GeneralKeywords.txt",
            "listFile" : baseLocation + "GeneralList.txt",
            },
            {
            "id" : "3",
            "category" : "wiki",
            "keywordFile" : baseLocation + "WikiKeywords.txt",
            "listFile" : baseLocation + "WikiList.txt",
            },
            {
            "id" : "4",
            "category" : "weather",
            "keywordFile" : baseLocation + "WeatherKeywords.txt",
            "listFile" : baseLocation + "WeatherList.txt",
            },
            {
            "id" : "5",
            "category" : "desktop",
            "keywordFile" : baseLocation + "DesktopKeywords.txt",
            "listFile" : baseLocation + "DesktopList.txt",
            }];
            var baseSearch,keywords,keywordsFile,list,listFile,suggestion = ['9','8','7'];
            for (var i=0; i < files.length; i++){
                baseSearch = files[i];
                keywordsFile = PlasmaLa.FileReader.read(baseSearch.keywordFile).toString("utf-8");
                keywords = keywordsFile.split('\n');
                keywords = keywords.filter(Boolean);
                
                for(var j=0; j < keywords.length; j++){
                    keywordToSearch = keywordToSearch.toLowerCase();
                    if(keywordToSearch.indexOf(keywords[j]) !== -1){
                        listFile = PlasmaLa.FileReader.read(baseSearch.listFile).toString("utf-8");
                        list = listFile.split('\n');
                        list = list.filter(Boolean);
            
                        for(var k=0; k < 3; k++){
                            suggestion[k] = list[Math.floor(list.length * Math.random())];
                        }
                        return suggestion;
                    }
                    if(keywordToSearch.indexOf(keywords[j]) === -1){
                        suggst.visible = false;
                    }
                }
            }}
            
            
        function filterinput() {
                conversationInputList.append({"InputQuery": qboxoutput.text});
                inputlistView.positionViewAtEnd(); 
        }
    
    
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
        id: mycroftStatusCheckSocket
        url: "ws://0.0.0.0:8181/core"
        onTextMessageReceived: {
            console.log("Mycroft Status Ping");
        }
            active: true
            onStatusChanged: 
            if (mycroftStatusCheckSocket.status == WebSocket.Open && socket.status == WebSocket.Closed) {
            console.log("Activated")
            socket.active = true
            mycroftstartservicebutton.checked = true
            mycroftstartservicebutton.iconSource = "media-playback-pause"
            statusId.text = "Mycroft is Ready"
            statusId.color = "green"
            }

            else if (mycroftStatusCheckSocket.status == WebSocket.Error) {
            mycroftstartservicebutton.checked = false
            mycroftstartservicebutton.iconSource = "media-playback-start"
            statusId.text = "Mycroft is Disabled"
            statusId.color = "#f4bf42"
            }
        }
        
        WebSocket {
        id: socket
        url: "ws://0.0.0.0:8181/core"
        onTextMessageReceived: {
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            qinput.focus = false;
            
            if (msgType === "recognizer_loop:utterance") {
                var intpost = somestring.data.utterances;
                qinput.text = intpost.toString()
                filtersuggest();
            }
            
            if (msgType === "speak") {
                var post = somestring.data.utterance;
                qboxoutput.text = post;
                filterinput()
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
                                mycroftStatusCheckSocket.active = false;
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
        color: theme.backgroundColor
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
                    //console.log(coreinstallstartpath);
                    mycroftstartservicebutton.checked = !mycroftstartservicebutton.checked
                    if (mycroftstartservicebutton.checked === false) {
                        mycroftstartservicebutton.iconSource = "media-playback-start"
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstoppath);
                        conversationInputList.clear()
                        suggst.visible = false;
                        socket.active = false;
                    }
                    
                    if (mycroftstartservicebutton.checked === true) {
                        mycroftstartservicebutton.iconSource = "media-playback-pause"
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstartpath);
                        conversationInputList.clear()
                        suggst.visible = false;
                        delay(10000, function() {
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
        anchors.topMargin: -12;
        color: theme.backgroundColor
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
                anchors.top: mycroftcolumntab.top
                anchors.topMargin:15
                anchors.left: mycroftcolumntab.left
                anchors.right: mycroftcolumntab.right
                anchors.bottom: suggestionbottombox.top
                
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
                    spacing: 12
                    model: conversationInputList
                    delegate: Loader {
                        source: "MessageBox.qml"
                    }
                    ScrollBar.vertical: ScrollBar {}

    onCountChanged: {
        inputlistView.positionViewAtEnd();
    }
                                }
                                    }
                                        }
                                            }
                               
                    Rectangle {
                    id: suggestionbottombox
                    anchors.bottom: mycroftcolumntab.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    color: theme.backgroundColor
                    height: 40;
                    
                    Flickable {
                    width: parent.width
                    height: suggestionbottombox.height
                    contentWidth: 1000
                    contentHeight: suggestionbottombox.height
                    interactive: true;
                    
                        Suggestions {
                            id: suggst
                            visible: false;
                        }
                        
                                            ScrollBar.horizontal: ScrollBar {}
                        
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

Text {
 id: qboxoutput
 text: " "
 visible: false
}

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
                //height: skillimage.height
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
        color: theme.backgroundColor
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
                anchors.right: qinputmicbx.left
                placeholderText: i18n("Enter Query or Say 'Hey Mycroft'")
                clearButtonShown: true

                onAccepted: {
                suggst.visible = false;
                conversationInputList.append({"InputQuery": qinput.text});
                inputlistView.positionViewAtEnd();

                var socketmessage = {};
                socketmessage.type = "recognizer_loop:utterance";
                socketmessage.data = {};
                socketmessage.data.utterances = [qinput.text];
                socket.sendTextMessage(JSON.stringify(socketmessage));
                filtersuggest();
                qinput.text = "";                
                if (socket.status == WebSocket.Error) {
                                barAnim.wsocerroranimtoggle()
                         }                
                else {
                    barAnim.wsocmsganimtoggle();                    
                }
                } 
                }
                
                PlasmaComponents.ToolButton {
                id: qinputmicbx
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "mic-on"
                flat: true
                width: 42
                height: 42
    
                onClicked: {
                    if (qinputmicbx.iconSource == "mic-on") {
                        qinputmicbx.iconSource = "mic-off"
                    }
                    else if (qinputmicbx.iconSource == "mic-off") {
                        qinputmicbx.iconSource = "mic-on"
                    }
                    muteMicrophone()
                }    
                }
            }

        }
     }
}

SourceModel {
        id: sourceModel
                }
Settings {
     property alias customsetuppath: settingsTabUnitsOpThree.text
     property alias notifybool: notificationswitch.checked
     property alias radiobt1: settingsTabUnitsOpOne.checked
     property alias radiobt2: settingsTabUnitsOpTwo.checked
     property alias radiobt3: settingsTabUnitsOpZero.checked
    }
}
