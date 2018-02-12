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

Rectangle {
    id: dashdelegteType
    height: dashdelegatelview.height
    width: parent.width
    color: theme.backgroundColor
    property alias dashnewsLmodel: dashnewsListModel
    property alias dashweatherLmodel: dashweatherListModel

    Component.onCompleted: {
        //console.log(iType, iObj)
        filterSwitchDash(iType, iObj)
    }

    function filterSwitchDash(iType, iObj){
        switch(iType){
            case "Disclaimer":
                filterDashDisclaimerObj()
                console.log("Disclaimer HERE")
                break
            case "DashNews":
                filterDashNewsObj(iObj)
                break
            case "DashWeather":
                filterDashWeatherObj(iObj)
                break
        }
    }
    
    function filterDashDisclaimerObj() {
            dashdelegatelview.model = disclaimerListModel
            disclaimerListModel.append({itemType: "Disclaimer"})
    }

    function filterDashWeatherObj(weatherobj){
          if(weatherobj){
              var filteredWeatherObject = JSON.parse(weatherobj)
              dashdelegatelview.model = dashweatherLmodel
              dashweatherLmodel.append({itemType: "DashWeather", itemWeatherTemp: filteredWeatherObject.main.temp, itemWeatherTempMin: filteredWeatherObject.main.temp_min, itemWeatherTempMax: filteredWeatherObject.main.temp_max, itemWeatherTempType: filteredWeatherObject.weather[0].main})
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

ListModel {
        id: dashnewsListModel
    }

ListModel {
        id: dashweatherListModel
    }
ListModel {
        id: disclaimerListModel
}

ListView {
     id: dashdelegatelview
     width: cbwidth
     spacing: units.gridUnit * 0.5
     focus: false
     interactive: true
     clip: true;
     delegate: Component{
               Loader{
                source: switch(itemType){
                               case "Disclaimer": return "DisclaimerCardDelegate.qml"
                               case "DashNews": return "DashNewsDelegate.qml"
                               case "DashWeather": return "DashWeatherDelegate.qml"
                }
            }
        }

     onCountChanged: {
         var root = dashdelegatelview.visibleChildren[0]
         var listViewHeight = 0
         var listViewWidth = 0

         for (var i = 0; i < root.visibleChildren.length; i++) {
             listViewHeight += root.visibleChildren[i].height
             listViewWidth  = Math.max(listViewWidth, root.visibleChildren[i].width)
         }
         dashdelegatelview.height = listViewHeight + units.gridUnit * 2
     }
   }
}

