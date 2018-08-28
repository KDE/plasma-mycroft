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
        id: recipeDelegateItm
        height: units.gridUnit * 6
        color: Qt.darker(theme.backgroundColor, 1.2)
        anchors.left: parent.left
        anchors.right: parent.right
        width: cbwidth
        property alias viewbtnClickItem: recipeViewBtn

        Column {
            id: contentdlgtitem
            anchors.fill: parent
            
            Text {
                id: recipename
                anchors.left: parent.left
                anchors.right: parent.right
                wrapMode: Text.WordWrap;
                font.bold: true;
                text: recipeLabel.replace(/["']/g, "")
                color: theme.textColor
                }
            
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                color: theme.linkColor
                height: units.gridUnit * 0.1 
                }

        Item {
            id: recipeinner
            height: units.gridUnit * 4
            width: cbwidth

            Image {
                id: recipeImgType
                source: recipeImageUrl
                anchors.left: parent.left
                width: units.gridUnit * 4
                height: units.gridUnit * 4
            }
            
            Item {
                id: recipeInnerInfoColumn
                height: parent.height
                anchors.left: recipeImgType.right
                
            Text{
                id: recipeCalorieCount
                width: parent.width;
                color: theme.textColor ;
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                height: units.gridUnit * 1
                text: i18n("<i>Calories:</i> %1 <b>cal</b>", recipeCalories)
                }
                
            Text{
                id: recipeDietLabel
                width: parent.width;
                color: theme.textColor ;
                anchors.top: recipeCalorieCount.bottom
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                height: units.gridUnit * 1
                text: i18n("<i>Diet Type:</i> %1", recipeDiet)
                }
                
            Text{
                id: recipeHealthTagsLabel
                width: parent.width;
                color: theme.textColor ;
                anchors.top: recipeDietLabel.bottom
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                height: units.gridUnit * 1
                text: i18n("<i>Health Tags:</i> %1", recipeHealthTags)
                }    
            }
            
            PlasmaComponents.Button {
                  id: recipeViewBtn
                  anchors.right: parent.right
                  width: units.gridUnit * 6;
                  height: units.gridUnit * 4;
                  text: i18n("View Recipe")

                  onClicked: {
                    recipeReadLmodel.clear()  
                    recipeReadDrawer.open()
                    recipeReadDrawer.recipeReadDrawerHeader = "<b>" + recipeLabel.replace(/["']/g, "") + "</b>"
                    var readRecipeLines = recipeIngredientLines.split(",")
                    for(var i = 0; i < readRecipeLines.length; i++){
                        recipeReadLmodel.append({ingredients: readRecipeLines[i]})
                            }
                        }
                    }
            }
        
        Rectangle {
                id: recipeFooterSrc
                anchors.left: parent.left
                anchors.right: parent.right
                color: theme.linkColor
                height: units.gridUnit * 1
                
            Text {
                color: theme.textColor;
                font.pixelSize: 10
                text: i18n("<i>Recipe Source: %1</i>", recipeSource)
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                }
            
            Text {
                color: theme.textColor ;
                font.pixelSize: 10
                text: i18n("<i>Powered By: Edamam.com</i>")
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.25
                anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
