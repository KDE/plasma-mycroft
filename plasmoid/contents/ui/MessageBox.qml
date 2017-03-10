import QtQuick 2.0
import QtQml.Models 2.2
import QtQuick.Controls 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Column {
                    spacing: 6
                    anchors.right: parent.right

                    readonly property bool sentByMe: model.recipient !== "User"
                    property alias mssg: messageText.text
                        
                    Row {
                        id: messageRow
                        spacing: 6
                            
                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: messageText.implicitHeight + 24
                        color: theme.backgroundColor

                    PlasmaComponents.Label {
                        id: messageText
                        text: model.InputQuery
                        anchors.fill: parent
                        anchors.margins: 12
                        wrapMode: Label.Wrap
                        }
                            }
                                }
                                    }
