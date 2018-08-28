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


Item {
 anchors.fill: parent
 property alias conversationModel: convoLmodel
 property alias conversationListView: inputlistView
 
    ListModel{
        id: convoLmodel
    }
    
    Item {
    id: messageBox
    anchors.fill: parent
                
        ColumnLayout {
            id: colconvo
            anchors.fill: parent
        
        ListView {
            id: inputlistView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: units.gridUnit * 0.15
            verticalLayoutDirection: ListView.TopToBottom
            spacing: 12
            clip: true
            model: convoLmodel
            ScrollBar.vertical: conversationListScrollBar
            delegate:  Component {
                Loader {
                        source: switch(itemType) {
                                case "NonVisual": return "SimpleMessageType.qml"
                                case "WebViewType": return "WebViewType.qml"
                                case "CurrentWeather": return "CurrentWeatherType.qml"
                                case "DropImg" : return "ImgRecogType.qml"
                                case "AskType" : return "AskMessageType.qml"
                                case "LoaderType" : return "LoaderType.qml"
                                case "PlacesType" : return "PlacesType.qml"
                                case "RecipeType" : return "RecipeType.qml"    
                                case "DashboardType" : return "DashboardType.qml"
                                case "AudioFileType" : return "AudioFileDelegate.qml"
                                case "VideoFileType" : return "VideoFileDelegate.qml"
                                case "DocumentFileType" : return "DocumentFileDelegate.qml"
                                case "FallBackType" : return "FallbackWebSearchType.qml"
                                case "StackObjType" : return "StackObjType.qml"
                                case "BookType" : return "BookType.qml"
                                case "WikiType" : return "WikiType.qml"
                                case "YelpType" : return "YelpType.qml"
                                case "ImageType" : return "ImageType.qml"
                                }
                            property var metacontent : dataContent
                        }
                }
        
        onCountChanged: {
            inputlistView.positionViewAtEnd();
                        }
                            }
        
        PlasmaComponents3.ScrollBar {
                id: conversationListScrollBar
                orientation: Qt.Vertical
                interactive: true
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
    }
}
