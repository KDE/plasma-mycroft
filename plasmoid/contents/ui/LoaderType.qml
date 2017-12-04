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
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa

Column {
                    spacing: 6
                    anchors.right: parent.right
                    property string filename: "file:///" + model.InputQuery
                    property int getHeight

                    Component.onCompleted: {
                        var mObj = loaderComp.createObject(loaderView, {})
                    }

                    Row {
                        id: messageRow
                        spacing: 6
                            
                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: newikiFlick.height
                        color: theme.backgroundColor

                        Flickable {
                            id: newikiFlick
                            width: messageRect.width
                            height: getHeight

                            Item {
                                id: loaderView
                                anchors.fill: parent
                                 }

                            Component {
                                id: loaderComp

                                Loader {
                                    id: loaderScreen
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    height: Math.max(item ? item.implicitHeight : 0, units.gridUnit * 10)
                                    source: filename

                                    function reload(){
                                        source = filename + "?t=" + Date.now()
                                    }

                                    Component.onCompleted: {
                                        loaderScreen.reload();
                                        getHeight = height
                                    }
                                 }
                              }
                            }
                          }
                        }
                      }
