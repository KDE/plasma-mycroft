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
import Qt.WebSockets 1.0
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import QtWebKit 3.0
import QtWebKit.experimental 1.0
import QtGraphicalEffects 1.0

Rectangle {
        id: navMapDelegateItm
        height: units.gridUnit * 5
        width: parent.width
        color: theme.backgroundColor

        function filterDirection(getInfo){
           var keyleft = ["left","east"]
           var keyright = ["right", "west"]
           var keynorth = ["north", "Head"]
           var keyuturn = ["U-Turn", "u-turn"]
           var keyramp = ["ramp", "Ramp"]
           var keyarrive = ["Arrive", "arrive"]
           for (var i=0; i<keyleft.length; i++){
           if (getInfo.indexOf(keyleft[i]) != -1) {
                    navMapDirectionsImg.source = "../images/turnleft.png";
            }
            else if (getInfo.indexOf(keyright[i]) != -1) {
                    navMapDirectionsImg.source = "../images/turnright.png";
            }
            else if (getInfo.indexOf(keynorth[i]) != -1) {
                    navMapDirectionsImg.source = "../images/turnnorth.png";
            }
            else if (getInfo.indexOf(keyuturn[i]) != -1) {
                    navMapDirectionsImg.source = "../images/turnuturn.png";
              }
           else if (getInfo.indexOf(keyramp[i]) != -1) {
                   navMapDirectionsImg.source = "../images/turnramp.png";
             }
           else if (getInfo.indexOf(keyarrive[i]) != -1) {
                   navMapDirectionsImg.source = "../images/destination.png";
             }
           }
        }

     Row {
         id: navMapRow
         spacing: 4

        Image {
            id: navMapDirectionsImg
            width: 0
            height: 64
            visible: false
            anchors.margins: units.gridUnit * 2
        }

        ColorOverlay{
        anchors.top: navMapDirectionsImg.top
        anchors.bottom: navMapDirectionsImg.bottom
        width: 64
        source: navMapDirectionsImg
        color: theme.linkColor
        }

        Rectangle {
          id: vertsepNav
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.topMargin: units.gridUnit * 0.5
          anchors.bottomMargin: units.gridUnit * 0.5
          color: theme.linkColor
          width: 1
        }

        Label {
          id: navMapDelegateItmLabel
          color: theme.textColor
          anchors.verticalCenter: parent.verticalCenter
          text: navInstruction
          Rectangle {
              anchors {
                  left: parent.left
                  right: parent.right
                  bottom: parent.bottom
                  bottomMargin: units.gridUnit * -0.2
                 }
                height: 1
              color: theme.linkColor
             }
          onTextChanged: {
            filterDirection(navInstruction)
          }
        }
     }
}

