
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
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item{
    id: customIndicatorBusy
    anchors.centerIn: parent
    property alias cstanim: customIndicatorBusy
    property bool running: false
    visible: false

    Item {
            implicitWidth: units.gridUnit * 3
            implicitHeight: units.gridUnit * 3
            
            Rectangle {
                 id: antiinnerCircleOutVert
                 anchors.centerIn: parent
                 color: "skyblue"
                 radius: 8
                 implicitWidth: units.gridUnit * 1.2
                 implicitHeight: units.gridUnit * 1.2                
            }

            Rectangle {
                 id: innerCircleOutHoriz
                 anchors.centerIn: parent
                 color: "steelblue"
                 radius: 5
                 implicitWidth: units.gridUnit * 2.2
                 implicitHeight: units.gridUnit * 1.2
                }
                  
            Rectangle {
                 id: innerCircleOutVert
                 anchors.centerIn: parent
                 color: "steelblue"
                 radius: 5
                 implicitWidth: units.gridUnit * 1.2
                 implicitHeight: units.gridUnit * 2.2
                }
                
            Rectangle {
                 id: innerCircleIn
                 anchors.centerIn: parent
                 color: "lightblue"
                 border.color: "steelblue"
                 border.width: units.gridUnit * 0.2
                 radius: 100
                 implicitWidth: units.gridUnit * 1.7
                 implicitHeight: units.gridUnit * 1.7

                 Image {
                     id: innerPulser
                     source: "../images/midanim.png"
                     anchors.centerIn: parent
                     height: units.gridUnit * 3.0
                     width: units.gridUnit * 3.0
                 }
                 
                 ColorOverlay {
                     anchors.fill: innerPulser
                     source: innerPulser
                     color: "steelblue"
                  }
                }

            RotationAnimator {
                   target: innerCircleOutHoriz
                   running: customIndicatorBusy.running
                   from: 0
                   to: 360
                   loops: Animation.Infinite
                   duration: 6000
            }
            
            ScaleAnimator {
                target: innerCircleOutHoriz
                running: customIndicatorBusy.running
                from: 1.1
                to: 0.5
                duration: 1200
                loops: Animation.Infinite
            }

            RotationAnimator {
                   target: innerCircleOutVert
                   running: customIndicatorBusy.running
                   from: 0
                   to: 360
                   loops: Animation.Infinite
                   duration: 6000
            }
            
            RotationAnimator {
                   target: antiinnerCircleOutVert
                   running: customIndicatorBusy.running
                   from: 360
                   to: 0
                   loops: Animation.Infinite
                   duration: 6000
                }
        
            ScaleAnimator {
                target: innerCircleOutVert
                running: customIndicatorBusy.running
                from: 1.1
                to: 0.5
                duration: 1200
                loops: Animation.Infinite
            }
            
            ScaleAnimator {
                target: antiinnerCircleOutVert
                running: customIndicatorBusy.running
                from: 0.5
                to: 1.3
                duration: 1200
                loops: Animation.Infinite
            }

            ScaleAnimator {
                target: innerCircleIn
                running: customIndicatorBusy.running
                from: 1
                to: 0.7
                duration: 1200
                loops: Animation.Infinite
            }
          }
        }
