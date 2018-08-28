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

Rectangle {
        id: bookDelegateItem
        height: bookContentDelegateItem.height
        width: cbwidth
        border.width: 1        
        border.color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2)
        color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2) 
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 10
            samples: 32
            spread: 0.1
            color: Qt.rgba(0, 0, 0, 0.3)
        }

        Item {
            id: bookContentDelegateItem
            width: parent.width - units.gridUnit * 0.05
            height: topRowLayout.height + bookHeaderItemSeparator.height + bookContentInnerItem.height + buttnRow.height
            
            Rectangle {
            id: topRowLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: bookContentHeader.implicitHeight + units.gridUnit * 0.5
            color: theme.linkColor
            
            Text {
                id: bookContentHeader
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                wrapMode: Text.Wrap;
                font.bold: true;
                font.capitalization: Font.SmallCaps
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                text: i18n(model.booktitle)
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    
                    onEntered: {
                        bookContentHeader.color = PlasmaCore.ColorScope.backgroundColor
                        bookContentHeader.font.underline = true
                    }
                    onExited: {
                        bookContentHeader.color = PlasmaCore.ColorScope.textColor
                        bookContentHeader.font.underline = false
                    }
                    onClicked: {
                        Qt.openUrlExternally(bookurl)
                    }
                }
            }
        }
            
    Rectangle {
            id: bookHeaderItemSeparator
            width: parent.width
            anchors.top: topRowLayout.bottom
            anchors.topMargin: 1
            height: 2
            color: theme.linkColor
        }

    Item {
        id: bookContentInnerItem
        width: parent.width
        height: cbheight / 2.75
        anchors.top: bookHeaderItemSeparator.bottom
        anchors.topMargin: 1
            
        Image {
            id: bookImageItem
            anchors.left: parent.left
            source: model.bookcover
            width: parent.width / 2.75
            height: parent.height
            }
            
        Item {
            id: bookContentAddInfo
            anchors.left: bookImageItem.right
            anchors.leftMargin: units.gridUnit * 2 
            anchors.right: parent.right
            height: parent.height
            
            Column {
                id: additionalInfoColumn
                width: parent.width
                height: parent.height
                spacing: 1.5
                
                    PlasmaComponents.Label {
                        id: bookAuthorLabel
                        font.capitalization: Font.Capitalize
                        text: i18n("Author: %1", bookauthor)
                    }
                    
                    PlasmaComponents.Label {
                        id: bookPublisherLabel
                        font.capitalization: Font.Capitalize
                        text: i18n("Publisher: %1", bookpublisher)
                    }
                    
                    PlasmaComponents.Label {
                        id: bookYearLabel
                        font.capitalization: Font.Capitalize
                        text: i18n("Release Year: %1", bookdate)
                    }
                    
                    PlasmaComponents.Label {
                        id: bookAvailableLabel
                        font.capitalization: Font.Capitalize
                        text: i18n("Availability: %1", bookstatus)
                    }
                }
            }
        }
        
        Row {
            id: buttnRow
            height: units.gridUnit * 2
            anchors.top: bookContentInnerItem.bottom

            PlasmaComponents.Button {
                id: bookReadOnlineBtn
                width: cbwidth / 2
                height: units.gridUnit * 2
                text: i18n("Read Online")
                
                onClicked: {
                    Qt.openUrlExternally(bookurl);
                }
            }
            
            PlasmaComponents.Button {
                id: bookDownloadBtn
                width: cbwidth / 2
                height: units.gridUnit * 2
                text: i18n("Download")
                
                onClicked: {
                    var socketmessage = {};
                    socketmessage.type = "recognizer_loop:utterance";
                    socketmessage.data = {};
                    socketmessage.data.utterances = ["download available book"];
                    socket.sendTextMessage(JSON.stringify(socketmessage));
                }
            }
        }
    }
}
