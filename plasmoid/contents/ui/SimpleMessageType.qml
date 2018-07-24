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
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.core 2.0 as PlasmaCore
import QtGraphicalEffects 1.0

Item {
    width: cbwidth
    height: messageRect.height + timeStampLabel.height
    property alias mssg: messageText.text
                    
        Row {
            id: messageRow
            spacing: 6
            
        Item {
            id: repImgBox
            width: units.gridUnit * 2
            height: units.gridUnit * 2
            
            Image {
                id: repImg
                anchors.fill: parent
                source: "../images/mycroftsmaller2.png"
            }
            
            ColorOverlay {
                anchors.fill: repImg
                source: repImg
                color: theme.linkColor
            }
        }
        
        Column{ 
            spacing: 1
        
        Item {
            id: simplemsgRectFrameItem
            width: cbwidth
            height: messageRect.height
       
        Rectangle {
            id: messageRect
            anchors.left: simpleMsgRectedge.right
            anchors.leftMargin: -2
            width: cbwidth - units.gridUnit * 2
            radius: 2
            height: messageText.implicitHeight + 24
            color: Qt.lighter(theme.backgroundColor, 1.2)
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 1
                radius: 10
                samples: 32
                spread: 0.1
                color: Qt.rgba(0, 0, 0, 0.3)
            }
            
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            propagateComposedEvents: true
            onEntered: {
                messageRect.color = Qt.lighter(theme.backgroundColor, 1.5)
                simpleMsgRectedgeOverLay.color = Qt.lighter(theme.backgroundColor, 1.5)
            }
            onExited: {
                messageRect.color = Qt.lighter(theme.backgroundColor, 1.2)
                simpleMsgRectedgeOverLay.color = Qt.lighter(theme.backgroundColor, 1.2)
            }
            onClicked:{
                simpleCtxMenu.open()
            }
        }
                                    
        PlasmaComponents.Label {
            id: messageText
            text: model.InputQuery
            anchors.fill: parent
            anchors.margins: 12
            wrapMode: Label.Wrap
        }
            }
            
        Image {
            id: simpleMsgRectedge
            anchors.left: parent.left
            anchors.top: parent.top
            source: "../images/arleft.png"
            width: units.gridUnit * 0.50
            height: units.gridUnit * 1.25
         }

        ColorOverlay {
                id: simpleMsgRectedgeOverLay
                anchors.fill: simpleMsgRectedge
                source: simpleMsgRectedge
                color: Qt.lighter(theme.backgroundColor, 1.2)
        }
            }
        
        Text {
            id: timeStampLabel
            anchors.left: parent.left
            anchors.leftMargin: units.gridUnit * 0.50
            width: units.gridUnit * 2.5
            height: units.gridUnit * 0.50
            color: Qt.darker(theme.textColor, 1.5)
            font.pointSize: theme.defaultFont.pointSize - 2
            font.letterSpacing: theme.defaultFont.letterSpacing
            font.wordSpacing: theme.defaultFont.wordSpacing
            font.family: theme.defaultFont.family
            renderType: Text.NativeRendering 
            text: currentDate.toLocaleTimeString(Qt.locale(), Locale.ShortFormat);
            }
                }
                    }
        SimpleMessageTypeMenu{
            id: simpleCtxMenu 
        }
    }
