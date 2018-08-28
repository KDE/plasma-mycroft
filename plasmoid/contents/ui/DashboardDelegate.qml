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
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: dashdelegteType
    height: dashdelegatelview.height
    width: parent.width
    property Component delegateComponentDisclaimer: Qt.createComponent("DisclaimerCardDelegate.qml")
    property Component delegateComponentWeather: Qt.createComponent("DashWeatherDelegate.qml")
    property Component delegateComponentNews: Qt.createComponent("DashNewsDelegate.qml")
    property Component delegateComponentCrypto: Qt.createComponent("DashCryptoDelegate.qml")

    Component.onCompleted: {
        filterSwitchDash(iType, iObj)
    }

    function filterSwitchDash(iType, iObj){
        switch(iType){
            case "Disclaimer":
                filterDashDisclaimerObj()
                break
            case "DashNews":
                filterDashNewsObj(iObj)
                break
            case "DashWeather":
                filterDashWeatherObj(iObj)
                break
            case "DashCryptoPrice":
                filterDashCryptoObj(iObj)
                break
        }
    }
    
    function filterDashDisclaimerObj() {
            dashCardCollectionModel.append({itemType: "Disclaimer", itemAt: 0, contents:{}})
            dashdelegatelview.delegate = delegateComponentDisclaimer
    }

    function filterDashWeatherObj(weatherobj){
        var filteredMetric
        if(weatherMetric.indexOf('metric') != -1){
                filteredMetric = "°c"
        }
        else if (weatherMetric.indexOf('imperial') != -1){
                filteredMetric = "°f"  
        }
        if(weatherobj){
                var filteredWeatherObject = JSON.parse(weatherobj)
                var weatherIcnTypeHourZero = "http://openweathermap.org/img/w/" + filteredWeatherObject.list[0].weather[0].icon + ".png"
                var weatherIcnTypeHourA = "http://openweathermap.org/img/w/" + filteredWeatherObject.list[1].weather[0].icon + ".png"
                var weatherIcnTypeHourB = "http://openweathermap.org/img/w/" + filteredWeatherObject.list[2].weather[0].icon + ".png"
                var weatherdateHourZero = filteredWeatherObject.list[0].dt_txt
                var weatherdateHourA = filteredWeatherObject.list[1].dt_txt
                var weatherdateHourB = filteredWeatherObject.list[2].dt_txt
                dashCardCollectionModel.append({itemType: "DashWeather", itemAt: 1, contents:{itemWeatherTempHourZero: filteredWeatherObject.list[0].main.temp, itemWeatherTempHourA: filteredWeatherObject.list[1].main.temp, itemWeatherTempHourB: filteredWeatherObject.list[2].main.temp, itemWeatherTempMinHourZero: filteredWeatherObject.list[0].main.temp_min, itemWeatherTempMinHourA: filteredWeatherObject.list[1].main.temp_min, itemWeatherTempMinHourB: filteredWeatherObject.list[2].main.temp_min, itemWeatherTempMaxHourZero: filteredWeatherObject.list[0].main.temp_max, itemWeatherTempMaxHourA: filteredWeatherObject.list[1].main.temp_max, itemWeatherTempMaxHourB: filteredWeatherObject.list[2].main.temp_max, itemWeatherTempTypeHourZero: filteredWeatherObject.list[0].weather[0].main, itemWeatherTempTypeHourA: filteredWeatherObject.list[1].weather[0].main, itemWeatherTempTypeHourB: filteredWeatherObject.list[2].weather[0].main, itemWeatherMetricType: filteredMetric, itemWeatherIconTypeHourZero: weatherIcnTypeHourZero, itemWeatherIconTypeHourA: weatherIcnTypeHourA, itemWeatherIconTypeHourB: weatherIcnTypeHourB, itemWeatherWindHourZero: filteredWeatherObject.list[0].wind.speed, itemWeatherWindHourA: filteredWeatherObject.list[1].wind.speed, itemWeatherWindHourB: filteredWeatherObject.list[2].wind.speed, itemWeatherCity: filteredWeatherObject.city.name, itemWeatherDateHourZero: weatherdateHourZero, itemWeatherDateHourA: weatherdateHourA, itemWeatherDateHourB: weatherdateHourB}})
                dashdelegatelview.delegate = delegateComponentWeather
         }
    }

    function filterDashNewsObj(newsobj){
            if(newsobj){
              var filteredNewsObject = JSON.parse(newsobj)
              for (var i=0; i<filteredNewsObject.totalResults; i++){
                  dashCardCollectionModel.append({itemType: "DashNews", itemAt: 2, contents: {newsSource: filteredNewsObject.articles[i].source.name, newsTitle: filteredNewsObject.articles[i].title, newsDescription: filteredNewsObject.articles[i].description, newsURL: filteredNewsObject.articles[i].url, newsImgURL: filteredNewsObject.articles[i].urlToImage}})
                  dashdelegatelview.delegate = delegateComponentNews
              }
         }
    }
    
    function filterDashCryptoObj(cryptobj){
        if(cryptobj){
         var filteredCryptObj = JSON.parse(cryptobj)
         var currency1 = filteredCryptObj[innerset.selectedCur1]
         var currency2 = filteredCryptObj[innerset.selectedCur2]
         var currency3 = filteredCryptObj[innerset.selectedCur3]
         dashCardCollectionModel.append({itemType: "DashCryptoPrice", itemAt: 3, contents: {cryptoType: innerset.selectedCrypto, cryptoSymbol1: innerset.selectedCur1, cryptoSymbol2: innerset.selectedCur2, cryptoSymbol3: innerset.selectedCur3, cryptoCurRate1: currency1, cryptoCurRate2: currency2, cryptoCurRate3: currency3}})
         dashdelegatelview.delegate = delegateComponentCrypto
        }
    }
    
    function removeChildCard(){
        dashLmodel.remove(index)
    }

    function findIndex(itemType){
        for(var i=0; i<dashboardmodelview.model.count; i++ ){
            
            if(dashboardmodelview.model.get(i).iType === itemType){
                return i;
            }
        }
    }

Drawer {
    id:  sharePagePopup
    width: parent.width
    height: units.gridUnit * 4
    edge: Qt.TopEdge
    dragMargin: 0
    
    Rectangle {
    anchors.fill: parent
    color: theme.backgroundColor

                        Column {
                        id: menuRectColumn
                        anchors.fill: parent
                        
                        Rectangle {
                            id: shareViaEmailRectbtn
                            width: parent.width
                            height: units.gridUnit * 2
                            color: theme.backgroundColor
                            
                            Row {
                               spacing: 5
                                PlasmaCore.IconItem {
                                   id: shareViaEmailIcon
                                   anchors.verticalCenter: parent.verticalCenter
                                   source: "mail-signed-part"
                                   width: units.gridUnit * 2
                                   height: units.gridUnit * 2
                               }
                               Rectangle {
                                   id: shareViaEmailSeperater
                                   width: 1
                                   height: parent.height
                                   color: theme.linkColor
                               }
                               PlasmaComponents.Label {
                                   id: shareViaEmailLabel
                                   anchors.verticalCenter: parent.verticalCenter
                                   text: i18n("Share Via Email")
                                }
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                    onEntered: {
                                        shareViaEmailLabel.color = theme.linkColor
                                    }
                                    onExited:{
                                        shareViaEmailLabel.color = theme.textColor
                                    }
                                    onClicked:{
                                        Qt.openUrlExternally("mailto://");
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

ListModel {
        id: dashCardCollectionModel
}
    
FocusScope {
    anchors.fill:parent
    focus: true
    
ListView {
     id: dashdelegatelview
     width: cbwidth - units.gridUnit * 0.25
     height: childrenRect.height
     spacing: units.gridUnit * 0.3
     interactive: true
     clip: true;
     model: dashCardCollectionModel

     onCountChanged: {
         if (dashdelegatelview.model.count != 0){
         var root = dashdelegatelview.visibleChildren[0]
         var listViewHeight = 0
         var listViewWidth = 0
         var scrollableHeight

         for (var i = 0; i < root.visibleChildren.length; i++) {
             listViewHeight = root.visibleChildren[i].height
             scrollableHeight += root.visibleChildren[i].height
         }
         dashdelegatelview.contentHeight = scrollableHeight
                }
            }
        
        Component.onCompleted: {
            if(dashCardCollectionModel.index !== -1){
                dashboardmodelview.forceActiveFocus();   
                }
            }
        }
    }
}

