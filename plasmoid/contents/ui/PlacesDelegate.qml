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
                         Qt.openUrlExternally("https://www.google.co.in/maps/place/" + placetitle + "/@" + navpos[0] + "," + navpos[1] + ",17z");
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
 
