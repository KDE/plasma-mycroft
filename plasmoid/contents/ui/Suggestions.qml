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
import QtQuick.Controls 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Rectangle {
    id: suggestionsmainitem
    color: theme.backgroundColor
    anchors.fill: parent
    property alias suggest1: suggestiontext1.text
    property alias suggest2: suggestiontext2.text
    property alias suggest3: suggestiontext3.text

    Rectangle {
        id: suggestionbutton1
        color: theme.backgroundColor
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        border.width: 0.2
        border.color: theme.textColor
        anchors.left: parent.left
        anchors.leftMargin: 0
        width: suggestionsmainitem.width / 3
        
        PlasmaCore.IconItem {
          id: suggest1imageicon  
          anchors.left: parent.left
          anchors.leftMargin: units.gridUnit * 0.5
          source: "set-language"
          width: units.gridUnit * 2
          height: units.gridUnit * 2
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton1.color = theme.textColor
            suggestiontext1.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton1.color = theme.backgroundColor
            suggestiontext1.color = theme.textColor
            }

            onClicked: {
            //var suggest1 = qinput.text
            //var lastIndex = suggest1.lastIndexOf(" ");
            //qinput.text = suggest1.substring(0, lastIndex) +  " " + suggestiontext1.text + " "
                var socketmessage = {};
                socketmessage.type = "recognizer_loop:utterance";
                socketmessage.data = {};
                socketmessage.data.utterances = [qinput.text];
                socket.sendTextMessage(JSON.stringify(socketmessage));
            }
        }

  PlasmaComponents.Label {
            id: suggestiontext1
            text: i18n("Ask Another")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }
    }
    
    PlasmaCore.SvgItem {
        id: suggestbarDividerline1
        anchors {
            left: suggestionbutton1.right
            //rightMargin: units.gridUnit * 0.25
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linesuggest1vertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linesuggest1vertSvg;
            imagePath: "widgets/line"
        }
    } 

    Rectangle {
        id: suggestionbutton2
        color: theme.backgroundColor
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: suggestionbutton3.left
        anchors.rightMargin: 0
        border.width: 0.2
        anchors.left: suggestbarDividerline1.right
        anchors.leftMargin: 0
        border.color: theme.textColor
        
        PlasmaCore.IconItem {
          id: suggest2imageicon  
          anchors.left: parent.left
          anchors.leftMargin: units.gridUnit * 1.3
          source: "gtk-stop"
          width: units.gridUnit * 2
          height: units.gridUnit * 2
        }

        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton2.color = theme.textColor
            suggestiontext2.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton2.color = theme.backgroundColor
            suggestiontext2.color = theme.textColor
            }

            onClicked: {
                var socketmessage = {};
                socketmessage.type = "recognizer_loop:utterance";
                socketmessage.data = {};
                socketmessage.data.utterances = ["stop"];
                socket.sendTextMessage(JSON.stringify(socketmessage));
            }
        }

        PlasmaComponents.Label {
            id: suggestiontext2
            text: i18n("Stop")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }
    
    PlasmaCore.SvgItem {
        id: suggestbarDividerline2
        anchors {
            right: suggestionbutton3.left
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linesuggest2vertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linesuggest2vertSvg;
            imagePath: "widgets/line"
        }
    }

    Rectangle {
        id: suggestionbutton3
        color: theme.backgroundColor
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        border.color: theme.textColor
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        border.width: 0.2
        width: parent.width / 3
        
        PlasmaCore.IconItem {
          id: suggest3imageicon  
          anchors.left: parent.left
          anchors.leftMargin: units.gridUnit * 1.3
          source: "code-function"
          width: units.gridUnit * 2
          height: units.gridUnit * 2
        }

        MouseArea {
            id: mouseArea3
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton3.color = theme.textColor
            suggestiontext3.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton3.color = theme.backgroundColor
            suggestiontext3.color = theme.textColor
            }

            onClicked: {
                convoLmodel.clear()
                if(dashswitch.checked == true && dashLmodel.count == 0){
                    showDash("setVisible")
                }
            }
        }

       PlasmaComponents.Label {
            id: suggestiontext3
            text: i18n("Clear")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            }
        }
}
