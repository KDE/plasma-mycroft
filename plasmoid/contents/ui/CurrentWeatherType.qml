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
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQml.Models 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Column {
    spacing: 6
    
    property var scttemp: metacontent.currenttemp
    property var slttemp: metacontent.mintemp
    property var shttemp: metacontent.maxtemp
    property var ssum: metacontent.sum
    property var sloc: metacontent.loc

    Row {
        id: messageRow
        spacing: 6

        Rectangle{
            id: messageWrapper
            width: cbwidth
            height: weathbgImg.height
            color: theme.backgroundColor
            
            Image{
            id: weathbgImg
            width: cbwidth
            height: messageRect.height
            
            Component.onCompleted: {
            if(metacontent.sum.indexOf("scattered") !== -1 && metacontent.sum.indexOf("clouds") !== -1 || metacontent.sum.indexOf("clear") !== -1 || metacontent.sum.indexOf("clouds") !== -1 ){
                weathbgImg.source = "../images/climatesc.jpg"
            }
            else if(metacontent.sum.indexOf("rain") !== -1){
                weathbgImg.source = "../images/rain.gif"
            } 
            else if(metacontent.sum.indexOf("snow") !== -1){
                weathbgImg.source = "../images/snow.gif"
            }
            else if(metacontent.sum.indexOf("snow") !== -1){
                weathbgImg.source = "../images/snow.gif"
            }
            else if(metacontent.sum.indexOf("haze") !== -1){
                weathbgImg.source = "../images/haze.gif"
            }
            else {
                weathbgImg.source = ""
            }
        }

            Rectangle {
                id: messageRect
                width: cbwidth
                height: 150
                color: "#00000000"
            
             Rectangle {
                id: weatherinfoBar
                width: messageRect
                color: theme.backgroundColor
                height: units.gridUnit * 2
                anchors.top: parent.top
                anchors.topMargin: units.gridUnit * 0.5
                anchors.left: parent.left
                anchors.right: parent.right
            
                PlasmaComponents.Label {
                    id: todayweather
                    //text: qsTr(metacontent.loc)
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    //font.family: "Courier"
                    font.italic: false
                    font.bold: true
                    font.pixelSize: 15
                    
                    Component.onCompleted: {
                        todayweather.text = sloc
                    }
                }
                
                PlasmaComponents.Label {
                    id: weathersum
                    //text: qsTr(metacontent.sum)
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    font.italic: true
                    font.bold: true
                    font.pixelSize: 10
                    
                    Component.onCompleted: {
                        weathersum.text = ssum
                    }
                }
            }
                
                PlasmaCore.SvgItem {
        anchors {
            left: messageRect.left
            right: messageRect.right
            top: rectanglectt.top
        }
        width: 1
        height: horlinewthrtopSvg.elementSize("horizontal-line").height

        elementId: "horizontal-line"
        z: 110
        svg: PlasmaCore.Svg {
            id: horlinewthrtopSvg;
            imagePath: "widgets/line"
            }
        }  
                
                Rectangle {
                    id: rectanglectt
                    width: 125
                    anchors.left: parent.left
                    height: 75
                    color: theme.backgroundColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5

                    PlasmaComponents.Label {
                        id: currenttemplable
                        text: "Current"
                        font.pointSize: 12
                        //font.family: "Courier"
                        font.bold: true
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        //anchors.verticalCenter: currenttempaniimage.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                    }

                    PlasmaComponents.Label {
                        id: currenttempitem
                        x: 73
                        y: 38
                        //text: metacontent.currenttemp
                        anchors.horizontalCenter: currenttemplable.horizontalCenter
                        anchors.top: currenttemplable.bottom
                        anchors.topMargin: 10
                        
                    Component.onCompleted: {
                       currenttempitem.text = scttemp
                    }
                    }

                    PlasmaComponents.Label {
                        id: weatherwidgetcurrenttempdegrees
                        text: qsTr("°")
                        anchors.verticalCenterOffset: -5
                        anchors.verticalCenter: currenttempitem.verticalCenter
                        anchors.left: currenttempitem.right
                        anchors.leftMargin: 5
                        font.pixelSize: 12
                    }


                }
                
            PlasmaCore.SvgItem {
                    anchors {
                        right: rectanglectt.right
                        rightMargin: units.gridUnit * 0.25
                        top: rectanglectt.top
                        topMargin: 5
                        bottom: rectanglectt.bottom
                        bottomMargin: 0
                    }

                    width: linecttSvg.elementSize("vertical-line").width
                    z: 110
                    elementId: "vertical-line"

                    svg: PlasmaCore.Svg {
                        id: linecttSvg;
                        imagePath: "widgets/line"
                    }
                }

                Rectangle {
                    id: rectangleltt
                    //width: 100
                    height: 75
                    color: theme.backgroundColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5
                    anchors.left: rectanglectt.right
                    anchors.right: rectanglehtt.left
                    anchors.leftMargin: 0

                    PlasmaComponents.Label {
                        id: lowtemplable
                        anchors.left: parent.left
                        //anchors.verticalCenter: lowtempaniimage.verticalCenter
                        text: "Low"
                        //font.family: "Courier"
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
                        //text: metacontent.mintemp
                        anchors.horizontalCenter: lowtemplable.horizontalCenter
                        anchors.topMargin: 10
                        
                    Component.onCompleted: {
                       lowtempitem.text = slttemp
                    }
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
                
                PlasmaCore.SvgItem {
                    anchors {
                        right: rectangleltt.right
                        rightMargin: units.gridUnit * 0.25
                        top: rectangleltt.top
                        topMargin: 5
                        bottom: rectanglectt.bottom
                        bottomMargin: 0
                    }

                    width: linelttSvg.elementSize("vertical-line").width
                    z: 110
                    elementId: "vertical-line"

                    svg: PlasmaCore.Svg {
                        id: linelttSvg;
                        imagePath: "widgets/line"
                    }
                }

                Rectangle {
                    id: rectanglehtt
                    width: 125
                    height: 75
                    color: theme.backgroundColor
                    anchors.top: weatherinfoBar.bottom
                    anchors.topMargin: 5
                    anchors.right: parent.right
                    anchors.leftMargin: 0

                    PlasmaComponents.Label {
                        id: hightempitem
                        x: 65
                        y: 70
                        anchors.top: hightemplable.bottom
                        //text: metacontent.maxtemp
                        anchors.topMargin: 10
                        anchors.horizontalCenter: hightemplable.horizontalCenter
                    
                    Component.onCompleted: {
                       hightempitem.text = shttemp
                    }
                        
                    }

                    PlasmaComponents.Label {
                        id: hightemplable
                        anchors.left: parent.left
                        text: "High"
                        font.pointSize: 12
                        font.bold: true
                        //font.family: "Courier"
                        anchors.top: parent.top
                        anchors.topMargin: 8
                        //anchors.verticalCenter: hightempaniimage.verticalCenter
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
                
                PlasmaCore.SvgItem {
                anchors {
                    left: messageRect.left
                    right: messageRect.right
                    top: rectanglectt.bottom
                    topMargin: 2
                }
                width: 1
                height: horlinewthrbotSvg.elementSize("horizontal-line").height

                elementId: "horizontal-line"
                z: 110
                svg: PlasmaCore.Svg {
                id: horlinewthrbotSvg;
                imagePath: "widgets/line"
                }
            }  
                
                }
            }
        }
    }
}
