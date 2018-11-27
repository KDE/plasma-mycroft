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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Rectangle {
    id: tipscontent
    height: Kirigami.Units.gridUnit * 5
    anchors.left: parent.left
    anchors.right: parent.right
    border.width: 1
    border.color: Qt.darker(theme.linkColor, 1.2)
    color: Qt.darker(theme.backgroundColor, 1.2)

    RowLayout {
        anchors.fill: parent
        
        Image {
            id: innerskImg
            source: Pic
            Layout.preferredWidth: Kirigami.Units.gridUnit * 1.2
            Layout.preferredHeight: Kirigami.Units.gridUnit * 1.2
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: units.gridUnit * 0.25
        }

        PlasmaCore.SvgItem {
            Layout.preferredWidth: lineskillpgSvg.elementSize("vertical-line").width
            Layout.fillHeight: true
            z: 110
            elementId: "vertical-line"

            svg: PlasmaCore.Svg {
                id: lineskillpgSvg;
                imagePath: "widgets/line"
            }
        }

        Item {
            id: skilltipsinner
            Layout.fillWidth: true
            Layout.fillHeight: true

            ColumnLayout {
                id: innerskillscolumn
                anchors.fill: parent

                PlasmaComponents.Label {
                    id: innerskllname
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap;
                    font.bold: true;
                    text: i18n(Skill)
                }

                PlasmaComponents.Label {
                    id: cmd0label
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap;
                    width: root.width;
                    text: i18n('<b>Command:</b> ' + CommandList.get(0).Commands)

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            cmd0label.color = theme.linkColor
                            cmd0label.font.underline = true
                            cmd0label.font.bold = true
                        }
                        onExited: {
                            cmd0label.color = theme.textColor
                            cmd0label.font.underline = false
                            cmd0label.font.bold = false
                        }
                        onClicked: {
                            var genExampleQuery = CommandList.get(0).Commands
                            var exampleQuery = genExampleQuery.toString().split(",")
                            var socketmessage = {};
                            socketmessage.type = "recognizer_loop:utterance";
                            socketmessage.data = {};
                            socketmessage.data.utterances = [exampleQuery[1].toLowerCase()];
                            socket.onSendMessagesendTextMessage(JSON.stringify(socketmessage));
                            tabBar.currentTab = mycroftTab
                            qinput.text = "";
                        }
                    }
                }

                PlasmaComponents.Label {
                    id: cmd1label
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap;
                    width: root.width;
                    text: i18n('<b>Command:</b> ' + CommandList.get(1).Commands)

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: {
                            cmd1label.color = theme.linkColor
                            cmd1label.font.underline = true
                            cmd1label.font.bold = true
                        }
                        onExited: {
                            cmd1label.color = theme.textColor
                            cmd1label.font.underline = false
                            cmd1label.font.bold = false
                        }
                        onClicked: {
                            tabBar.currentTab = mycroftTab
                            var genExampleQuery = CommandList.get(1).Commands
                            var exampleQuery = genExampleQuery.toString().split(",")
                            var socketmessage = {};
                            socketmessage.type = "recognizer_loop:utterance";
                            socketmessage.data = {};
                            socketmessage.data.utterances = [exampleQuery[1].toLowerCase()];
                            socket.onSendMessagesendTextMessage(JSON.stringify(socketmessage));
                            tabBar.currentTab = mycroftTab
                            qinput.text = "";
                        }
                    }
                }
            }
        }
    }
}


