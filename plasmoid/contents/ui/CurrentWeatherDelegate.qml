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
            width: cbwidthmargin
            height: weathbgImg.height
            color: theme.backgroundColor
            
            Image{
            id: weathbgImg
            width: cbwidthmargin
            height: messageRect.height
            
            Component.onCompleted: {
            if(metacontent.currentIntent.sum.indexOf("scattered") !== -1 && metacontent.currentIntent.sum.indexOf("clouds") !== -1 || metacontent.currentIntent.sum.indexOf("clear") !== -1 || metacontent.currentIntent.sum.indexOf("clouds") !== -1 ){
                weathbgImg.source = "../images/climatesc.jpg"
            }
            else if(metacontent.currentIntent.sum.indexOf("rain") !== -1){
                weathbgImg.source = "../images/rain.gif"
            } 
            else if(metacontent.currentIntent.sum.indexOf("thunderstorm") !== -1){
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
        id: currentWeatherFrame
        anchors.fill: parent

    Rectangle {
        id: currentWeatherFrameBg
        anchors.fill: parent
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

    Coloumn {
        id: currentWeatherMainArea
        spacing: 2
        
        anchors.top: parent.top
        anchors.bottom: currentWeatherExtendedAreaSeptr.top
        Image{
            id: currentWeatherCurrentTempIcon
            
            Component.onCompleted:{
                    var currentWeatherCondition = getCurrentConditionIcon(ssum)
                    currentWeatherMainArea.source = currentWeatherCurrentTempIcon
                }
            }
        }
        Text {
            id: weatherCurrentLabel
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
                weatherCurrentLabel.text = "Current Temperature: " + scttemp
            }
                        }
                    }
                }        
            }
        }
    }
}
