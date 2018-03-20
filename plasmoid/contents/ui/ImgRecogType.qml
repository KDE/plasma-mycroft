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
import QtQuick.Controls 2.2
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Column {
                    id: colmsg
                    spacing: 6
                    anchors.right: parent.right

                    readonly property bool sentByMe: model.recipient !== "User"
                    //property alias mssg: messageText.text

                    Row {
                        id: messageRow
                        spacing: 6

                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: messageText.implicitHeight
                        color: "#222"

                    Image {
                        id: messageText
                        anchors.top: parent.top
                        anchors.bottom: buttnRow.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectCrop
                        source: model.InputQuery
                        sourceSize.width: cbwidth
                        sourceSize.height: units.gridUnit * 10
                        }
                        
                    Row {
                        id: buttnRow
                        height: units.gridUnit * 2
                        anchors.bottom: parent.bottom
                        
                        PlasmaComponents.Button {
                                id: generalImgRecog
                                width: cbwidth / 2
                                height: units.gridUnit * 2
                                text: "Broad Recognition"
                                
                                onClicked: {
                                    var irecogmsgsend = innerset.customrecog
                                    var socketmessage = {};
                                    socketmessage.type = "recognizer_loop:utterance";
                                    socketmessage.data = {};
                                    socketmessage.data.utterances = [irecogmsgsend + " " + model.InputQuery];
                                    socket.sendTextMessage(JSON.stringify(socketmessage));
                                }
                            }
                        PlasmaComponents.Button {
                                id: ocrImageRecog
                                width: cbwidth / 2
                                height: units.gridUnit * 2
                                text: "OCR Recognition"
                                
                                onClicked: {
                                    var irecogmsgsend = innerset.customocrrecog
                                    var socketmessage = {};
                                    socketmessage.type = "recognizer_loop:utterance";
                                    socketmessage.data = {};
                                    socketmessage.data.utterances = [irecogmsgsend + " " + model.InputQuery];
                                    socket.sendTextMessage(JSON.stringify(socketmessage));
                                }
                            }
                        }
                    }
                }
            }
