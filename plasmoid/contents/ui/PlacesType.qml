import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import QtWebKit 3.0
import QtWebKit.experimental 1.0

Rectangle {
    id: partclc
    height: cbheight
    width: cbwidth
    color: theme.backgroundColor
    property alias routeLmodel: routeListModel
    
    Component.onCompleted: {
        console.log(cbheight)
    }
    
ListModel {
        id: routeListModel
}

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

Drawer {
    id: navMapDrawer
    width: parent.width
    height: cbdrawercontentheight
    edge: Qt.RightEdge
    dragMargin: 0
    property alias getURL: navMapView.url

    Rectangle {
            id: navParentRect
            width: parent.width
            height: parent.height
            color: Qt.lighter(theme.backgroundColor, 1.2)

        WebView {
            id: navMapView
            width: parent.width
            height: parent.height / 2
            experimental.useDefaultContentItemSize: true
            experimental.userStyleSheets: "../code/maps.css"
            experimental.page.height: navMapView.height
            experimental.page.width: parent.width
            }

        ListView {
            id: navMapDirections
            anchors.top: navMapView.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            model: routeLmodel
            spacing: 2
            focus: false
            interactive: true
            clip: true;
            delegate: NavigationDelegate{}
            ScrollBar.vertical: ScrollBar {
               active: true
               policy: ScrollBar.AlwaysOn
               snapMode : ScrollBar.SnapAlways
           }
         }
      }
   }
}
 
