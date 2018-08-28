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

Drawer {
        id: askTypeMenuItem
        width: dwrpaddedwidth
        height: removeRectbtn.height + searchRectbtn.height 
        edge: Qt.TopEdge
        dragMargin: 0

        Rectangle {
            id: askMenuRectItem
            anchors.fill: parent
            color: theme.backgroundColor
    
            Column {
                id: menuRectColumn
                anchors.fill: parent
                
                Rectangle {
                    id: removeRectbtn
                    width: parent.width
                    height: units.gridUnit * 2
                    color: theme.backgroundColor
                    
                    Row {
                        spacing: 5
                        PlasmaCore.IconItem {
                            id: removeRectIcon
                            anchors.verticalCenter: parent.verticalCenter
                            source: "window-close"
                            width: units.gridUnit * 2
                            height: units.gridUnit * 2
                        }
                        Rectangle {
                            id: removeRectSeperater
                            width: 1
                            height: parent.height
                            color: theme.linkColor
                        }
                        PlasmaComponents.Label {
                            id: removeRectLabel
                            anchors.verticalCenter: parent.verticalCenter
                            text: i18n("Remove")
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                            onEntered: {
                                removeRectLabel.color = theme.linkColor
                            }
                            onExited:{
                                removeRectLabel.color = theme.textColor
                            }
                            onClicked:{
                                convoLmodel.remove(index)
                            }
                        }
                    }
                
                Rectangle {
                    id: btnshorzSepr1
                    width: parent.width
                    height: 1
                    color: theme.linkColor
                }
                
                Rectangle {
                    id: searchRectbtn
                    width: parent.width
                    height: units.gridUnit * 2
                    color: theme.backgroundColor
                    
                    Row {
                        spacing: 5
                        PlasmaCore.IconItem {
                            id: searchRectIcon
                            anchors.verticalCenter: parent.verticalCenter
                            source: "system-search"
                            width: units.gridUnit * 2
                            height: units.gridUnit * 2
                        }
                        Rectangle {
                            id: searchRectSeperater
                            width: 1
                            height: parent.height
                            color: theme.linkColor
                        }
                        PlasmaComponents.Label {
                            id: searchRectLabel
                            anchors.verticalCenter: parent.verticalCenter
                            text: i18n("Search Online")
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                            onEntered: {
                                searchRectLabel.color = theme.linkColor
                            }
                            onExited:{
                                searchRectLabel.color = theme.textColor
                            }
                            onClicked:{
                                Qt.openUrlExternally("https://duckduckgo.com/?q=" + model.InputQuery)
                            }
                        }
                    }

                Rectangle {
                    id: btnshorzSeprEnd
                    width: parent.width
                    height: units.gridUnit * 0.75
                    color: theme.linkColor
                    
                    PlasmaCore.IconItem {
                            id: closemenuDrawer
                            anchors.centerIn: parent
                            source: "go-up"
                            width: units.gridUnit * 2
                            height: units.gridUnit * 2
                        }
                    }
                }
            }
        }
