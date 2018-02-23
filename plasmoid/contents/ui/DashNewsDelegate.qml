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
        id: dashDelegateItm
        height: skillTopRowLayout.height + dashinner.height + dashItemSrcMeta.height + units.gridUnit * 0.5
        width: cbwidth

        Item {
            id: contentdlgtitem
            width: parent.width
            height: parent.height
            
            Item {
            id: skillTopRowLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: dashHeader.implicitHeight + units.gridUnit * 0.5
            
            Text {
                id: dashHeader
                anchors.left: dashHeaderSeprtr.right
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - Math.round(contxtnewsitemmenu.width + units.gridUnit * 1.25)
                wrapMode: Text.Wrap;
                font.bold: true;
                text: newsTitle
                color: theme.textColor
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
            anchors.right: ctxImgIcon.left
            anchors.left: parent.left
            anchors.leftMargin: 2
            color: theme.textColor ;
            text: newsDescription
            
            Component.onCompleted: {
                if (!nwsdesc.text) {
                    nwsdesc.text = newsTitle
                }
            }
        }

        Image {
            id: ctxImgIcon
            anchors.right: parent.right
            anchors.margins: units.gridUnit * 0.5
            source: newsImgURL
            width: 64
            height: parent.height
            
            Component.onCompleted: {
                if (ctxImgIcon.source == "") {
                        ctxImgIcon.source = "../images/newsicon.png"
                    }
                }
            
            }
        }
       
        Rectangle {
                id: nwsseprator2
                width: parent.width
                anchors.top: dashinner.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
        }
       
         Rectangle {
             id: dashItemSrcMeta
             implicitWidth: dashItemSrcName.implicitWidth + units.gridUnit * 1
             anchors.left: parent.left
             anchors.top: nwsseprator2.bottom 
             anchors.topMargin: 1
             color: theme.linkColor
             height: units.gridUnit * 1.25

              Text {
                  id: dashItemSrcName
                  wrapMode: Text.Wrap;
                  anchors.centerIn: parent
                  color: theme.textColor ;
                  text: newsSource
                    }
                }
                
        Text {
            id: dashItemPwrBy
            anchors.top: nwsseprator2.bottom 
            anchors.topMargin: 1
            wrapMode: Text.Wrop;
            anchors.right: parent.right
            color: theme.textColor;
            font.pixelSize: 10
            text: i18n("<i>Powered By: NewsAPI</i>")
            }
        }
        
        Drawer {
                id: mcmenuItem
                width: dwrpaddedwidth
                height: audionewsCardRectbtn.height + shareCardRectbtn.height + removeCardRectbtn.height + disableCardRectbtn.height 
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
                            id: audionewsCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: audionewsCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "media-playback-start"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: audionewsCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: audionewsCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Play / Listen To News Article"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        audionewsCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        audionewsCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                    mcmenuItem.close()
                                    var sendnewsurl = "getarticle newsurl " + newsURL
                                    var socketmessage = {};
                                        socketmessage.type = "recognizer_loop:utterance";
                                        socketmessage.data = {};
                                        socketmessage.data.utterances = [sendnewsurl];
                                        socket.sendTextMessage(JSON.stringify(socketmessage));
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
                            id: shareCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: shareCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "retweet"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: shareCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: shareCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Share News Link"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        shareCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        shareCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        mcmenuItem.close()
                                        sharePagePopup.open()
                                    }
                                }
                            }

                        
                        Rectangle {
                            id: btnshorzSepr2
                            width: parent.width
                            height: 1
                            color: theme.linkColor
                        }
                        
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
                                        dashnewsListModel.remove(index)
                                    }
                                }
                            }
                            
                        Rectangle {
                            id: btnshorzSepr3
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
                                   text: "Disable News Cards"
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
                                        dashnewsListModel.remove(index)
                                        removeChildCard()
                                        newscardswitch.checked = false
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
