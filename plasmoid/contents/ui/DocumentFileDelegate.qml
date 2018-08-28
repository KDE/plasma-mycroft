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
import QtMultimedia 5.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
        id: documentFileDelegateItm
        implicitHeight: documentFileDelegateInner.height
        color: Qt.darker(theme.backgroundColor, 1.2)
        width: cbwidth
            
        Item {
            id: documentFileDelegateInner
            implicitHeight: Math.max(documentInnerInfoColumn.height, playDocumentBtn.height + units.gridUnit * 1)
            width: parent.width

            PlasmaCore.IconItem {
                id: documentImgType
                source: "document-new"
                anchors.left: parent.left
                width: units.gridUnit * 1
                height: units.gridUnit * 1
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Item {
                id: documentInnerInfoColumn
                implicitHeight: documentFileName.implicitHeight + sprTrinnerDocument.height + documentFileLoc.implicitHeight + units.gridUnit * 0.50
                anchors.left: documentImgType.right
                anchors.leftMargin: units.gridUnit * 0.30
                anchors.right: playDocumentBtn.left
                anchors.rightMargin: units.gridUnit * 0.30

            PlasmaComponents.Label {
                id: documentFileName
                color: theme.textColor
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: units.gridUnit * 0.25
                wrapMode: Text.Wrap
                
                Component.onCompleted: {
                     var filterName = InputQuery.toString();
                     documentFileName.text = filterName.match(/\/([^\/]+)\/?$/)[1]
                }
            }
            
            Rectangle {
                id: sprTrinnerDocument
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 1
                anchors.top: documentFileName.bottom
                anchors.topMargin: units.gridUnit * 0.15
                color: theme.linkColor
                height: units.gridUnit * 0.1 
            } 
                
            PlasmaComponents.Label {
                id: documentFileLoc
                color: theme.linkColor
                font.pointSize: 9
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: sprTrinnerDocument.bottom

                wrapMode: Text.Wrap
                Component.onCompleted: {
                    documentFileLoc.text = "<i>Location: " + InputQuery + "</i>"
                }
            }
        }
        
            PlasmaComponents.Button {
                  id: playDocumentBtn
                  anchors.right: parent.right
                  anchors.rightMargin: units.gridUnit * 0.75
                  anchors.verticalCenter: parent.verticalCenter
                  width: units.gridUnit * 3.5
                  height: units.gridUnit * 3
                  text: i18n("Open")

                  onClicked: {
                        var docFile = Qt.resolvedUrl(InputQuery)
                        Qt.openUrlExternally(docFile)
                        }
                    }
            }
    }
