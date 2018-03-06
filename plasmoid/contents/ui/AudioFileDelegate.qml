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
        id: audioFileDelegateItm
        implicitHeight: audioFileDelegateInner.height
        color: Qt.darker(theme.backgroundColor, 1.2)
        width: cbwidth
            
        Item {
            id: audioFileDelegateInner
            implicitHeight: Math.max(audioInnerInfoColumn.height, playAudioBtn.height + units.gridUnit * 1)
            width: parent.width

            PlasmaCore.IconItem {
                id: audioImgType
                source: "new-audio-alarm"
                anchors.left: parent.left
                width: units.gridUnit * 1
                height: units.gridUnit * 1
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Item {
                id: audioInnerInfoColumn
                implicitHeight: audioFileName.implicitHeight + sprTrinnerAudio.height + audioFileLoc.implicitHeight + units.gridUnit * 0.50
                anchors.left: audioImgType.right
                anchors.leftMargin: units.gridUnit * 0.30
                anchors.right: playAudioBtn.left
                anchors.rightMargin: units.gridUnit * 0.30

            PlasmaComponents.Label {
                id: audioFileName
                color: theme.textColor
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: units.gridUnit * 0.25
                wrapMode: Text.Wrap
                height: units.gridUnit * 1
                
                Component.onCompleted: {
                     var filterName = InputQuery.toString();
                     audioFileName.text = filterName.match(/\/([^\/]+)\/?$/)[1]
                }
            }
            
            Rectangle {
                id: sprTrinnerAudio
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 1
                anchors.top: audioFileName.bottom
                anchors.topMargin: units.gridUnit * 0.15
                color: theme.linkColor
                height: units.gridUnit * 0.1 
            } 
                
            PlasmaComponents.Label {
                id: audioFileLoc
                color: theme.linkColor
                font.pixelSize: 12
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: sprTrinnerAudio.bottom
                height: units.gridUnit * 1
                wrapMode: Text.Wrap
                Component.onCompleted: {
                    audioFileLoc.text = "<i>Location: " + InputQuery + "</i>"
                }
            }
        }
        
            PlasmaComponents.Button {
                  id: playAudioBtn
                  anchors.right: parent.right
                  anchors.rightMargin: units.gridUnit * 0.75
                  anchors.verticalCenter: parent.verticalCenter
                  width: units.gridUnit * 3.5
                  height: units.gridUnit * 3
                  text: "Listen"

                  onClicked: {
                        var audFile = Qt.resolvedUrl(InputQuery)
                        Qt.openUrlExternally(audFile)
                        }
                    }
            }
    }
