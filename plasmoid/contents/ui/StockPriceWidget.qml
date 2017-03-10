import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQml.Models 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Column {
                        spacing: 6
                        //anchors.right: parent.right
                        //anchors.left: parent.left

                        //readonly property bool sentByMe: model.recipient !== "Me"
                     //   property alias mssg: messageText.text
                        property alias currentstockprice: stockWidgetPrice.text
                        property alias currentstocksymbol: stockWidgetSymbol.text


                        Row {
                            id: messageRow
                            spacing: 6

                            Rectangle{
                            id: messageWrapper
                            width: cbwidth
                            height: messageRect.height
                            color: theme.backgroundColor

                            Rectangle {
                                id: messageRect
                                width: cbwidth / 1.1
                                height: messageText.implicitHeight + 24
                                //anchors.right: avatar.right
                                color: theme.backgroundColor

                PlasmaComponents.Label {
                    id: stockWidgetHeader
                    color: "#ffffff"
                    text: qsTr("Stock Price Info")
                    style: Text.Raised
                    font.italic: false
                    textFormat: Text.AutoText
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    wrapMode: Text.NoWrap
                    font.bold: true
                    font.family: "Times New Roman"
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pixelSize: 30
                }

                PlasmaComponents.Label {
                    id: stockWidgetSymbol
                    color: "#ffffff"
                    text: qsTr("Text")
                    font.bold: true
                    anchors.top: stockWidgetHeader.bottom
                    anchors.topMargin: 15
                    anchors.right: parent.right
                    style: Text.Raised
                    font.family: "Times New Roman"
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    font.pixelSize: 35

                    PlasmaComponents.Label {
                        id: stockWidgetPriceLabel
                        color: "#ffffff"
                        text: qsTr("Stock Price:")
                        font.italic: true
                        font.family: "Times New Roman"
                        style: Text.Raised
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 150
                        font.pixelSize: 24

                       PlasmaComponents.Label {
                            id: stockWidgetPrice
                            color: "#ffffff"
                            text: qsTr("128.89")
                            font.italic: true
                            style: Text.Raised
                            font.family: "Times New Roman"
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 124
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            font.pixelSize: 27
                        }
                            }
                           }

                        }
                    }
}
}
