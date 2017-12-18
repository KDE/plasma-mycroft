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
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    anchors.fill: parent

    Rectangle {
         id: innerCircleSurround
         anchors.centerIn: parent
         color: "#404682b4"
         border.color: "#00000000"
         border.width: units.gridUnit * 0.2
         radius: 100
         implicitWidth: units.gridUnit * 2.7
         implicitHeight: units.gridUnit * 2.7
        }

    Rectangle {
         id: innerCircleSurroundOutterRing
         anchors.centerIn: parent
         color: "#00000000"
         border.color: "lightblue"
         border.width: units.gridUnit * 0.2
         radius: 100
         implicitWidth: units.gridUnit * 2.7
         implicitHeight: units.gridUnit * 2.7
        }

    Rectangle {
         id: innerCircleIn
         anchors.centerIn: parent
         color: "lightblue"
         border.color: "steelblue"
         border.width: units.gridUnit * 0.1
         radius: 100
         implicitWidth: units.gridUnit * 1.7
         implicitHeight: units.gridUnit * 1.7
        }

    Rectangle {
         id: innerCircleInMic
         anchors.centerIn: parent
         color: "#00000000"
         border.color: "#00000000"
         border.width: units.gridUnit * 0.1
         radius: 100
         implicitWidth: units.gridUnit * 1.7
         implicitHeight: units.gridUnit * 1.7

         PlasmaComponents.ToolButton {
            id: innerImgInnerCirc
            anchors.centerIn: parent
            iconSource: "audio-input-microphone"
            width: units.gridUnit * 2
            height: units.gridUnit * 2
            
            onClicked: {
                var socketmessage = {};
                socketmessage.type = "mycroft.mic.listen";
                socketmessage.data = {};
                socketmessage.data.utterances = [];
                socket.sendTextMessage(JSON.stringify(socketmessage));
                }
            }
        }

    ScaleAnimator {
        target: innerCircleSurround
        running: true
        from: 1.2
        to: 0.8
        duration: 3600
        loops: Animation.Infinite
        }

    ScaleAnimator {
        target: innerCircleSurroundOutterRing
        running: true
        from: 1
        to: 0.9
        duration: 3600
        loops: Animation.Infinite
        }

    ScaleAnimator {
        target: innerCircleIn
        running: true
        from: 0.8
        to: 1
        duration: 3600
        loops: Animation.Infinite
        }
}
