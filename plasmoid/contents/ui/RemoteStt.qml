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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Item {
    id: root
    anchors.fill: parent
    property alias record: audrectimer.running
    
    Mycroft.AudioRec {
        id: audioRec
    }
        
    Timer {
        id: audrectimer
        interval: 10000
        running: false
        onRunningChanged: {
            if(running){
                audioRec.recordTStart()
                numAnim.start()
            } else {
                audioRec.recordTStop()
            }
        }
    }

    function sendAudioClip() {
        audioRec.returnStream()
    }

    Connections {
        target: audioRec
        onRecordTStatus: {
            console.log(recStatus)
            switch(recStatus){
            case "Completed":
                console.log("In Completed")
                audioRec.readStream()
                sendAudioClip()
                audioRecorder.close()
                break;
            case "Error":
                console.log("inError")
                break;
            }
        }
    }

    ColumnLayout {
        id: closebar
        anchors.fill: parent
        spacing: 0

        Kirigami.Heading {
            id: lbl1
            text: "Listening"
            level: 2
            font.bold: true
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Kirigami.Separator {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            ProgressBar {
                id: bar
                to: 100
                from: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Kirigami.Units.largeSpacing
                anchors.rightMargin: Kirigami.Units.largeSpacing
                anchors.verticalCenter: parent.verticalCenter

                contentItem: Item {
                    implicitWidth: parent.width
                    implicitHeight: parent.height

                    Rectangle {
                        width: bar.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: Kirigami.Theme.linkColor }
                            GradientStop { position: 0.3; color: Qt.lighter(Kirigami.Theme.linkColor, 1.5)}
                            GradientStop { position: 0.6; color: Qt.lighter(Kirigami.Theme.linkColor, 1.5)}
                            GradientStop { position: 1.0; color: Kirigami.Theme.linkColor }
                        }
                    }
                }

                NumberAnimation {
                    id: numAnim
                    target: bar
                    property: "value"
                    from: 0
                    to: 100
                    duration: 10000
                }
            }
        }

        Kirigami.Separator {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
        }

        Rectangle {
            color: Kirigami.Theme.hoverColor
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit * 1.5

            Kirigami.Heading {
                level: 2
                text: "Close"
                anchors.centerIn: parent
                anchors.margins: Kirigami.Units.largeSpacing
            }

            MouseArea {
                anchors.fill: parent
                onClicked: audioRecorder.close()
            }
        }
    }
}
 
