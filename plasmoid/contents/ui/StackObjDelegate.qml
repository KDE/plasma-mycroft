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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtGraphicalEffects 1.0

Item {
        id: stackObjDelegateItm
        height: skillTopRowLayout.height + stackObjInner.height + stackObjFooterArea.height + units.gridUnit * 0.5
        width: cbwidth

        Rectangle {
            id: contentdlgtitem
            width: parent.width
            height: parent.height
            color: Qt.darker(theme.backgroundColor, 1.2)
            border.width: 0.75
            border.color: theme.linkColor
            
        Item {
        id: skillTopRowLayout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: units.gridUnit * 0.25
        implicitHeight: stackObjHeaderTitle.implicitHeight + units.gridUnit * 0.5
            
        Text {
            id: stackObjHeaderTitle
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            wrapMode: Text.Wrap;
            font.bold: true;
            text: model.sQuestion
            color: theme.textColor
            }
        }

        Item {
            id: stackObjInner
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: skillTopRowLayout.bottom
            anchors.margins: units.gridUnit * 0.25
            implicitHeight: stackObjLink.height
            Layout.minimumHeight: units.gridUnit * 2.5

            Text {
            id: stackObjLink
            wrapMode: Text.Wrap;
            width: parent.width
            color: theme.textColor
            font.pointSize: 9
            text: i18n("<i>%1</i>", model.sLink)
            }
        }
        
        Item {
            id: stackObjFooterArea
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            implicitHeight: stackObjLink.height
            Layout.minimumHeight: units.gridUnit * 2
            
            Rectangle {
                id: stackObjAnswerAvailableBg
                color: theme.linkColor
                width: parent.width / 3
                anchors.left: parent.left
                height: parent.height
                border.width: 0.75
                border.color: theme.backgroundColor
                
                Text {
                    id: stackObjAnswerAvailableLabel
                    anchors.centerIn: parent
                    font.pointSize: 9
                    color: theme.textColor
                    
                    Component.onCompleted:{
                        if (sIsAnswered) {
                                stackObjAnswerAvailableLabel.text = i18n("Answered")
                        }
                        else {
                                stackObjAnswerAvailableLabel.text = i18n("Unanswered")
                        }
                    }
                }
            }
            
            Rectangle {
                id: stackObjAnswerCountBg
                color: theme.linkColor
                width: parent.width / 3
                anchors.left: stackObjAnswerAvailableBg.right
                height: parent.height
                border.width: 0.75
                border.color: theme.backgroundColor
                
                Text {
                    id: stackObjAnswerCountLabel
                    anchors.centerIn: parent
                    text: i18n("Replies: %1", sAnswerCount)
                    font.pointSize: 9
                    color: theme.textColor
                }
            }
            
            Rectangle {
                id: stackObjAuthorBg
                color: theme.linkColor
                width: parent.width / 3
                anchors.left: stackObjAnswerCountBg.right
                height: parent.height
                border.width: 0.75
                border.color: theme.backgroundColor
                
                Text {
                    id: stackObjAuthorLabel
                    anchors.centerIn: parent
                    text: sAuthor
                    font.pointSize: 9
                    color: theme.textColor
                }
            }
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.openUrlExternally(sLink)
            }
        }
    }
}
