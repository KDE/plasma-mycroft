import QtQuick 2.0
import QtQml.Models 2.2
import QtQuick.Controls 2.0
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
                            
                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: newikiFlick.height
                        color: theme.backgroundColor

                        Flickable {
                            id: newikiFlick
                            width: messageRect.width
                            height: units.gridUnit * 10

                            WebView {
                                id: wikiview
                                anchors.fill: parent
                                experimental.preferredMinimumContentsWidth: 450
                                url: model.InputQuery
                                
                                Rectangle {
                                id: hoverBg1
                                anchors.right: parent.right
                                anchors.rightMargin: 15
                                anchors.top: parent.top
                                anchors.topMargin: 5
                                visible: true
                                height: units.gridUnit * 2.2
                                width: units.gridUnit * 2.2
                                radius: 10
                                z: 2
                                color: theme.backgroundColor
                            
                            PlasmaComponents.ToolButton {
                                id: viewExtendedScreen
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                visible: true
                                iconSource: "file-zoom-in"
                                flat: false
                                checked: false
                                focus: false
                                height: units.gridUnit * 2
                                width: units.gridUnit * 2
                                z: 10
                           
                           onClicked: {
                                var browsrUrl  = model.InputQuery
                                PlasmaLa.LaunchApp.runCommand("x-www-browser", browsrUrl) 
                                    }
                                }
                            }
                            
                            }
                            ScrollIndicator.vertical: ScrollIndicator { }
                            
                                    }   
                                        }
                                            }
                                                }
