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
import QtGraphicalEffects 1.0

Rectangle {
        id: nearbyDelegateItm
        height: units.gridUnit * 6
        anchors.left: parent.left
        anchors.right: parent.right
        width: cbwidth
        border.color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2)
        color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2) 
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 10
            samples: 32
            spread: 0.1
            color: Qt.rgba(0, 0, 0, 0.3)
        }
        
        function getRouteInformation(llat, llong, dlat, dlong, oappid, oappcode){
            var routedoc = new XMLHttpRequest()
            var url = "https://route.cit.api.here.com/routing/7.2/calculateroute.json?waypoint0=" + llat + "," + llong + "&waypoint1=" + dlat + "," + dlong + "&mode=fastest;car;&app_id=" + oappid + "&app_code=" + oappcode + "&depature=now"
            routedoc.open("GET", url, true);
            routedoc.send()

            routedoc.onreadystatechange = function() {
                 if (routedoc.readyState === XMLHttpRequest.DONE && routedoc.responseText !== "undefined") {
                     var reqroute = routedoc.responseText
                     if (reqroute !== "undefined") {
                            var filterRouteDict = JSON.parse(reqroute)
                            for (var i = 0; i<filterRouteDict.response.route[0].leg[0].maneuver.length; i++){
                            var getRouteDict = filterRouteDict.response.route[0].leg[0].maneuver[i].instruction
                            console.log(JSON.stringify(getRouteDict))
                            routeLmodel.append({navInstruction: getRouteDict});
                          }
                       }
                    }
                }
            }

        Item {
            id: contentdlgtitem
            anchors.fill: parent

            Item {
            id: skillTopRowLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right 
            height: plcname.height + units.gridUnit * 0.25

            PlasmaComponents.Label {
                id: plcname
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.15
                wrapMode: Text.WordWrap;
                font.bold: true;
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                text: qsTr(placetitle.replace(/["']/g, ""))
                }
            
            PlasmaComponents.Label {
                id: plcdistance
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.15
                wrapMode: Text.WordWrap;
                font.bold: true;
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                text: "Distance: " + placedistance + " <i>mtrs</i>"
                }
            }
                
            Rectangle {
                id: placesCrdSeptHeader
                    height: 1
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: skillTopRowLayout.bottom
                        topMargin: units.gridUnit * 0.2
                       }
                    color: theme.linkColor
            }

            Item {
                id: plcinner
                anchors.top: placesCrdSeptHeader.bottom
                anchors.topMargin: units.gridUnit * 0.15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

            Item {
                id: plcinnerdetails
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: navbbtn.height
                
                Image {
                    id: placeIconType
                    anchors.left: parent.left
                    anchors.leftMargin: units.gridUnit * 0.05
                    anchors.verticalCenter: parent.verticalCenter
                    source: placeicon.replace(/["']/g, "")
                    width: units.gridUnit * 2
                    height: units.gridUnit * 2
                }

                PlasmaComponents.Label {
                    id: placeAddressLabel
                    anchors.left: placeIconType.right
                    anchors.leftMargin: units.gridUnit * 0.05
                    wrapMode: Text.WordWrap;
                    font.bold: true;
                    font.pointSize: theme.defaultFont.pointSize
                    font.letterSpacing: theme.defaultFont.letterSpacing
                    font.wordSpacing: theme.defaultFont.wordSpacing
                    font.family: theme.defaultFont.family
                    renderType: Text.NativeRendering 
                    text: "Address: " + placeloc.replace(/["']/g, "")
                }

                Image {
                    id: navbbtn
                    anchors.right: parent.right
                    anchors.margins: units.gridUnit * 0.5
                    source: "../images/up.png"
                    width: units.gridUnit * 2
                    height: units.gridUnit * 2

                    MouseArea {
                       anchors.fill: parent

                       onClicked: {
                         var navpos = placeposition.replace(/[[\]]/g,'').split(",");
                         getRouteInformation(placelocallat, placelocallong, navpos[0], navpos[1], placeappid, placeappcode)
                         var formatedurl =   "https://image.maps.cit.api.here.com/mia/1.6/mapview?c=" + placelocallat + "," + placelocallong + "&z=16&poi=" + navpos[0] + "," + navpos[1] + "&poithm=0&app_id=" + placeappid + "&app_code=" + placeappcode + "&h=" + cbheight / 2 + "&w=" + cbwidth + "&ppi=500ppi=120&t=7&f=2&i=true"
                         navMapDrawer.open()
                         navMapDrawer.getURL = formatedurl
                       }
                    }
                }
            }

            Rectangle {
                id: placesCrdSeptFooter
                    height: apiCreds.height
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                       }
                    color: theme.linkColor

                PlasmaComponents.Label {
                    id: tagsplccs
                    anchors.left: parent.left
                    anchors.leftMargin: units.gridUnit * 0.15
                    anchors.right: apiCreds.left
                    anchors.verticalCenter: parent.verticalCenter
                    wrapMode: Text.WordWrap;
                    font.pointSize: theme.defaultFont.pointSize - 2
                    text: placetags
                    }
                
                PlasmaComponents.Label {
                    id: apiCreds
                    anchors.right: parent.right
                    anchors.rightMargin: units.gridUnit * 0.15
                    anchors.verticalCenter: parent.verticalCenter
                    wrapMode: Text.WordWrap;
                    font.bold: true
                    font.pointSize: theme.defaultFont.pointSize - 2
                    text: i18n("<i>Powered By: Here.API</i>")
                    }
                }
            }             
        }
    }
 
