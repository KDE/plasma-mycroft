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

Item {
    id: dashdelegteType
    height: dashdelegatelview.height
    width: parent.width
    property alias dashnewsLmodel: dashnewsListModel
    property alias dashweatherLmodel: dashweatherListModel

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
            dashdelegatelview.model = disclaimerListModel
            disclaimerListModel.append({itemType: "Disclaimer"})
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
              var weatherIcnType = "http://openweathermap.org/img/w/" + filteredWeatherObject.weather[0].icon + ".png"
              dashdelegatelview.model = dashweatherLmodel
              dashweatherLmodel.append({itemType: "DashWeather", itemWeatherTemp: filteredWeatherObject.main.temp, itemWeatherTempMin: filteredWeatherObject.main.temp_min, itemWeatherTempMax: filteredWeatherObject.main.temp_max, itemWeatherTempType: filteredWeatherObject.weather[0].main, itemWeatherMetricType: filteredMetric, itemWeatherIconType: weatherIcnType, itemWeatherWind: filteredWeatherObject.wind.speed, itemWeatherCity: filteredWeatherObject.name})
          }
    }

    function filterDashNewsObj(newsobj){
            if(newsobj){
              var filteredNewsObject = JSON.parse(newsobj)
              for (var i=0; i<filteredNewsObject.totalResults; i++){
                  dashdelegatelview.model = dashnewsLmodel
                  dashnewsLmodel.append({itemType: "DashNews", newsSource: filteredNewsObject.articles[i].source.name, newsTitle: filteredNewsObject.articles[i].title, newsDescription: filteredNewsObject.articles[i].description, newsURL: filteredNewsObject.articles[i].url, newsImgURL: filteredNewsObject.articles[i].urlToImage})
              }
            }
        }
    
    function filterDashCryptoObj(cryptobj){
        if(cryptobj){
         var filteredCryptObj = JSON.parse(cryptobj)
         dashdelegatelview.model = dashCryptoPriceListModel
         var currency1 = filteredCryptObj[innerset.selectedCur1]
         var currency2 = filteredCryptObj[innerset.selectedCur2]
         var currency3 = filteredCryptObj[innerset.selectedCur3]
         dashCryptoPriceListModel.append({itemType: "DashCryptoPrice", cryptoType: innerset.selectedCrypto, cryptoUSDSymbol: innerset.selectedCur1, cryptoGBPSymbol: innerset.selectedCur2, cryptoEURSymbol: innerset.selectedCur3, cryptoUSDRate: currency1, cryptoGBPRate: currency2, cryptoEURRate: currency3})
        }
    }
    
    function removeChildCard(){
        dashLmodel.remove(index)
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
                                   text: "Share Via Email"
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
        id: dashnewsListModel
    }

ListModel {
        id: dashweatherListModel
    }
ListModel {
        id: disclaimerListModel
}
ListModel {
        id: dashCryptoPriceListModel
}

ListView {
     id: dashdelegatelview
     width: cbwidth - units.gridUnit * 0.25
     spacing: units.gridUnit * 0.3
     focus: false
     interactive: true
     clip: true;
     delegate: Loader{
                id: dashcardLoader
                source: switch(itemType){
                               case "Disclaimer": return "DisclaimerCardDelegate.qml"
                               case "DashNews": return "DashNewsDelegate.qml"
                               case "DashWeather": return "DashWeatherDelegate.qml"
                               case "DashCryptoPrice": return "DashCryptoDelegate.qml"
                }
        }

     onCountChanged: {
         if (dashdelegatelview.model.count != 0){
         var root = dashdelegatelview.visibleChildren[0]
         var listViewHeight = 0
         var listViewWidth = 0

         for (var i = 0; i < root.visibleChildren.length; i++) {
             listViewHeight += root.visibleChildren[i].height
             listViewWidth  = Math.max(listViewWidth, root.visibleChildren[i].width)
         }
         dashdelegatelview.height = listViewHeight + units.gridUnit * 1
        }
     }
   }
}

