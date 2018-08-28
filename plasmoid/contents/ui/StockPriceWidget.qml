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
                    text: i18n("Stock Price Info")
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
                    text: i18n("Text")
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
                        text: i18n("Stock Price:")
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
                            text: i18n("128.89")
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
