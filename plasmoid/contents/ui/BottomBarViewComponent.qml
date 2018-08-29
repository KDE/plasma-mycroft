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
    id: appletBottomBarComponent
    anchors.fill: parent
    property alias autoCompModel: completionItems
    property alias queryInput: qinput
    property alias animationDrawer: drawer
    property alias suggestBox: suggst
    signal animateStepWorking
    signal animateStepHappy
    signal animateStepError
    
    Connections {
        target: appletBottomBarComponent
        onAnimateStepWorking: {
            console.log("Here")
            waitanimoutter.aniRunWorking()
        }
        onAnimateStepHappy: {
            waitanimoutter.aniRunHappy()            
        }
        onAnimateStepError: {
            waitanimoutter.aniRunError()
        }
    }
    
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
