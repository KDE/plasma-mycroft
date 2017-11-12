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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa


Rectangle {
                id: tipscontent
                Layout.fillWidth: true;
                anchors { 
                    left: parent.left;
                    leftMargin: 0.5;
                    right: parent.right 
                    
                }
                height: units.gridUnit * 5
                border.width: 1        
                border.color: Qt.darker(theme.linkColor, 1.2)
                color: Qt.darker(theme.backgroundColor, 1.2)
                
                Image {
                    id: innerskImg
                    source: Pic
                    width: units.gridUnit * 1.2
                    height: units.gridUnit * 1.2
                    anchors.left: parent.left
                    anchors.leftMargin: units.gridUnit * 0.25
                    anchors.verticalCenter: parent.verticalCenter
                }
                        
                    PlasmaCore.SvgItem {
                        anchors {
                        left: innerskImg.right
                        leftMargin: 4
                        top: parent.top
                        topMargin: 0
                        bottom: parent.bottom
                        bottomMargin: 0
                        }

                        width: lineskillpgSvg.elementSize("vertical-line").width
                        z: 110
                        elementId: "vertical-line"

                        svg: PlasmaCore.Svg {
                        id: lineskillpgSvg;
                        imagePath: "widgets/line"
                        }
                            }     
                        
                    Item {
                        id: skilltipsinner
                        anchors.left: innerskImg.right
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        //color: theme.backgroundColor
                        anchors.top: tipscontent.top
                        anchors.bottom: parent.bottom
                        
                    PlasmaComponents.Label {
                        id: innerskllname
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        wrapMode: Text.WordWrap; 
                        font.bold: true; 
                        text: i18n(Skill) 
                    }
                    
                    Rectangle {
                        id: sepratrln1
                        height: 1
                        anchors.top: innerskllname.bottom
                        anchors.topMargin: 2
                        anchors.bottomMargin: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: Qt.darker(theme.linkColor, 1.2)
                    }
                    
                    Column{
                        id: innerskillscolumn
                        anchors.top: sepratrln1.bottom
                        
                        PlasmaComponents.Label {wrapMode: Text.WordWrap; width: main.width; text: i18n('<b>Command:</b> ' + CommandList.get(0).Commands)}
                        PlasmaComponents.Label {wrapMode: Text.WordWrap; width: main.width; text: i18n('<b>Command:</b> ' + CommandList.get(1).Commands)}
                            }
                        }
                    }
                    
 
