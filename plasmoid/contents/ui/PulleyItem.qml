import QtQuick 2.9
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import QtGraphicalEffects 1.0

Item {
 id: pulleyFrame
 anchors.fill: parent
 anchors.topMargin: units.gridUnit * 0.05
 anchors.bottomMargin: units.gridUnit * 0.02
 property bool opened: state === "PulleyExpanded"
 property bool closed: state === "PulleyClosed"
 property bool _isVisible
 property var barColor
 signal pulleyExpanded()
 signal pulleyClosed()

 function open() {
     pulleyFrame.state = "PulleyExpanded";
     pulleyExpanded();
 }

 function close() {
     pulleyFrame.state = "PulleyClosed";
     pulleyListView.positionViewAtBeginning()
     pulleyClosed();
 }

 states: [
     State {
         name: "PulleyExpanded"
         PropertyChanges { target: pulleyMenu; height: pulleyFrame.height - pulleyIconBar.height; }
         PropertyChanges { target: pulleyListView; interactive: true; }
         PropertyChanges { target: menudrawIcon; source: "go-down";}
     },
     State {
         name: "PulleyClosed"
         PropertyChanges { target: pulleyMenu; height: 0; }
         PropertyChanges { target: pulleyListView; interactive: false; }
         PropertyChanges { target: menudrawIcon; source: "go-up";}
     }
    ]


 transitions: [
     Transition {
         to: "*"
         NumberAnimation { target: pulleyMenu; properties: "height"; duration: 450; easing.type: Easing.OutCubic; }
     }
    ]

    Rectangle {
      id: pulleyIconBar
      anchors.bottom: pulleyMenu.top
      anchors.bottomMargin: 4
      height: units.gridUnit * 0.40
      color: barColor
      width: cbwidth
        PlasmaCore.IconItem {
                id: menudrawIcon
                visible: _isVisible
                anchors.centerIn: parent
                source: "go-up"
                width: units.gridUnit * 1.25
                height: units.gridUnit * 1.25
            }

        MouseArea{
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: {
                if (pulleyFrame.opened) {
                    pulleyFrame.close();
                } else {
                    pulleyFrame.open();
                }
            }
        }
    }

    Rectangle {
        id: pulleyMenu
        width: parent.width
        color: PlasmaCore.ColorScope.backgroundColor
        anchors.bottom: parent.bottom
        height: 0

        ListView {
            id: pulleyListView
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: pulleyEndArea.bottom
            model: SkillModel{}
            clip: true
            interactive: false;
            spacing: 5
            delegate:
                Rectangle {
                id: pulleyDelegateListBg
                height: units.gridUnit * 2.5
                color: Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2)
                radius: 4
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: units.gridUnit * 0.50
                anchors.rightMargin: units.gridUnit * 0.50
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 0
                    verticalOffset: 1
                    radius: 10
                    samples: 32
                    spread: 0.1
                    color: Qt.rgba(0, 0, 0, 0.3)
                }
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true
                    
                    onEntered: {
                        removeItemButton.visible = true
                        pulleyDelegateListBg.color = theme.linkColor
                    }
                    onExited: {
                        removeItemButton.visible = false
                        pulleyDelegateListBg.color = Qt.darker(PlasmaCore.ColorScope.backgroundColor, 1.2)
                    }
                    onClicked: {
                        pulleyFrame.close();
                        var genExampleQuery = CommandList.get(0).Commands;
                        var exampleQuery = genExampleQuery.toString().split(",");
                        var socketmessage = {};
                        socketmessage.type = "recognizer_loop:utterance";
                        socketmessage.data = {};
                        socketmessage.data.utterances = [exampleQuery[1].toLowerCase()];
                        socket.sendTextMessage(JSON.stringify(socketmessage));
                        qinput.text = "";
                        }
                }    
            
            PlasmaCore.IconItem {
                id: removeItemButton
                source: "window-close"
                width: units.gridUnit * 1.5
                height: units.gridUnit * 1.5
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.50
                visible: false
                
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    propagateComposedEvents: true
                    onEntered: { 
                        removeItemButton.visible = true
                    }
                    onClicked: {
                        SkillModel.remove(index)
                    }
                }
            }
                
                PlasmaComponents.Label {
                id: pulleyDelegateListLabel
                anchors.centerIn: parent
                    text: CommandList.get(0).Commands
                    color: PlasmaCore.ColorScope.textColor
                    
                    }
                }
            }

         Item {
                id: pulleyEndArea
                anchors.bottom: parent.bottom
                anchors.bottomMargin: units.gridUnit * 1.22
                width: parent.width
                height: units.gridUnit * 2.5
            }
        }
    }
