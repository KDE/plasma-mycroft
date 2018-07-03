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
        height: contentdlgtitem.height
        width: cbwidth - units.gridUnit * 0.50
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
            id: contentdlgtitem
            width: parent.width
            height: dashHeader.height + dashHeaderSeprtr.height + nwsseprator.height + dashinner.height
            
            Item {
            id: skillTopRowLayout
            anchors.top: parent.top
            anchors.topMargin: units.gridUnit * 0.25
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: dashHeader.height
            
            Text {
                id: dashHeader
                anchors.left: dashHeaderSeprtr.right
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.Wrap
                font.bold: true
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                text: i18n("Let's Continue ?")
                color: PlasmaCore.ColorScope.textColor
            }
            
            PlasmaCore.SvgItem {
                id: dashHeaderSeprtr
                anchors {
                    left: contxtnewsitemmenu.right
                    leftMargin: units.gridUnit * 0.25
                    verticalCenter: parent.verticalCenter
                }
                height: units.gridUnit * 1
                width: linetopleftvertSvg.elementSize("vertical-line").width
                z: 110
                elementId: "vertical-line"

                svg: PlasmaCore.Svg {
                    id: dashhdrvertSvg;
                    imagePath: "widgets/line"
                }
            }  

            ToolButton {
                id: contxtnewsitemmenu
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                width: units.gridUnit * 1
                height: units.gridUnit * 1
                Image {
                    id: innrnewitemcontxmenuimage
                    source: "../images/ctxmenu.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: units.gridUnit * 0.60
                    height: units.gridUnit * 0.50
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
                anchors.topMargin: units.gridUnit * 0.25
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
            color: PlasmaCore.ColorScope.textColor
            font.pointSize: theme.defaultFont.pointSize
            font.letterSpacing: theme.defaultFont.letterSpacing
            font.wordSpacing: theme.defaultFont.wordSpacing
            font.family: theme.defaultFont.family
            text: i18n("Mycroft by default is powered by a cloud-based speech to text service. Mycroft gives you the ability to change speech to text services or use a locally configured one within their settings at home.mycroft.ai.")
                }
            }
        }
        
        Drawer {
                id: mcmenuItem
                width: dwrpaddedwidth
                height: removeCardRectbtn.height + disableCardRectbtn.height 
                edge: Qt.TopEdge
                dragMargin: 0

                Rectangle {
                    id: menuRectItem
                    anchors.fill: parent
                    color: theme.backgroundColor
            
                    Column {
                        id: menuRectColumn
                        anchors.fill: parent
                        
                        Rectangle {
                            id: removeCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: removeCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "archive-remove"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: removeCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: removeCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Remove Card"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        removeCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        removeCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        dashCardCollectionModel.remove(index)
                                        removeChildCard()
                                    }
                                }
                            }
                            
                        Rectangle {
                            id: btnshorzSepr
                            width: parent.width
                            height: 1
                            color: theme.linkColor
                        }
                            
                        Rectangle {
                            id: disableCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: disableCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "document-close"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: disableCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: disableCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Disable Disclaimer Card"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        disableCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        disableCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        disclaimercardswitch.checked = false
                                        dashCardCollectionModel.remove(index)
                                        removeChildCard()
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
                }
