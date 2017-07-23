import QtQuick 2.0
import QtQuick.Controls 2.0

Column {
                    id: colmsg
                    spacing: 6
                    anchors.right: parent.right

                    readonly property bool sentByMe: model.recipient !== "User"
                    //property alias mssg: messageText.text

                    Row {
                        id: messageRow
                        spacing: 6

                    Rectangle {
                        id: messageRect
                        width: cbwidth
                        radius: 2
                        height: messageText.implicitHeight
                        color: "#222"

                    Image {
                        id: messageText
                        anchors.fill: parent
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectCrop
                        source: model.InputQuery
                        sourceSize.width: cbwidth
                        sourceSize.height: units.gridUnit * 10
                        }
                            }
                                }
                                    }

