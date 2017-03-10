import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQml.Models 2.2
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0


Column {
    spacing: 6
    //anchors.right: parent.right
    //anchors.left: parent.left

    //readonly property bool sentByMe: model.recipient !== "Me"
    //property alias cttemp: currenttempitem.text
    property alias lttemp: lowtempitem.text
    property alias httemp: hightempitem.text

    Row {
        id: messageRow
        spacing: 6

        Rectangle{
            id: messageWrapper
            width: cbwidth
            height: messageRect.height
            color: theme.backgroundColor

            Rectangle {
                id: messageRect
                width: cbwidth / 1.1
                height: 100
                //anchors.right: avatar.right
                color: theme.backgroundColor


                Rectangle {
                    id: rectangleltt
                    width: 100
                    height: 60
                    color: "#00000000"
                    anchors.top: todayweather.bottom
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    
                    PlasmaComponents.Label {
                        id: lowtemplable
                        anchors.left: parent.left
                        anchors.verticalCenter: lowtempaniimage.verticalCenter
                        text: "Low"
//                        font.family: "Courier"
                        font.pointSize: 12
                        font.bold: true
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.leftMargin: 30
                    }

                    PlasmaComponents.Label {
                        id: lowtempitem
                        x: 63
                        y: 33
                        anchors.top: lowtemplable.bottom
                        text: "100"
                        anchors.horizontalCenter: lowtemplable.horizontalCenter
                        anchors.topMargin: 10
                    }

                    PlasmaComponents.Label {
                        id: weatherwidgetlowtempdegree
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: lowtempitem.verticalCenter
                        anchors.left: lowtempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                    }


                }

                Rectangle {
                    id: rectanglehtt
                    width: 100
                    height: 60
                    color: "#00000000"
                    anchors.top: todayweather.bottom
                    anchors.topMargin: 5
                    anchors.left: rectangleltt.right
                    anchors.leftMargin: 0

                    PlasmaComponents.Label {
                        id: hightempitem
                        x: 65
                        y: 70
                        anchors.top: hightemplable.bottom
                        text: "100"
                        anchors.topMargin: 10
                        anchors.horizontalCenter: hightemplable.horizontalCenter
                    }

                    PlasmaComponents.Label {
                        id: hightemplable
                        anchors.left: parent.left
                        text: "High"
                        font.pointSize: 12
                        font.bold: true
                   //     font.family: "Courier"
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        anchors.verticalCenter: hightempaniimage.verticalCenter
                        anchors.leftMargin: 30
                    }

                    PlasmaComponents.Label {
                        id: weatherwidgethightempdegree
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: hightempitem.verticalCenter
                        anchors.left: hightempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                    }


                }

                PlasmaComponents.Label {
                    id: todayweather
                    text: qsTr("Tomorrow's Weather")
                    anchors.left: parent.left
                    anchors.leftMargin: 9
                 //   font.family: "Courier"
                    font.italic: false
                    font.bold: true
                    font.pixelSize: 17
                }



            }
        }

    }
}
