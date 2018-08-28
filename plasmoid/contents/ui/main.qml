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
    property alias cbwidth: rectangle2.width
    property var cbwidthmargin: rectangle2.width - conversationListScrollBar.width - units.gridUnit * 0.25
    property alias cbheight: rectangle2.height
    property var dwrpaddedwidth: main.width + units.gridUnit * 1
    property var cbdrawercontentheight: parent.height + units.gridUnit * 0.5 - rectanglebottombar.height
    property string defaultmcorestartpath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh"
    property string defaultmcorestoppath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh"
    property string packagemcorestartcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh"
    property string packagemcorestopcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh"
    property string customlocstartpath: startsrvcustom.text
    property string customlocstoppath: stopsrvcustom.text
    property string customloc: " "
    property string coreinstallstartpath: defaultmcorestartpath
    property string coreinstallstoppath: defaultmcorestoppath
    property variant searchIndex: []
    property variant results: []
    property var smintent
    property var dataContent
    property alias autoCompModel: completionItems
    property alias textInput: qinput
    property alias plcLmodel: placesListModel
    property alias dashLmodel: dashListModel
    property alias recipeLmodel: recipesListModel
    property alias recipeReadLmodel: recipeReadListModel
    property alias stackLmodel: stackexListModel
    property alias bookLmodel: bookListModel
    property alias wikiLmodel: wikiListModel
    property alias yelpLmodel: yelpListModel
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
            socket.sendTextMessage(JSON.stringify(socketmessage));
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
            socket.sendTextMessage(JSON.stringify(socketmessage));
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

ListModel {
        id: placesListModel
    }
    
ListModel{
        id: recipesListModel
    }

ListModel {
        id: recipeReadListModel
    }
    
ListModel {
        id: stackexListModel
    }

ListModel {
        id: bookListModel
    }

ListModel {
        id: wikiListModel
    }
ListModel {
        id: yelpListModel
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
        
    WebSocket {
        id: mycroftStatusCheckSocket
        url: appletSettings.innerset.wsurl
        active: true
        property bool _socketIsAlreadyActive: false
        onStatusChanged: 
            if (mycroftStatusCheckSocket.status == WebSocket.Open && socket.status == WebSocket.Closed) {
            socket.active = true
            mycroftStatusCheckSocket._socketIsAlreadyActive = true
            disclaimbox.visible = false;
            mycroftstartservicebutton.checked = true
            statusId.text = i18n("<b>Connected</b>")
            statusId.color = "green"
            statusId.visible = true
            }

            else if (mycroftStatusCheckSocket.status == WebSocket.Error) {
            mycroftstartservicebutton.checked = false
            mycroftStatusCheckSocket._socketIsAlreadyActive = false
            statusId.text = i18n("<b>Disabled</b>")
            statusId.color = theme.textColor
            statusId.visible = true
            }
        }
        
    WebSocket {
        id: socket
        url: appletSettings.innerset.wsurl
        onTextMessageReceived: {
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            Applet.playwaitanim(msgType);
            
            if (msgType === "mycroft.mic.get_status.response") {
                var micState = somestring.data.muted
                if(micState) {
                    micIsMuted = true
                    qinputmicbx.iconSource = "mic-off"
                }
                else if(!micState) {
                     micIsMuted = false
                     qinputmicbx.iconSource = "mic-on"
                }
            }

            if (msgType === "mycroft.skills.initialized") {
                PlasmaLa.Notify.mycroftConnectionStatus(i18n("Ready..Let's Talk"))
            }

            if (msgType === "recognizer_loop:utterance") {
                qinput.focus = false;
                var intpost = somestring.data.utterances;
                qinput.text = intpost.toString()
                mycroftConversationComponent.conversationModel.append({"itemType": "AskType", "InputQuery": intpost.toString()})
                midbarAnim.wsistalking()
            }
            
            if (msgType === "recognizer_loop:utterance" && dashLmodel.count != 0){
                Dash.showDash("setHide")
            }
            
            if (somestring.data.handler === "fallback" && somestring.data.fallback_handler === "WolframAlphaSkill.handle_fallback" && somestring.type === "mycroft.skill.handler.complete"){
                        if(wolframfallbackswitch.checked == true){
                            Conversation.getFallBackResult(qinput.text)
                    }
            }
            
            if (somestring && somestring.data && typeof somestring.data.intent_type !== 'undefined'){
                smintent = somestring.data.intent_type;
                console.log(smintent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.utterance !== 'undefined' && somestring.type === 'speak'){
                Conversation.filterSpeak(somestring.data.utterance);
            }

            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "data") {
                dataContent = somestring.data.desktop
                Conversation.filterincoming(smintent, dataContent)
            }

            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "visualObject") {
                dataContent = somestring.data.desktop
                Conversation.filtervisualObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "placesObject") {
                dataContent = somestring.data.desktop
                Conversation.filterplacesObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "recipesObject") {
                dataContent = somestring.data.desktop
                Conversation.filterRecipeObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "balooObject") {
                dataContent = somestring.data.desktop
                Conversation.filterBalooObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "stackresponseObject") {
                dataContent = somestring.data.desktop
                Conversation.filterstackObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "bookObject") {
                dataContent = somestring.data.desktop
                Conversation.filterbookObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiObject") {
                dataContent = somestring.data.desktop
                Conversation.filterwikiObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiaddObject") {
                dataContent = somestring.data.desktop
                Conversation.filterwikiMoreObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "yelpObject") {
                dataContent = somestring.data.desktop
                Conversation.filteryelpObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "imageObject") {
                dataContent = somestring.data.desktop
                Conversation.filterImageObject(dataContent)
            }
            
            
            if (msgType === "speak" && !plasmoid.expanded && notificationswitch.checked == true) {
                var post = somestring.data.utterance;
                var title = "Mycroft's Reply:"
                var notiftext = " "+ post;
                PlasmaLa.Notify.mycroftResponse(title, notiftext);
            }
            
             midbarAnim.wsistalking()
        }
                
        onStatusChanged: if (socket.status == WebSocket.Error) {
                                statusId.text = i18n("<b>Connection error</b>")
                                statusId.color = "red"
                                mycroftstartservicebutton.circolour = "red"
                                midbarAnim.showstatsId()
                                statusRetryBtn.visible = true
                                statusRetryBtn.enabled = true
                                drawer.open()
                                waitanimoutter.aniRunError()
                                delay(1250, function() {
                                    drawer.close()
                                })

                         } else if (socket.status == WebSocket.Open) {
                                statusId.text = i18n("<b>Connected</b>")
                                statusId.color = "green"
                                statusRetryBtn.visible = false
                                statusRetryBtn.enabled = false
                                mycroftstartservicebutton.circolour = "green"
                                mycroftStatusCheckSocket.active = false;
                                midbarAnim.showstatsId()
                                PlasmaLa.Notify.mycroftConnectionStatus("Connected")
                                drawer.open()
                                waitanimoutter.aniRunHappy()
                                delay(1250, function() {
                                    drawer.close()
                                    Applet.checkMicrophoneState()
                                })
                         } else if (socket.status == WebSocket.Closed) {
                                statusId.text = i18n("<b>Disabled</b>")
                                statusId.color = theme.textColor
                                PlasmaLa.Notify.mycroftConnectionStatus("Disconnected")
                                mycroftstartservicebutton.circolour = Qt.lighter(theme.backgroundColor, 1.5)
                                midbarAnim.showstatsId()
                         } else if (socket.status == WebSocket.Connecting) {
                                statusId.text = i18n("<b>Starting up..please wait</b>")
                                statusId.color = theme.linkColor
                                mycroftstartservicebutton.circolour = "steelblue"
                                midbarAnim.showstatsId()
                         } else if (socket.status == WebSocket.Closing) {
                                statusId.text = i18n("<b>Shutting down</b>")
                                statusId.color = theme.textColor
                                midbarAnim.showstatsId()
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
                    id: rectangle2
                    anchors.top: mycroftcolumntab.top
                    anchors.topMargin:15
                    anchors.left: mycroftcolumntab.left
                    anchors.right: mycroftcolumntab.right
                    anchors.bottom: mycroftcolumntab.bottom
                
    DropArea {           
        anchors.fill: parent;
        id: dragTarget
        onEntered: {
            for(var i = 0; i < drag.urls.length; i++)
                if(validateFileExtension(drag.urls[i]))
                return
                console.log("No valid files, refusing drag event")
                drag.accept()
                dragTarget.enabled = false
        }
        
        onDropped: {
            for(var i = 0; i < drop.urls.length; i++){
            var ext = getFileExtenion(drop.urls[i]);
            if(ext === "jpg" || ext === "png" || ext === "jpeg"){
            var durl = String(drop.urls[i]);
            mycroftConversationComponent.conversationModel.append({
                "itemType": "DropImg",
                "InputQuery": durl
                })
                inputlistView.positionViewAtEnd();
            }
            
            if(ext === 'mp3'){
                console.log('mp3');
                }
            }
        }
                
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
    
    ListModel {
        id: completionItems
    }
    
    Drawer {
         id: drawer
          width: dwrpaddedwidth
          height: units.gridUnit * 5.5
          edge: Qt.BottomEdge
 
          Rectangle {
            color: theme.backgroundColor
            anchors.fill: parent
          }

     CustomIndicator {
              id: waitanimoutter
              height: 70
              width: 70
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
                  }
          }
    
    Rectangle {
        id: suggestionbottombox
        anchors.top: parent.top
        anchors.bottom: qinput.top
        anchors.right: parent.right
        anchors.left: parent.left
        color: theme.backgroundColor
            
        Suggestions {
            id: suggst
            visible: true;
        }
    }
    
        Rectangle {
        id: keyboardactivaterect
        color: theme.backgroundColor
        border.width: 1
        border.color: Qt.lighter(theme.backgroundColor, 1.2)
        width: units.gridUnit * 2
        height: qinput.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        PlasmaCore.IconItem {
            id: keybdImg
            source: "input-keyboard"
            anchors.centerIn: parent
            width: units.gridUnit * 1.5
            height: units.gridUnit * 1.5
        }

        Rectangle {
            id: keybindic
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            height: 2
            color: "green"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {}
            onExited: {}
            onClicked: {
                if(qinput.visible === false){
                    toggleInputMethod("KeyboardSetActive")
                    }
                else if(qinput.visible === true){
                    toggleInputMethod("KeyboardSetDisable")
                    }
                }
            }
        }
    
    PlasmaComponents.TextField {
        id: qinput
        anchors.left: keyboardactivaterect.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        placeholderText: i18n("Enter Query or Say 'Hey Mycroft'")
        clearButtonShown: true
        
        onAccepted: {
            var doesExist = Autocomplete.autoAppend(autoCompModel, function(item) { return item.name === qinput.text }, qinput.text)
            var evaluateExist = doesExist
            if(evaluateExist === null){
                        autoCompModel.append({"name": qinput.text});
            }
            suggst.visible = true;
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [qinput.text];
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinput.text = ""; 
            }
        
        onTextChanged: {
            Autocomplete.evalAutoLogic();
        }
    }
    
    CustomMicIndicator {
        id: customMicIndicator
        anchors.centerIn: parent
        visible: false
    }
    
    AutocompleteBox {
        id: suggestionsBox
        model: completionItems
        width: parent.width
        anchors.bottom: qinput.top
        anchors.left: parent.left
        anchors.right: parent.right
        filter: textInput.text
        property: "name"
        onItemSelected: complete(item)

        function complete(item) {
            if (item !== undefined)
                textInput.text = item.name
            }
    }
}

}
