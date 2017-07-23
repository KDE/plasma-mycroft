import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
    id: suggestionsmainitem
    color: "#00000000"
    anchors.fill: parent
    property alias suggest1: suggestiontext1.text
    property alias suggest2: suggestiontext2.text
    property alias suggest3: suggestiontext3.text

    Rectangle {
        id: suggestionbutton1
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        border.width: 0.2
        border.color: theme.textColor
        anchors.left: parent.left
        anchors.leftMargin: 0
        width: suggestionsmainitem.width / 3

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton1.color = theme.textColor
            suggestiontext1.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton1.color = "#00000000"
            suggestiontext1.color = theme.textColor
            }

            onClicked: {
            var suggest1 = qinput.text
            var lastIndex = suggest1.lastIndexOf(" ");
            qinput.text = suggest1.substring(0, lastIndex) +  " " + suggestiontext1.text + " "
            }
        }

  PlasmaComponents.Label {
            id: suggestiontext1
            text: i18n("")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: suggestionbutton2
        color: "#00000000"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: suggestionbutton3.left
        anchors.rightMargin: 0
        border.width: 0.2
        anchors.left: suggestionbutton1.right
        anchors.leftMargin: 0
        border.color: theme.textColor

        MouseArea {
            id: mouseArea2
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton2.color = theme.textColor
            suggestiontext2.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton2.color = "#00000000"
            suggestiontext2.color = theme.textColor
            }

            onClicked: {
            var suggest2 = qinput.text
            var lastIndex = suggest2.lastIndexOf(" ");
            qinput.text = suggest2.substring(0, lastIndex) +  " " + suggestiontext2.text + " "
            }
        }

        PlasmaComponents.Label {
            id: suggestiontext2
            text: i18n("")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: suggestionbutton3
        color: "#00000000"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        border.color: theme.textColor
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        border.width: 0.2
        width: parent.width / 3

        MouseArea {
            id: mouseArea3
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton3.color = theme.textColor
            suggestiontext3.color = theme.backgroundColor
            }

            onExited: {
            suggestionbutton3.color = "#00000000"
            suggestiontext3.color = theme.textColor
            }

            onClicked: {
            var suggest3 = qinput.text
            var lastIndex = suggest3.lastIndexOf(" ");
            qinput.text = suggest3.substring(0, lastIndex) +  " " + suggestiontext3.text + " "
            }
        }

       PlasmaComponents.Label {
            id: suggestiontext3
            text: i18n("")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            }
        }
}
