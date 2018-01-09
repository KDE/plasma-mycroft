import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Rectangle {
    id: partclc
    height: units.gridUnit * 15
    width: cbwidth
    color: theme.backgroundColor

ListView {
     id: placesmodelview
     anchors.fill: parent
     model: plcLmodel
     spacing: 4
     focus: false
     interactive: true
     clip: true;
     delegate: PlacesDelegate{}
     ScrollBar.vertical: ScrollBar {
        active: true
        policy: ScrollBar.AlwaysOn
        snapMode : ScrollBar.SnapAlways
      }
    }
}
 
