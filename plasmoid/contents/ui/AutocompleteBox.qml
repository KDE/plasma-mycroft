import QtQuick 2.7
import QtQuick.Controls 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtGraphicalEffects 1.0

Rectangle {
    id: container
    implicitHeight: units.gridUnit * 4
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
        verticalLayoutDirection: ListView.BottomToTop
        keyNavigationEnabled: true
        keyNavigationWraps: true
        clip: true
        delegate: Item {
            id: delegateItem
            property bool keyboardSelected: autoCompListView.selectedIndex === suggestion.index
            property bool selected: itemMouseArea.containsMouse
            property variant suggestion: model

            height: textComponent.height + 5
            width: container.width

            FocusScope{
                anchors.fill:parent
                focus: true

            Rectangle{
                id: autdelRect
                color: delegateItem.selected ? Qt.darker(theme.textColor, 1.2) : Qt.darker(theme.backgroundColor, 1.2)
                width: parent.width
                height: textComponent.height + 10
                
                Image {
                    id : smallIconV
                    source: "../images/mycroftsmaller2.png"
                    width: units.gridUnit * 2
                    height: units.gridUnit * 2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: units.gridUnit * 0.35
                                     
                    ColorOverlay {
                     anchors.fill: smallIconV
                     source: smallIconV
                     color: Qt.darker(theme.textColor, 1.2);
                  }
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
