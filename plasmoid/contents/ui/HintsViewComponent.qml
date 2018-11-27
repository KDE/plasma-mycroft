import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: Kirigami.Theme.backgroundColor
    
    ListView {
        id: hintsListView
        anchors.fill: parent
        model: HintsModel{}
        delegate: HintsView{}
        spacing: 4
        focus: false
        interactive: true
        clip: true;
    }
}
