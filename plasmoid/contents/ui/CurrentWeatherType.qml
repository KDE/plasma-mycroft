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
    
    property var scttemp: metacontent.currentIntent.currenttemp
    property var slttemp: metacontent.currentIntent.mintemp
    property var shttemp: metacontent.currentIntent.maxtemp
    property var ssum: metacontent.currentIntent.sum
    property var sloc: metacontent.currentIntent.loc
    property var sicon: metacontent.currentIntent.icon

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
            if(metacontent.currentIntent.sum.indexOf("scattered") !== -1 && metacontent.currentIntent.sum.indexOf("clouds") !== -1 || metacontent.currentIntent.sum.indexOf("clear") !== -1 || metacontent.currentIntent.sum.indexOf("clouds") !== -1 ){
                weathbgImg.source = "../images/climatesc.jpg"
            }
            else if(metacontent.currentIntent.sum.indexOf("rain") !== -1){
                weathbgImg.source = "../images/rain.gif"
            } 
            else if(metacontent.currentIntent.sum.indexOf("snow") !== -1){
                weathbgImg.source = "../images/snow.gif"
            }
            else if(metacontent.currentIntent.sum.indexOf("snow") !== -1){
                weathbgImg.source = "../images/snow.gif"
            }
            else if(metacontent.currentIntent.sum.indexOf("haze") !== -1){
                weathbgImg.source = "../images/haze.gif"
            }
            else {
                weathbgImg.source = ""
            }
        }

            Item {
                id: messageRect
                width: cbwidth
                height: weatherinfoBar.height + rectanglectt.height + units.gridUnit * 1
            
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
                    id: weatherLocation
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font.capitalization: Font.SmallCaps
                    font.italic: false
                    font.bold: true
                    font.pixelSize: 15
                    
                    Component.onCompleted: {
                        weatherLocation.text = sloc
                    }
                }
                
                Row {
                    id: sumRow
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    height: parent.height
                    spacing: 2
                
                Image {
                    id: weatherIcon
                    width: units.gridUnit * 1.25
                    height: units.gridUnit * 1.25
                    anchors.verticalCenter: parent.verticalCenter                    
                    Component.onCompleted: {
                        weatherIcon.source =  "http://openweathermap.org/img/w/" + sicon + ".png"
                        }
                    }
                
                PlasmaCore.SvgItem {
                    id: weatherheaderSeprtr
                    anchors.verticalCenter: parent.verticalCenter
                    height: units.gridUnit * 1
                    width: whvertseptSvg.elementSize("vertical-line").width
                    z: 110
                    elementId: "vertical-line"

                    svg: PlasmaCore.Svg {
                        id: whvertseptSvg;
                        imagePath: "widgets/line"
                    }
                }
                
                PlasmaComponents.Label {
                    id: weatherSummary
                    font.italic: true
                    font.bold: true
                    font.capitalization: Font.SmallCaps
                    font.pixelSize: 15
                    
                    Component.onCompleted: {
                        weatherSummary.text = ssum
                        }
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
            anchors.left: parent.left
            anchors.right: parent.right
            height: weatherMinLabel.height + nwsseprator2.height + weatherCurrentLabel.height + nwsseprator3.height + weatherMaxLabel.height + units.gridUnit * 0.50
            color: theme.backgroundColor
            anchors.top: weatherinfoBar.bottom
            anchors.topMargin: 5

            Text {
                id: weatherMinLabel
                anchors.top: parent.top
                anchors.topMargin: 1
                anchors.left: parent.left
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                wrapMode: Text.WordWrap;
                font.bold: true;
                
                Component.onCompleted: {
                    weatherMinLabel.text = i18n("Minimum Temperature: %1", slttemp)
                    }
                }
                
            Rectangle {
                id: nwsseprator2
                width: parent.width
                anchors.top: weatherMinLabel.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }
            
            Text {
                id: weatherCurrentLabel
                anchors.top: nwsseprator2.bottom
                anchors.topMargin: 1
                anchors.left: parent.left
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                wrapMode: Text.WordWrap;
                font.bold: true;
                
                Component.onCompleted: {
                    weatherCurrentLabel.text = i18n("Current Temperature: %1", scttemp)
                }
            }
            
            Rectangle {
                id: nwsseprator3
                width: parent.width
                anchors.top: weatherCurrentLabel.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }

            Text {
                id: weatherMaxLabel
                anchors.top: nwsseprator3.bottom
                anchors.topMargin: 1
                anchors.left: parent.left
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                wrapMode: Text.WordWrap;
                font.bold: true;
                
                Component.onCompleted: {
                    weatherMaxLabel.text = i18n("Maximum Temperature: %1", shttemp)
                            }
                        }
                    }
                }
            }
        }
    }
}
