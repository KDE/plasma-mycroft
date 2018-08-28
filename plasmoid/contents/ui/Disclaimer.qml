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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
anchors.fill: parent

Rectangle{
id: disclaimerHeadingBg
color: theme.linkColor
anchors.left: parent.left
anchors.top: parent.top
anchors.right: parent.right
height: units.gridUnit * 3

    Text {
        id: disclaimerHeading1
        height: 28
        text: i18n("Let's Continue?")
        font.pointSize: 24
        elide: Text.ElideLeft
        font.family: "Verdana"
        wrapMode: Text.WrapAnywhere
        font.bold: true
        renderType: Text.QtRendering
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: units.gridUnit * 0.5
        color: theme.backgroundColor
     }
}


     Text {
        id: disclaimerBody1
        height: contentHeight
        text: i18n("Mycroft by default is powered by a cloud-based speech to text service. Mycroft gives you the ability to change speech to text services or use a locally configured one within their settings at home.mycroft.ai. If you agree to the default usage of Mycroft’s speech to text service, please continue. Also remember you can always choose to turn off or mute Mycroft when you do not wish to use it.")
        font.pointSize: 10
        font.family: "Verdana"
        wrapMode: Text.Wrap
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        anchors.top: disclaimerHeadingBg.bottom
        anchors.topMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        color: theme.textColor
     }

     Item {
     id: noticemsg
     anchors.top: disclaimerBody1.bottom
     anchors.topMargin: 20
     anchors.right: parent.right
     anchors.left: parent.left
     height: disclaimerBody2.contentHeight
     
     Text {
        id: disclaimerBody2
        height: contentHeight
        text: i18n("To start using Mycroft toggle the switch in the upper right corner!")
        font.italic: true
        font.pointSize: 10
        font.family: "Verdana"
        wrapMode: Text.WrapAnywhere
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        color: theme.textColor
        }
    }
}
