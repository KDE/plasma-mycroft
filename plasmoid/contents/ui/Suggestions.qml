import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: suggestionsmainitem
    property alias suggest1: suggestiontext1.text
    property alias suggest2: suggestiontext2.text
    property alias suggest3: suggestiontext3.text

Flickable {
    width: parent.width
    height: parent.height
    contentWidth: units.gridUnit * 5
    contentHeight: parent.height
    interactive: true;
    
    Rectangle {
        id: suggestionbutton1
        width: suggestiontext1.contentWidth + 10
        height: 30
        color: "#00000000"
        radius: 5
        border.width: 1
        border.color: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 0

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton1.color = "#2b2b2b"
            suggestionbutton1.border.color = "#f2f22f"
            }

            onExited: {
            suggestionbutton1.color = "#00000000"
            suggestionbutton1.border.color = "grey"
            }

            onClicked: {
            suggst.visible = true
            conversationInputList.append({"InputQuery": suggestiontext1.text});
            inputlistView.positionViewAtEnd();
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [suggestiontext1.text];
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinput.text = suggestiontext1.text
            }
        }

        PlasmaComponents.Label {
            id: suggestiontext1
            text: qsTr("Text")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: suggestionbutton2
        width: suggestiontext2.contentWidth + 10
        height: 30
        color: "#00000000"
        radius: 5
        border.color: "#ffffff"
        anchors.left: suggestionbutton1.right
        anchors.leftMargin: 20

        MouseArea {
            id: mouseArea2
            height: 200
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton2.color = "#2b2b2b"
            suggestionbutton2.border.color = "#f2f22f"
            }

            onExited: {
            suggestionbutton2.color = "#00000000"
            suggestionbutton2.border.color = "grey"
            }

            onClicked: {
            suggst.visible = true
            conversationInputList.append({"InputQuery": suggestiontext2.text});
            inputlistView.positionViewAtEnd();
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [suggestiontext2.text];
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinput.text = suggestiontext1.text
            }
        }

        PlasmaComponents.Label {
            id: suggestiontext2
            text: qsTr("Text")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: suggestionbutton3
        width: suggestiontext3.contentWidth + 10
        height: 30
        color: "#00000000"
        radius: 5
        border.color: "#ffffff"
        anchors.left: suggestionbutton2.right
        anchors.leftMargin: 20

        MouseArea {
            id: mouseArea3
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
            suggestionbutton3.color = "#2b2b2b"
            suggestionbutton3.border.color = "#f2f22f"
            }

            onExited: {
            suggestionbutton3.color = "#00000000"
            suggestionbutton3.border.color = "grey"
            }

            onClicked: {
            suggst.visible = true
            conversationInputList.append({"InputQuery": suggestiontext3.text});
            inputlistView.positionViewAtEnd();
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [suggestiontext3.text];
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinput.text = suggestiontext1.text
            }
        }

        PlasmaComponents.Label {
            id: suggestiontext3
            text: qsTr("Text")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            }
        }
    }
}
