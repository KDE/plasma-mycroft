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
import QtGraphicalEffects 1.0

Item {
 id: pulleyFrame
 anchors.fill: parent
 property bool opened: state === "PulleyExpanded"
 property bool closed: state === "PulleyClosed"
 property bool _isVisible
 property var barColor
 signal pulleyExpanded()
 signal pulleyClosed()

 function open() {
     pulleyFrame.state = "PulleyExpanded";
     pulleyExpanded();
 }

 function close() {
     pulleyFrame.state = "PulleyClosed";
     pulleyClosed();
 }

 states: [
     State {
         name: "PulleyExpanded"
         PropertyChanges { target: pulleyMenu; height: cbheight / 6 - pulleyIconBar.height; }
         PropertyChanges { target: pulleydashMenu; visible: true; }
         PropertyChanges { target: menudrawIcon; source: "go-down";}
     },
     State {
         name: "PulleyClosed"
         PropertyChanges { target: pulleyMenu; height: 0; }
         PropertyChanges { target: pulleydashMenu; visible: false; }
         PropertyChanges { target: menudrawIcon; source: "go-up";}
     }
    ]


 transitions: [
     Transition {
         to: "*"
         NumberAnimation { target: pulleyMenu; properties: "height"; duration: 450; easing.type: Easing.OutCubic; }
     }
    ]

    Rectangle {
      id: pulleyIconBar
      anchors.bottom: pulleyMenu.top
      anchors.bottomMargin: 0
      height: units.gridUnit * 0.40
      color: barColor
      width: cbwidth
        PlasmaCore.IconItem {
                id: menudrawIcon
                visible: _isVisible
                anchors.centerIn: parent
                source: "go-up"
                width: units.gridUnit * 1.25
                height: units.gridUnit * 1.25
            }

        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: {
                if (pulleyFrame.opened) {
                    pulleyFrame.close();
                } else {
                    pulleyFrame.open();
                }
            }
        }
    }

    Rectangle {
        id: pulleyMenu
        width: parent.width
        color: PlasmaCore.ColorScope.backgroundColor
        anchors.bottom: parent.bottom
        height: 0
        
        Item {
            id: pulleydashMenu
            anchors.fill: parent
            visible: false
            
             PlasmaComponents.Button {
                    id: refreshDashBtn
                    anchors.left: parent.left
                    anchors.top: parent.top
                    width: parent.width / 2
                    height: parent.height
                    text: i18n("Refresh Dashboard")
                    
                    onClicked: {
                        convoLmodel.clear()
                        showDash("setVisible")
                    }
             }
             PlasmaComponents.Button {
                    id: settingsDashBtn
                    anchors.left: refreshDashBtn.right
                    anchors.top: parent.top
                    width: parent.width / 2
                    height: parent.height   
                    text: i18n("Change Settings")
                    
                    onClicked: {
                        tabBar.currentTab = mycroftSettingsTab
                        settingstabBar.currentTab = dashSettingsTab
                    }
           }
        }
        
         Item {
                id: pulleyEndArea
                anchors.bottom: parent.bottom
                anchors.bottomMargin: units.gridUnit * 1.22
                width: parent.width
                height: units.gridUnit * 2.5
            }
        }
    }
