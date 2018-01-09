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

Column {
        spacing: 6
        anchors.right: parent.right
        property alias mssg: messageText.text
                        
        Rectangle {
            id: messageRect
            anchors.right: parent.right
            implicitWidth: messageText.width + 10
            radius: 2
            height: messageText.implicitHeight + 24
            color: theme.linkColor
            
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true
                onEntered: { 
                    removeItemButton.visible = true
                    searchItemButton.visible = true
                }
                onExited: { 
                    removeItemButton.visible = false
                    searchItemButton.visible = false
                }
            }
            
            PlasmaCore.IconItem {
                id: removeItemButton
                source: "window-close"
                width: units.gridUnit * 1.5
                height: units.gridUnit * 1.5
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: -units.gridUnit * 0.75
                visible: false
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true
                    onEntered: { 
                        removeItemButton.visible = true
                    }
                    onClicked: {
                        convoLmodel.remove(index)
                    }
                }
            }
            
                PlasmaCore.IconItem {
                        id: searchItemButton
                        source: "system-search"
                        width: units.gridUnit * 1.5
                        height: units.gridUnit * 1.5
                        anchors.bottom: parent.bottom
                        anchors.right: removeItemButton.right
                        anchors.rightMargin: units.gridUnit * 1.0
                        anchors.bottomMargin: -units.gridUnit * 0.75
                        visible: false
                        
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            propagateComposedEvents: true
                            onEntered: { 
                                searchItemButton.visible = true
                            }
                            onClicked: {
                                Qt.openUrlExternally("https://duckduckgo.com/?q=" + model.InputQuery)
                            }
                        }
                    }
            
        PlasmaComponents.Label {
            id: messageText
            text: model.InputQuery
            anchors.centerIn: parent
            wrapMode: Label.Wrap
            color: theme.backgroundColor
            }
                }
                                    }
