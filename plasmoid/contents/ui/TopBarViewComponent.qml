/* Copyright 2019 Aditya Mehra <aix.m@outlook.com>                            

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
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kirigami 2.5 as Kirigami
import QtGraphicalEffects 1.0
import Mycroft 1.0 as Mycroft

Item {
    id: topBarBGrect
    property alias talkAnimation: midbarAnim
    property alias micIcon: qinputmicbx.iconSource
    
    Connections {
        target: Mycroft.MycroftController
        onSpeakingChanged: {
            if (Mycroft.MycroftController.speaking){
                midbarAnim.startTalking()
            }
            else {
                midbarAnim.stopTalking()
            }
        }
        onListeningChanged: {
            if (Mycroft.MycroftController.listening){
                midbarAnim.startTalking()
            }
            else {
                midbarAnim.stopTalking()
            }
        }
    }

    RowLayout {
        anchors.fill: parent

        Image {
            id: logoImageArea
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: Kirigami.Units.gridUnit * 1.4
            Layout.preferredHeight: Kirigami.Units.gridUnit * 1.5
            source: "../images/mycroftsmaller.png"
        }
        
        PlasmaComponents.Label {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: Kirigami.Units.smallSpacing
            font.capitalization: Font.SmallCaps
            id: logoTextArea
            text: i18n("Mycroft")
            font.bold: false;
            color: theme.textColor
        }

        PlasmaCore.SvgItem {
            id: topbarLeftDividerline
            Layout.fillHeight: true
            Layout.preferredWidth: linetopleftvertSvg.elementSize("vertical-line").width
            elementId: "vertical-line"

            svg: PlasmaCore.Svg {
                id: linetopleftvertSvg;
                imagePath: "widgets/line"
            }
        }
        
        TopBarAnim {
            id: midbarAnim
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit * 2 - Kirigami.Units.largeSpacing * 2
            Layout.topMargin: Kirigami.Units.largeSpacing + Kirigami.Units.smallSpacing
            
            PlasmaComponents.Label {
                anchors.centerIn: parent
                opacity: Mycroft.MycroftController.status != Mycroft.MycroftController.Open
                text: i18n("Disconnected") 
                wrapMode: Text.WordWrap
            }
        }

        PlasmaCore.SvgItem {
            id: topbarDividerline
            Layout.fillHeight: true
            Layout.preferredWidth: linetopvertSvg.elementSize("vertical-line").width
            elementId: "vertical-line"

            svg: PlasmaCore.Svg {
                id: linetopvertSvg;
                imagePath: "widgets/line"
            }
        }

        PlasmaComponents.ToolButton {
            id: startBtn
            Layout.alignment: Qt.AlignRight
            iconSource: Mycroft.MycroftController.status != Mycroft.MycroftController.Open ? "draw-triangle2" : "media-playback-pause"
            tooltip: i18n("Connect")
            flat: true
            Layout.preferredWidth: Math.round(Kirigami.Units.gridUnit * 2)
            height: Layout.preferredWidth
            onClicked: {
                if(Mycroft.MycroftController.status != Mycroft.MycroftController.Open) {
                Mycroft.MycroftController.start();
                } else {
                 Mycroft.MycroftController.disconnectSocket();   
                }
            }
        }
        
        
        PlasmaComponents.ToolButton {
            id: qinputmicbx
            Layout.alignment: Qt.AlignRight
            iconSource: "mic-on"
            tooltip: i18n("Toggle Mic")
            flat: true
            Layout.preferredWidth: Math.round(Kirigami.Units.gridUnit * 2)
            height: Layout.preferredWidth
        }

        PlasmaComponents.ToolButton {
            id: pinButton
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: Math.round(Kirigami.Units.gridUnit * 1.5)
            height: Layout.preferredWidth
            checkable: true
            iconSource: "window-pin"
            onCheckedChanged: plasmoid.hideOnWindowDeactivate = !checked
        }
    }
}
