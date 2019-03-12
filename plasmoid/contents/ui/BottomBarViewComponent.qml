/* Copyright 2016 Aditya Mehra <aix.m@outlook.com>                            

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.
    
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.9
import QtQml.Models 2.2
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kirigami 2.5 as Kirigami
import QtGraphicalEffects 1.0
import Mycroft 1.0 as Mycroft

Item {
    id: appletBottomBarComponent
    anchors.fill: parent
    property alias autoCompModel: completionItems
    property alias queryInput: qinput
    property var lastMessage
    
    function autoAppend(model, getinputstring, setinputstring) {
        for(var i = 0; i < model.count; ++i)
            if (getinputstring(model.get(i))){
                return true
            }
        return null
    }

    function evalAutoLogic() {
        if (suggestionsBox.currentIndex === -1) {
        } else {
            suggestionsBox.complete(suggestionsBox.currentItem)
        }
    }


    ListModel {
        id: completionItems
    }
    
    ColumnLayout {
        anchors.fill: parent
        
        PlasmaComponents.TextField {
            id: qinput
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit * 2
            placeholderText: i18n("Enter Query or Say 'Hey Mycroft'")
            clearButtonShown: true

            onAccepted: {
                if(qinput.text !== ""){
                    lastMessage = qinput.text
                }
                var doesExist = appletBottomBarComponent.autoAppend(autoCompModel, function(item) { return item.name === qinput.text }, qinput.text)
                var evaluateExist = doesExist
                if(evaluateExist === null){
                    autoCompModel.append({"name": qinput.text});
                }
                Mycroft.MycroftController.sendText(qinput.text);
                Mycroft.MycroftController.sendRequest('mycroft.qinput.text', {"inputQuery": qinput.Text})
                qinput.text = "";
            }

            onTextChanged: {
                appletBottomBarComponent.evalAutoLogic();
            }

            AutocompleteBox {
                id: suggestionsBox
                model: completionItems
                width: parent.width
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                filter: qinput.text
                property: "name"
                onItemSelected: complete(item)

                function complete(item) {
                    if (item !== undefined)
                        qinput.text = item.name
                }
            }
        }
    }
}
