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
    id: partclc
    height: cbheight
    width: cbwidth
    color: theme.backgroundColor
    property alias routeLmodel: routeListModel
    
    Component.onCompleted: {
        console.log(cbheight)
    }
    
ListModel {
        id: routeListModel
}

ListView {
     id: placesmodelview
     anchors.fill: parent
     model: plcLmodel
     spacing: 4
     focus: false
     interactive: true
     clip: true;
     delegate: PlacesDelegate{}
     ScrollBar.vertical: ScrollBar {
        active: true
        policy: ScrollBar.AlwaysOn
        snapMode : ScrollBar.SnapAlways
      }
    }

Drawer {
    id: navMapDrawer
    width: parent.width
    height: cbdrawercontentheight
    edge: Qt.RightEdge
    dragMargin: 0
    property alias getURL: navMapView.url

    Rectangle {
            id: navParentRect
            width: parent.width
            height: parent.height
            color: Qt.lighter(theme.backgroundColor, 1.2)

        WebView {
            id: navMapView
            width: parent.width
            height: parent.height / 2
            experimental.useDefaultContentItemSize: true
            experimental.userStyleSheets: "../code/maps.css"
            experimental.page.height: navMapView.height
            experimental.page.width: parent.width
            }

        ListView {
            id: navMapDirections
            anchors.top: navMapView.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            model: routeLmodel
            spacing: 2
            focus: false
            interactive: true
            clip: true;
            delegate: NavigationDelegate{}
            ScrollBar.vertical: ScrollBar {
               active: true
               policy: ScrollBar.AlwaysOn
               snapMode : ScrollBar.SnapAlways
           }
         }
      }
   }
}
 
