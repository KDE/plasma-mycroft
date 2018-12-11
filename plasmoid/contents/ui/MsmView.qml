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

Kirigami.AbstractCard {
    id: skillInstallerDelegate
    
    contentItem: Item {
        implicitWidth: delegateLayout.implicitWidth;
        implicitHeight: delegateLayout.implicitHeight;
    
        ColumnLayout{
            id: delegateLayout
            anchors {
                left: parent.left;
                top: parent.top;
                right: parent.right;
            }
            
            Kirigami.Heading {
                id: skillName
                Layout.fillWidth: true;
                wrapMode: Text.WordWrap;
                font.bold: true;
                text: qsTr(model.name);
                level: 3;
                color: Kirigami.Theme.textColor;
            }
            
            RowLayout {
                id: skillInfoRow
                spacing: Kirigami.Units.largeSpacing
                Layout.fillWidth: true
            
                PlasmaCore.IconItem {
                    id: innerskImg
                    source: "download";
                    Layout.preferredWidth: innerskImg.width
                    Layout.preferredHeight: innerskImg.height
                    width: Kirigami.Units.gridUnit * 2
                    height: Kirigami.Units.gridUnit * 2
                }
                
                Label {
                    id: skillURL
                    wrapMode: Text.WordWrap
                    color: theme.textColor
                    text: "View Repository"
                    Layout.fillWidth: true;

                    MouseArea{
                        id: gotoGit
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {Qt.openUrlExternally(model.url)}
                        onEntered: {
                            skillURL.color = Qt.darker(theme.linkColor, 1.2)
                        }
                        onExited: {
                            skillURL.color = theme.textColor
                        }
                    }
                }
            }
        
            PlasmaComponents.Button{
                id: actionItem
                text: "Install"
                Layout.fillWidth: true
                onClicked:{
                    switch(actionItem.text){
                    case "Install":
                        Mycroft.MycroftController.sendText("install" + skillName)
                        break
                    case "Uninstall":
                        var msmprogress = execUninstall()
                        break
                    }
                }
            }
        }
    }
}

