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

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtGraphicalEffects 1.0

Rectangle {
    id: container
    implicitHeight: autoCompListView.implicitHeight
    implicitWidth: cbwidth
    color: theme.backgroundColor
    border.width:  1
    border.color: Qt.lighter(theme.backgroundColor, 1.2);
    property QtObject model: undefined
    property int count: filterItem.model.count
    property alias suggestionsModel: filterItem.model
    property alias filter: filterItem.filter
    property alias property: filterItem.property
    property alias navView: autoCompListView
    signal itemSelected(variant item)

    function filterMatchesLastSuggestion() {
        return suggestionsModel.count == 1 && suggestionsModel.get(0).name === filter
    }

    visible: filter.length > 0 && suggestionsModel.count > 0 && !filterMatchesLastSuggestion()

    Logic {
        id: filterItem
        sourceModel: container.model
    }

    ListView{
        id: autoCompListView
        anchors.fill: parent
        model: container.suggestionsModel
        implicitHeight: contentItem.childrenRect.height
        verticalLayoutDirection: ListView.TopToBottom
        keyNavigationEnabled: true
        keyNavigationWraps: true
        clip: true
        delegate: Item {
            id: delegateItem
            property bool keyboardSelected: autoCompListView.selectedIndex === suggestion.index
            property bool selected: itemMouseArea.containsMouse
            property variant suggestion: model

            height: textComponent.height + units.gridUnit * 2
            width: container.width

            FocusScope{
                anchors.fill:parent
                focus: true

            Rectangle{
                id: autdelRect
                color: delegateItem.selected ? Qt.darker(theme.textColor, 1.2) : Qt.darker(theme.backgroundColor, 1.2)
                width: parent.width
                height: textComponent.height + units.gridUnit * 2
                
                PlasmaCore.IconItem {
                    id : smallIconV
                    source: "text-speak"
                    width: units.gridUnit * 2
                    height: units.gridUnit * 2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: units.gridUnit * 0.35
                }
                
                PlasmaCore.SvgItem {
                        id: innerDelegateRectDividerLine
                        anchors {
                            left: smallIconV.right
                            leftMargin: units.gridUnit * 0.35
                            top: parent.top
                            topMargin: 0
                            bottom: parent.bottom
                            bottomMargin: 0
                        }
                    width: lineitemdividerSvg.elementSize("vertical-line").width
                    z: 110
                    elementId: "vertical-line"

                    svg: PlasmaCore.Svg {
                    id: lineitemdividerSvg;
                    imagePath: "widgets/line"
                    }
                }  
                
                Text {
                    id: textComponent
                    anchors.left: innerDelegateRectDividerLine.right
                    anchors.leftMargin: units.gridUnit * 0.35
                    color: delegateItem.selected ? Qt.darker(theme.backgroundColor, 1.2) : Qt.darker(theme.textColor, 1.2)
                    text: model.name;
                    width: parent.width - 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                 }
                 
            MouseArea {
                id: itemMouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: container.itemSelected(delegateItem.suggestion)
                    }
                    
                PlasmaCore.SvgItem {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    width: 1
                    height: horlineAutoCSvg.elementSize("horizontal-line").height

                    elementId: "horizontal-line"
                    z: 110
                    svg: PlasmaCore.Svg {
                        id: horlineAutoCSvg;
                        imagePath: "widgets/line"
                        }
                    } 
                }
             }
           }
     ScrollBar.vertical: ScrollBar { }
    }
}
