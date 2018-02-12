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
        id: dashDelegateItm
        height: units.gridUnit * 3
        width: cbwidth
        color: theme.backgroundColor

        Item {
            id: contentdlgtitem
            width: parent.width
            height: parent.height
            
            Item {
            id: skillTopRowLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: dashHeader.height
            
            Text {
                id: dashHeader
                anchors.left: parent.left
                anchors.leftMargin: 2
                anchors.right: contxtnewsitemmenu.left
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.Wrap;
                font.bold: true;
                text: i18n("Let's Continue ?")
                color: theme.textColor
            }

            ToolButton {
                id: contxtnewsitemmenu
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                width: units.gridUnit * 1
                height: units.gridUnit * 1
                Image {
                    id: innrnewitemcontxmenuimage
                    source: "../images/ctxmenu.png"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: units.gridUnit * 0.7
                    height: units.gridUnit * 0.7
                }
                ColorOverlay {
                    anchors.fill: innrnewitemcontxmenuimage
                    source: innrnewitemcontxmenuimage
                    color: theme.textColor
                }
                onClicked: {
                    mcmenuItem.open()
                    }
                }
            }

        Rectangle {
                id: nwsseprator
                width: parent.width
                anchors.top: skillTopRowLayout.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
        }

        Item {
            id: dashinner
            width: parent.width
            implicitHeight: nwsdesc.height
            Layout.minimumHeight: units.gridUnit * 2
            anchors.top: nwsseprator.bottom
            anchors.topMargin: 1
            
        Text {
            id: nwsdesc
            wrapMode: Text.Wrap;
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 2
            color: theme.textColor ;
            text: i18n("Mycroft by default is powered by a cloud-based speech to text service. Mycroft gives you the ability to change speech to text services or use a locally configured one within their settings at home.mycroft.ai.")
                }
            }
        }
        
        Drawer {
                id: mcmenuItem
                width: parent.width
                height: units.gridUnit * 5
                edge: Qt.TopEdge
                dragMargin: 0

                Rectangle {
                    anchors.fill: parent
                    color: theme.textColor

                        Rectangle {
                            id: readaloudRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.textColor
                            anchors.top: parent.top
                            anchors.topMargin: units.gridUnit * 0.25
                            Row {
                               spacing: 5
                               Image {
                                   id: readAloudIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "../images/readaloud.png"
                                   width: 32
                                   height: 32
                               }
                               Rectangle {
                                   id: readAloudSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               Label {
                                   id: readAloudLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Listen To/Play The Selected Article"
                                   color: theme.backgroundColor
                               }
                            }
                        }

                        Rectangle {
                            id: btnshorzSepr
                            width: parent.width
                            height: 1
                            color: theme.linkColor
                            anchors.top: readaloudRectbtn.bottom
                            anchors.topMargin: units.gridUnit * 0.25
                        }

                        Rectangle{
                            id: shareNwsBtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.textColor
                            anchors.top: btnshorzSepr.bottom
                            anchors.topMargin: units.gridUnit * 0.25
                            Row {
                               spacing: 5
                               Image {
                                   id: shareNewsIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "../images/share.png"
                                   width: 32
                                   height: 32
                               }
                               Rectangle {
                                   id: shareNewsSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               Label {
                                   id: shareNewsLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Share"
                                   color: theme.backgroundColor
                               }
                            }
                        }
                    }
                }
            }
