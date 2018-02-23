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
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent
    anchors.topMargin: units.gridUnit * 0.25
    
    SequentialAnimation {
        id: cstMicSeq
        running: false
        loops: Animation.Infinite
        
        ParallelAnimation{
            PropertyAnimation {
                target: cstMicIconLeftHandle
                property: "opacity";
                from: 1
                to: 0
                duration: 1000
            }
            PropertyAnimation {
                target: cstMicIconRightHandle
                property: "opacity";
                from: 1
                to: 0
                duration: 1000
            }
        }
    }
    
    Image {
        id: cstMicIconLeftHandle
        width: units.gridUnit * 1.5
        height: units.gridUnit * 3
        opacity: 0.50
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: cstMicIcon.left
        anchors.rightMargin: -units.gridUnit * 1
        smooth: true
        mipmap: true
        source: "../images/mleftsmallanim.png"
    }
    
    ColorOverlay {
        anchors.fill: cstMicIconLeftHandle
        source: cstMicIconLeftHandle
        color: theme.linkColor
    }
    
    Image {
        id: cstMicIconRightHandle
        width: units.gridUnit * 1.5
        height: units.gridUnit * 3
        opacity: 0.50
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: cstMicIcon.right
        anchors.leftMargin: -units.gridUnit * 1
        smooth: true
        mipmap: true
        source: "../images/mrightsmallanim.png"
    }
    
    ColorOverlay {
        anchors.fill: cstMicIconRightHandle
        source: cstMicIconRightHandle
        color: theme.linkColor
    }

    Image {
        id: cstMicIcon
        anchors.centerIn: parent
        width: units.gridUnit * 3.5
        height: units.gridUnit * 3.5
        smooth: true
        mipmap: true
        source: "../images/mycroftmic.png"
        
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            
            onEntered: {
                clovrLyCSTmic.color = theme.textColor
                cstMicSeq.running = true
            }
            
            onExited: {
                clovrLyCSTmic.color = theme.linkColor
                cstMicSeq.running = false
            }
            
            onClicked: {
                var socketmessage = {};
                socketmessage.type = "mycroft.mic.listen";
                socketmessage.data = {};
                socketmessage.data.utterances = [];
                socket.sendTextMessage(JSON.stringify(socketmessage));
            }
        }
    }
    
    ColorOverlay {
        id: clovrLyCSTmic
        anchors.fill: cstMicIcon
        source: cstMicIcon
        color: theme.linkColor
    }
    
}
