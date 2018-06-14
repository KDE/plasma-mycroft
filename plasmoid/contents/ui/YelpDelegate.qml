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

Rectangle {
        id: yelpDelegateItm
        height: units.gridUnit * 7
        color: Qt.darker(theme.backgroundColor, 1.2)
        anchors.left: parent.left
        anchors.right: parent.right
        width: cbwidth

        Column {
            id: contentdlgtitem
            anchors.fill: parent
            
            Text {
                id: yelpname
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap;
                font.bold: true;
                text: model.restaurant
                color: theme.textColor
                }
            
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                color: theme.linkColor
                height: units.gridUnit * 0.1 
                }

        Item {
            id: yelpinner
            height: units.gridUnit * 5
            width: cbwidth

            Image {
                id: yelpImgType
                source: model.image_url
                anchors.left: parent.left
                width: units.gridUnit * 4
                height: units.gridUnit * 5
            }
            
            Item {
                id: yelpInnerInfoColumn
                height: parent.height
                anchors.left: yelpImgType.right
                anchors.right: yelpViewBtn.left
                
            Text{
                id: yelpCalorieCount
                width: parent.width;
                color: theme.textColor ;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                text: "<i>Phone:</i> " + model.phone
                }
                
            Text{
                id: yelpDietLabel
                color: theme.textColor ;
                anchors.top: yelpCalorieCount.bottom
                anchors.topMargin: units.gridUnit * 0.2
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.25
                width: parent.width
                text: "<i>Location:</i> " + model.location
                wrapMode: Text.WrapAnywhere
                }
                
            Text{
                id: yelpHealthTagsLabel
                width: parent.width;
                color: theme.textColor ;
                anchors.top: yelpDietLabel.bottom
                anchors.topMargin: units.gridUnit * 0.2
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                text: "<i>Rating:</i> " + model.rating + " Stars"
                }
            }
            
            PlasmaComponents.Button {
                  id: yelpViewBtn
                  anchors.top: parent.top
                  anchors.right: parent.right
                  width: units.gridUnit * 6;
                  height: units.gridUnit * 2.5;
                  text: "Checkout"
                  onClicked: {
                       Qt.openUrlExternally(model.url)
                        }
                    }
            PlasmaComponents.Button {
                  id: yelpSendMsgBtn
                  anchors.top: yelpViewBtn.bottom
                  anchors.right: parent.right
                  width: units.gridUnit * 6;
                  height: units.gridUnit * 2.5;
                  text: "Send As Text"
                  onClicked: {
                        var sendmsgUtterance = "send info"
                        var socketmessage = {};
                        socketmessage.type = "recognizer_loop:utterance";
                        socketmessage.data = {};
                        socketmessage.data.utterances = [sendmsgUtterance];
                        socket.sendTextMessage(JSON.stringify(socketmessage));
                        }
                    }
            }
        
        Rectangle {
                id: yelpFooterSrc
                anchors.left: parent.left
                anchors.right: parent.right
                color: theme.linkColor
                height: units.gridUnit * 1
                
            Text {
                color: theme.textColor ;
                font.pixelSize: 10
                text: "<i>Powered By: Yelp.com</i>"
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
