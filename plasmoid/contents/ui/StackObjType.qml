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
import QtWebKit 3.0
import QtWebKit.experimental 1.0

Rectangle {
    id: stackObjBg
    height: cbheight
    width: cbwidth
    color: theme.backgroundColor

Rectangle {
    id: powerdByBg
    height: units.gridUnit * 1.25
    width: parent.width
    color: theme.linkColor
    anchors.top: parent.top
    
    Text {
        id: poweredByLbl
        width: parent.width
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: units.gridUnit * 0.25
        text: "Powered By StackOverflow"
        font.capitalization: Font.SmallCaps
        color: theme.textColor
    }
}
        
ListView {
     id: stackObjModelview
     anchors.left: parent.left
     anchors.right: parent.right
     anchors.top: powerdByBg.bottom
     anchors.topMargin: units.gridUnit * 0.25
     anchors.bottom: parent.bottom
     model: stackLmodel
     spacing: 4
     focus: false
     interactive: true
     clip: true;
     delegate: StackObjDelegate{}
     ScrollBar.vertical: ScrollBar {
        active: true
        policy: ScrollBar.AlwaysOn
        snapMode : ScrollBar.SnapAlways
      }
    }
}
 
