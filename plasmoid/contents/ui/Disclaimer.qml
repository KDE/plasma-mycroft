import QtQuick 2.7
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
anchors.fill: parent

    Text {
        id: disclaimerHeading1
        width: 0
        height: 28
        text: "Let's Continue ?"
        font.pointSize: 24
        elide: Text.ElideLeft
        font.family: "Verdana"
        wrapMode: Text.WrapAnywhere
        font.bold: true
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        color: "steelblue"
     }


     Text {
        id: disclaimerBody1
        height: contentHeight
        text: "Mycroft by default is powered by a cloud-based speech to text service. Mycroft gives you the ability to change speech to text services or use a locally configured one within their settings at home.mycroft.ai. If you agree to the default usage of Mycroft’s speech to text service, please continue. Also remember you can always choose to turn off or mute Mycroft when you do not wish to use it."
        font.pointSize: 10
        font.family: "Verdana"
        wrapMode: Text.Wrap
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        anchors.top: disclaimerHeading1.bottom
        anchors.topMargin: 18
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        color: theme.textColor
     }

     Rectangle {
     id: noticemsg
     anchors.top: disclaimerBody1.bottom
     anchors.topMargin: 20
     anchors.right: parent.right
     anchors.left: parent.left
     color: theme.backgroundColor
     height: disclaimerBody2.contentHeight
     
     Text {
        id: disclaimerBody2
        height: contentHeight
        text: "To start using Mycroft toggle the switch in the upper right corner!"
        font.italic: true
        font.pointSize: 10
        font.family: "Verdana"
        wrapMode: Text.WrapAnywhere
        renderType: Text.QtRendering
        horizontalAlignment: Text.AlignHCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        color: theme.textColor
        }
    }
}
