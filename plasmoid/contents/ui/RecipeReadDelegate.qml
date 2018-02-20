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
        id: recipeListDelegateItm
        height: units.gridUnit * 1
        color: Qt.darker(theme.backgroundColor, 1.2)
        anchors.left: parent.left
        anchors.right: parent.right

     Row {
         id: recipeListColumn
         spacing: 4
         
        Item {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: units.gridUnit * 2
            
            PlasmaCore.IconItem {
                id: recipeReadDrwHeaderSpeakIcon  
                source: "kr_jumpback"
                width: units.gridUnit * 0.75
                height: units.gridUnit * 0.75
                anchors.centerIn: parent
                } 
            }

        Rectangle {
          width: 1
          height: parent.height
          color: theme.linkColor
        }
        
        Label {
          id: recipeListDelegateItmLabel
          color: theme.textColor
          text: ingredients
          anchors.verticalCenter: parent.verticalCenter
        }
    }
}
