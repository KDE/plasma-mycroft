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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
        id: dashDelegateItmWeather
        height: units.gridUnit * 7.75
        width: cbwidth - units.gridUnit * 0.50
        border.width: 1        
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
        property bool expanded: false

        Item {
            id: contentdlgtitem
            width: parent.width
            height: parent.height
            
          Item {
            id: skillTopRowLayout
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: dashHeader.implicitHeight + units.gridUnit * 0.5
            
            Text {
                id: dashHeader
                anchors.left: dashHeaderSeprtr.right
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                wrapMode: Text.Wrap;
                font.bold: true;
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                text: i18n(model.contents.itemWeatherCity + " | " + model.contents.itemWeatherTempTypeHourZero)
            }
            
            Image {
                id: weatherDashCardIcon
                anchors.left: dashHeader.right
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                source: model.contents.itemWeatherIconTypeHourZero
                width: units.gridUnit * 1.25
                height: units.gridUnit * 1.25
            }
            
            Text {
                id: weatherDashCardWind
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 1
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true;
                font.pointSize: theme.defaultFont.pointSize
                font.letterSpacing: theme.defaultFont.letterSpacing
                font.wordSpacing: theme.defaultFont.wordSpacing
                font.family: theme.defaultFont.family
                renderType: Text.NativeRendering 
                color: PlasmaCore.ColorScope.textColor
                text: i18n("Wind | " + model.contents.itemWeatherWindHourZero + " meters/sec")
            }
            
            PlasmaCore.SvgItem {
                id: dashHeaderSeprtr
                anchors {
                    left: contxtnewsitemmenu.right
                    leftMargin: units.gridUnit * 0.25
                    verticalCenter: parent.verticalCenter
                }
                height: units.gridUnit * 1
                width: linetopleftvertSvg.elementSize("vertical-line").width
                z: 110
                elementId: "vertical-line"

                svg: PlasmaCore.Svg {
                    id: dashhdrvertSvg;
                    imagePath: "widgets/line"
                }
            }

            ToolButton {
                id: contxtnewsitemmenu
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                width: units.gridUnit * 1
                height: units.gridUnit * 1
                Image {
                    id: innrnewitemcontxmenuimage
                    source: "../images/ctxmenu.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: units.gridUnit * 0.60
                    height: units.gridUnit * 0.50
                }
                ColorOverlay {
                    anchors.fill: innrnewitemcontxmenuimage
                    source: innrnewitemcontxmenuimage
                    color: theme.textColor
                }
                onClicked: {
                    mcmenuItem.open()
                    }
                }
            }
            
            Rectangle {
                id: nwsseprator
                width: parent.width
                anchors.top: skillTopRowLayout.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }
            
            Text {
                id: weatherDshTempDateLabel
                anchors.top: nwsseprator.bottom
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
                text: i18n("Date: " + model.contents.itemWeatherDateHourZero.split(" ")[0] + " | " + "Time: " + model.contents.itemWeatherDateHourZero.split(" ")[1])
            }
            
            Rectangle {
                id: nwsseprator1
                width: parent.width
                anchors.top: weatherDshTempDateLabel.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }
            
            Text {
                id: weatherDshTempMinLabel
                anchors.top: nwsseprator1.bottom
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
                text: "Minimum Temperature: " + model.contents.itemWeatherTempMinHourZero + model.contents.itemWeatherMetricType
                }
                
            Rectangle {
                id: nwsseprator2
                width: parent.width
                anchors.top: weatherDshTempMinLabel.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }

            Text {
                id: weatherDshTempCurrentLabel
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
                text: "Current Temperature: " + model.contents.itemWeatherTempHourZero + model.contents.itemWeatherMetricType
            }
            
            Rectangle {
                id: nwsseprator3
                width: parent.width
                anchors.top: weatherDshTempCurrentLabel.bottom
                anchors.topMargin: 1
                height: 2
                color: theme.linkColor
            }

            Text {
                id: weatherDshTempMaxLabel
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
                text:"Maximum Temperature: " + model.contents.itemWeatherTempMaxHourZero + model.contents.itemWeatherMetricType
                }
 
                PlasmaCore.SvgItem {
                    id: horizontalSepWeathrCard1
                    anchors {
                        left: contentdlgtitem.left
                        right: contentdlgtitem.right
                        top: weatherDshTempMaxLabel.bottom
                    }
                    width: 1
                    height: horlineweatherextendSvg.elementSize("horizontal-line").height

                    elementId: "horizontal-line"
                    z: 110
                    svg: PlasmaCore.Svg {
                        id: horlineweatherextendSvg;
                        imagePath: "widgets/line"
                    }
                }  
                
            Item {
                id: footerBx
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: units.gridUnit * 1.5
                
                Rectangle {
                    id: expandBtnRectBg
                    height: units.gridUnit * 1.25
                    width: units.gridUnit * 1.25
                    radius: 100
                    color: theme.backgroundColor
                    anchors.centerIn: parent
                    z: 400
                    
                    PlasmaCore.ToolTipArea {
                        id: toolTipExpand
                        mainText: i18n("Expand Forecast")
                        anchors.fill: parent
                    }
                    
                    PlasmaCore.ToolTipArea {
                        id: toolTipCollapse
                        mainText: i18n("Close")
                        anchors.fill: parent
                    }
                    
                    PlasmaCore.IconItem {
                        id: expandWeatherCardBtn
                        anchors.centerIn: parent
                        source: "go-down"
                        width: units.gridUnit * 1.15
                        height: units.gridUnit * 1.15
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            
                            onClicked: {
                                if(!expanded){
                                    dashboardmodelview.positionViewAtIndex(findIndex(model.itemType), ListView.SnapPosition)
                                    dashdelegatelview.height = cbheight - units.gridUnit * 2
                                    dashDelegateItmWeather.height = dashdelegatelview.height
                                    expanded = true
                                    expandWeatherCardBtn.source = "go-up"
                                    weatherForcastItem.state = "CardExpanded"
                                }
                                else if(expanded){
                                    dashDelegateItmWeather.height = units.gridUnit * 7.75
                                    dashdelegatelview.height = dashDelegateItmWeather.height
                                    expanded = false
                                    expandWeatherCardBtn.source = "go-down"
                                    weatherForcastItem.state = "CardNotExpanded"
                                }
                            }
                        }
                    }
                }

                Item {
                    id: extensionFrame
                    anchors.top: horizontalSepWeathrCard1.bottom
                    anchors.bottom: footerBx.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    visible: expanded ? true : false

                    Image{
                        id: weatherForcastBgImage
                        anchors.fill: parent
                        anchors.margins: units.gridUnit * 0.25
                        
                        Component.onCompleted: {
                            var conditionType = model.contents.itemWeatherTempTypeHourA.toLowerCase();
                            if(conditionType.indexOf("scattered") !== -1 && conditionType.indexOf("clouds") !== -1 || conditionType.indexOf("clear") !== -1 || conditionType.indexOf("clouds") !== -1 ){
                                weatherForcastBgImage.source = "../images/climatesc.jpg"
                            }
                            else if(conditionType.indexOf("rain") !== -1){
                                weatherForcastBgImage.source = "../images/rain.gif"
                            } 
                            else if(conditionType.indexOf("snow") !== -1){
                                weatherForcastBgImage.source = "../images/snow.gif"
                            }
                            else if(conditionType.indexOf("snow") !== -1){
                                weatherForcastBgImage.source = "../images/snow.gif"
                            }
                            else if(conditionType.indexOf("haze") !== -1){
                                weatherForcastBgImage.source = "../images/haze.gif"
                            }
                            else {
                                weatherForcastBgImage.source = "../images/bluesky.png"
                            }
                        }
                        

                        Rectangle {
                         id: weatherForcastItem
                         anchors.left: parent.left
                         anchors.right: parent.right
                         anchors.top: parent.top
                         anchors.bottom: parent.bottom
                         anchors.topMargin: units.gridUnit * 1
                         anchors.bottomMargin: units.gridUnit * 1
                         color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2)
                         state: "CardNotExpanded"
                        
                         states: [
                                State {
                                    name: "CardExpanded"
                                    PropertyChanges { target: forcastItemExternalRow; width: parent.width }
                                    PropertyChanges { target: forcastItemExternalRow; height: parent.height - units.gridUnit * 2 }
                                    PropertyChanges { target: forcastItemInnerRowA; width: parent.width / 2 }
                                    PropertyChanges { target: forcastItemInnerRowA; height: parent.height }
                                    PropertyChanges { target: forcastItemInnerRowB; width: parent.width / 2 }
                                    PropertyChanges { target: forcastItemInnerRowB; height: parent.height }
                                    PropertyChanges { target: hourAsep0; width: parent.width }
                                    PropertyChanges { target: hourAsep0; height: 2 }
                                    PropertyChanges { target: hourBsep0; width: parent.width }
                                    PropertyChanges { target: hourBsep0; height: 2 }
                                    PropertyChanges { target: hourAsep1; width: parent.width }
                                    PropertyChanges { target: hourAsep1; height: 2 }
                                    PropertyChanges { target: hourBsep1; width: parent.width }
                                    PropertyChanges { target: hourBsep1; height: 2 }
                                    PropertyChanges { target: hourAsep2; width: parent.width }
                                    PropertyChanges { target: hourAsep2; height: 2 }
                                    PropertyChanges { target: hourBsep2; width: parent.width }
                                    PropertyChanges { target: hourBsep2; height: 2 }
                                    PropertyChanges { target: hourAsep3; width: parent.width }
                                    PropertyChanges { target: hourAsep3; height: 2 }
                                    PropertyChanges { target: hourBsep3; width: parent.width }
                                    PropertyChanges { target: hourBsep3; height: 2 }
                                    PropertyChanges { target: forecastItemCreditsFooter; width: parent.width }
                                    PropertyChanges { target: forecastItemCreditsFooter; height: units.gridUnit * 1 }
                                    PropertyChanges { target: toolTipExpand; enabled: false }
                                    PropertyChanges { target: toolTipExpand; visible: false }
                                    PropertyChanges { target: toolTipCollapse; enabled: true }
                                    PropertyChanges { target: toolTipCollapse; visible: true }

                                },
                                State {
                                    name: "CardNotExpanded"
                                    PropertyChanges { target: forcastItemExternalRow; width: 0 }
                                    PropertyChanges { target: forcastItemExternalRow; height: 0 }
                                    PropertyChanges { target: forcastItemInnerRowA; width: 0 }
                                    PropertyChanges { target: forcastItemInnerRowA; height: 0 }
                                    PropertyChanges { target: forcastItemInnerRowB; width: 0 }
                                    PropertyChanges { target: forcastItemInnerRowB; height: 0 }
                                    PropertyChanges { target: hourAsep0; width: 0 }
                                    PropertyChanges { target: hourAsep0; height: 0 }
                                    PropertyChanges { target: hourBsep0; width: 0 }
                                    PropertyChanges { target: hourBsep0; height: 0 }
                                    PropertyChanges { target: hourAsep1; width: 0 }
                                    PropertyChanges { target: hourAsep1; height: 0 }
                                    PropertyChanges { target: hourBsep1; width: 0 }
                                    PropertyChanges { target: hourBsep1; height: 0 }
                                    PropertyChanges { target: hourAsep2; width: 0 }
                                    PropertyChanges { target: hourAsep2; height: 0 }
                                    PropertyChanges { target: hourBsep2; width: 0 }
                                    PropertyChanges { target: hourBsep2; height: 0 }
                                    PropertyChanges { target: hourAsep3; width: 0 }
                                    PropertyChanges { target: hourAsep3; height: 0 }
                                    PropertyChanges { target: hourBsep3; width: 0 }
                                    PropertyChanges { target: hourBsep3; height: 0 }
                                    PropertyChanges { target: forecastItemCreditsFooter; width: 0 }
                                    PropertyChanges { target: forecastItemCreditsFooter; height: 0 }
                                    PropertyChanges { target: toolTipExpand; enabled: true }
                                    PropertyChanges { target: toolTipExpand; visible: true }
                                    PropertyChanges { target: toolTipCollapse; enabled: false }
                                    PropertyChanges { target: toolTipCollapse; visible: false }
                                }
                              ]
                        
                         Row{
                            id: forcastItemExternalRow
                            spacing: 4
                            
                            Item {
                             id: forcastItemInnerRowA
                             
                             Text {
                                id: weatherDshDateLabelHourA
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
                                text: i18n("D: " + model.contents.itemWeatherDateHourA.split(" ")[0] + " | " + "T: " + model.contents.itemWeatherDateHourA.split(" ")[1])
                             }
                             
                             Rectangle {
                                id: hourAsep0
                                anchors.top: weatherDshDateLabelHourA.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                              }
                             
                             Text {
                                id: weatherDshConditionLabelHourA
                                anchors.top: hourAsep0.bottom
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
                                text: i18n("Condition: " + model.contents.itemWeatherTempTypeHourA)
                             }
                             
                            Image {
                                id: weatherDashCardIconHourA
                                anchors.left: weatherDshConditionLabelHourA.right
                                anchors.verticalCenter: weatherDshConditionLabelHourA.verticalCenter
                                source: model.contents.itemWeatherIconTypeHourA
                                width: units.gridUnit * 1.25
                                height: units.gridUnit * 1.25
                            }
                             
                             Rectangle {
                                id: hourAsep1
                                anchors.top: weatherDshConditionLabelHourA.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                              }
                              
                             Text {
                                id: weatherDshWindLabelHourA
                                anchors.top: hourAsep1.bottom
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
                                text: i18n("Wind: " + model.contents.itemWeatherWindHourA + " meters/sec")
                             }
                             
                             Rectangle {
                                id: hourAsep2
                                anchors.top: weatherDshWindLabelHourA.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                              }
                                
                             Text {
                                id: weatherDshTempMinLabelHourA
                                anchors.top: hourAsep2.bottom
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
                                text: "Min: " + model.contents.itemWeatherTempHourA + model.contents.itemWeatherMetricType
                             }
                             
                             Rectangle {
                                id: hourAsep3
                                width: expanded ? 0 : parent.width
                                anchors.top: weatherDshTempMinLabelHourA.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                                }
                                
                             Text {
                                id: weatherDshTempMaxLabelHourA
                                anchors.top: hourAsep3.bottom
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
                                text: "Max: " + model.contents.itemWeatherTempHourA + model.contents.itemWeatherMetricType
                                }
                              }
                              
                              Item {
                                  id: forcastItemInnerRowB
                                  
                              Text {
                                id: weatherDshDateLabelHourB
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
                                text: i18n("D: " + model.contents.itemWeatherDateHourB.split(" ")[0] + " | " + "T: " + model.contents.itemWeatherDateHourB.split(" ")[1])
                                }
                             
                             Rectangle {
                                id: hourBsep0
                                anchors.top: weatherDshDateLabelHourB.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                              }
                              
                             Text {
                                id: weatherDshConditionLabelHourB
                                anchors.top: hourBsep0.bottom
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
                                text: i18n("Condition: " + model.contents.itemWeatherTempTypeHourB)
                             }
                             
                             Image {
                                id: weatherDashCardIconHourB
                                anchors.left: weatherDshConditionLabelHourB.right
                                anchors.verticalCenter: weatherDshConditionLabelHourB.verticalCenter
                                source: model.contents.itemWeatherIconTypeHourB
                                width: units.gridUnit * 1.25
                                height: units.gridUnit * 1.25
                             }
                             
                             Rectangle {
                                id: hourBsep1
                                anchors.top: weatherDshConditionLabelHourB.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                              }
                              
                             Text {
                                id: weatherDshWindLabelHourB
                                anchors.top: hourBsep1.bottom
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
                                text: i18n("Wind: " + model.contents.itemWeatherWindHourB + " meters/sec")
                             }
                             
                             Rectangle {
                                id: hourBsep2
                                anchors.top: weatherDshWindLabelHourB.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                             }
                              
                             Text {
                                id: weatherDshTempMinLabelHourB
                                anchors.top: hourBsep2.bottom
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
                                text: "Min: " + model.contents.itemWeatherTempHourB + model.contents.itemWeatherMetricType
                             }
                             
                             Rectangle {
                                id: hourBsep3
                                width: expanded ? 0 : parent.width
                                anchors.top: weatherDshTempMinLabelHourB.bottom
                                anchors.topMargin: expanded ? 0 : 1
                                height: expanded ? 0 : 2
                                color: theme.linkColor
                             }
                                
                             Text {
                                id: weatherDshTempMaxLabelHourB
                                anchors.top: hourBsep3.bottom
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
                                text: "Max: " + model.contents.itemWeatherTempHourB + model.contents.itemWeatherMetricType
                             }
                         }
                     }
                     
                     Rectangle {
                        id: forecastItemCreditsFooter
                        anchors.bottom: parent.bottom
                        color: theme.linkColor
                        
                        PlasmaComponents.Label{
                            id: creditOWM
                            anchors.right: parent.right
                            anchors.rightMargin: units.gridUnit * 0.15
                            anchors.verticalCenter: parent.verticalCenter
                            text: i18n("<i>Powered By: OpenWeatherMap</i>")
                        }
                     }
                 }
             }
         }
     }
            
        Drawer {
                id: mcmenuItem
                width: dwrpaddedwidth
                height: removeCardRectbtn.height + disableCardRectbtn.height 
                edge: Qt.TopEdge
                dragMargin: 0

                Rectangle {
                    id: menuRectItem
                    anchors.fill: parent
                    color: theme.backgroundColor
            
                    Column {
                        id: menuRectColumn
                        anchors.fill: parent
                        
                        Rectangle {
                            id: removeCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: removeCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "archive-remove"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: removeCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: removeCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Remove Card"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        removeCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        removeCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        dashCardCollectionModel.remove(index)
                                        removeChildCard()
                                    }
                                }
                            }
                            
                        Rectangle {
                            id: btnshorzSepr
                            width: parent.width
                            height: 1
                            color: theme.linkColor
                        }
                            
                        Rectangle {
                            id: disableCardRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: disableCardIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "document-close"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: disableCardSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: disableCardLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: "Disable Weather Cards"
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        disableCardLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        disableCardLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        weathercardswitch.checked = false
                                        dashCardCollectionModel.remove(index)
                                        removeChildCard()
                                        }
                                    }
                                }
                                
                        Rectangle {
                            id: btnshorzSeprEnd
                            width: parent.width
                            height: units.gridUnit * 0.75
                            color: theme.linkColor
                            
                            PlasmaCore.IconItem {
                                   id: closemenuDrawer
                                   anchors.centerIn: parent
                                   source: "go-up"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                                    }
                                }
                            }
                        }
                    }
                }
