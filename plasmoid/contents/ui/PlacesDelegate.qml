import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
        id: nearbyDelegateItm
        height: units.gridUnit * 5
        color: theme.backgroundColor
        anchors.left: parent.left
        anchors.right: parent.right
        width: placesmodelview.view.width
        
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

        ColumnLayout {
            id: contentdlgtitem
            anchors.fill: parent

            RowLayout {
            id: skillTopRowLayout
            spacing: 5
            anchors.fill: parent

            PlasmaComponents.Label {
                wrapMode: Text.WordWrap;
                width: parent.width;
                text: placedistance + " <i>mtrs</i>"
                anchors.top: parent.top
                anchors.right: parent.right
            }

            PlasmaComponents.Label {
                id: plcname
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap;
                font.bold: true;
                text: qsTr(placetitle.replace(/["']/g, ""))
                }
                
            Rectangle {
                    height: 1
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: plcname.bottom
                        topMargin: units.gridUnit * 0.2
                       }
                    color: theme.linkColor
                   }

            Item {
            id: plcinner
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.top: plcname.bottom
            anchors.topMargin: units.gridUnit * 0.6
            anchors.bottom: tagsplccs.top

            PlasmaComponents.Label {
                wrapMode: Text.WordWrap;
                width: parent.width;
                text: "<i>Location:</i> " + placeloc.replace(/["']/g, "")
               }

              Image {
                    id: navbbtn
                    anchors.right: parent.right
                    anchors.margins: units.gridUnit * 0.5
                    source: "../images/up.png"
                    width: 36
                    height: 36

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

            PlasmaComponents.Label {
                id: tagsplccs
                anchors.top: plcinner.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap;
                width: parent.width;
                height: units.gridUnit * 2
                text: placetags
               }
                    }
                        }
                            }
 
