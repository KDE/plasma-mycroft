import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.WebSockets 1.0
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import "Applet.js" as Applet
import "Autocomplete.js" as Autocomplete
import "Conversation.js" as Conversation
import "Dashboard.js" as Dash

Item {
    id: skillTipsPage
    anchors.fill: parent

                ListView {
                    id: skillslistmodelview
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    model: SkillModel{}
                    delegate: SkillView{}
                    spacing: 4
                    focus: false
                    interactive: true
                    clip: true;
                }

}
