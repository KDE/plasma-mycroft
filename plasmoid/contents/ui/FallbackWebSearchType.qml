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
import QtWebKit 3.0
import QtWebKit.experimental 1.0

Column {
                    spacing: 6
                    anchors.right: parent.right
                        
                    Row {
                        id: messageRow
                        spacing: 6
                            
                    Item {
                        id: messageRect
                        width: cbwidth
                        height: newolfFlick.height

                        Flickable {
                            id: newolfFlick
                            width: messageRect.width
                            height: units.gridUnit * 10
                            contentHeight: wikiview.height
                            clip: true
                            
                           WebView {
                            id: wikiview
                            height: units.gridUnit * 20
                            width: parent.width
                            url: InputQuery
                            experimental.preferredMinimumContentsWidth: cbwidth
                            experimental.useDefaultContentItemSize: false
                            experimental.transparentBackground: true
                            experimental.userStyleSheets: "../code/fallback.css"
                            opacity: 0
                                                        
                            onLoadingChanged: {
                                switch (loadRequest.status)
                                {
                                case WebView.LoadSucceededStatus:
                                    opacity = 1
                                    return
                                case WebView.LoadStartedStatus:
                                    break
                                case WebView.LoadStoppedStatus:
                                    break
                                case WebView.LoadFailedStatus:
                                    break
                                }
                                opacity = 0
                            }

                        }
                            
                            
                            ScrollIndicator.vertical: ScrollIndicator { }
                            
                                    }   
                                        }
                                            }
                                                }
 
