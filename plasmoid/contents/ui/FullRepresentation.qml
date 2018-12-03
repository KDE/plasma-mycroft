/*  Copyright 2016 Aditya Mehra <aix.m@outlook.com>
    Copyright 2018 Marco Martin <mart@kde.org>

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
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.private.mycroftplasmoid 1.0 as MycroftPlasmoid
import Mycroft 1.0 as Mycroft

Item {
    id: root
    implicitWidth: Kirigami.Units.gridUnit * 20
    implicitHeight: Kirigami.Units.gridUnit * 32
    property bool cfg_notifications: plasmoid.configuration.notifications

    function pushMessage(text, inbound) {
        conversationModel.append({"text": text,
                                     "inbound": inbound});

        // Limit to 20 items in the histry as ListModel is quite heavy on memory
        if (conversationModel.count > 20) {
            conversationModel.remove(0)
        }

        mainView.flick(0, -500);
    }

    Component.onCompleted: {
        pushMessage(i18n("How can I help you?"), true);
    }
    
    Item {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Kirigami.Units.gridUnit * 4

        ColumnLayout{
            anchors.fill: parent

            TopBarViewComponent {
                id: topBarView
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 2
            }

            PlasmaCore.SvgItem {
                Layout.fillWidth: true
                Layout.preferredHeight: horlineSvg.elementSize("horizontal-line").height

                elementId: "horizontal-line"
                svg: PlasmaCore.Svg {
                    id: horlineSvg;
                    imagePath: "widgets/line"
                }
            }

            PlasmaComponents.TabBar {
                id: tabBar
                visible: true
                Layout.fillWidth: true
                Layout.preferredHeight: Kirigami.Units.gridUnit * 1.5

                PlasmaComponents.TabButton {
                    id: mycroftTab
                    iconSource: "go-home"
                    text: "Conversation"
                }

                PlasmaComponents.TabButton {
                    id: mycroftSkillsTab
                    iconSource: "games-hint"
                    text: "Hints & Tips"
                }

                PlasmaComponents.TabButton {
                    id: mycroftMSMinstTab
                    iconSource: "kmouth-phresebook-new"
                    text: "Skill Browser"
                }
            }

            PlasmaCore.SvgItem {
                Layout.fillWidth: true
                Layout.preferredHeight: horlineSvg.elementSize("horizontal-line").height

                elementId: "horizontal-line"
                svg: PlasmaCore.Svg {
                    id: horlineSvg2;
                    imagePath: "widgets/line"
                }
            }
        }
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomBar.top
        anchors.top: topBar.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing + Kirigami.Units.smallSpacing
        opacity: Mycroft.MycroftController.status == Mycroft.MycroftController.Open
        visible: tabBar.currentTab == mycroftTab;

        Behavior on opacity {
            OpacityAnimator {
                duration: Kirigami.Units.longDuration
                easing.type: Easing.InOutCubic
            }
        }
        
        Mycroft.SkillView {
            id: skillView
            Kirigami.Theme.colorSet: Kirigami.Theme.View
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            onCurrentItemChanged: {
                currentItem.background.visible = false
                inputField.forceActiveFocus();
            }

            Connections {
                id: mycroftConnection

                target: Mycroft.MycroftController

                onFallbackTextRecieved: {
                    pushMessage(data.utterance, true);
                    if (!plasmoid.expanded && cfg_notifications == true) {
                        var post = data.utterance;
                        var title = "Mycroft's Reply:"
                        var notiftext = " " + post;
                        MycroftPlasmoid.Notify.mycroftResponse(title, notiftext);
                    }
                }
            }

            initialItem: Controls.ScrollView {
                Kirigami.Theme.colorSet: Kirigami.Theme.View
                ListView {
                    id: mainView

                    spacing: Kirigami.Units.largeSpacing

                    topMargin: Math.max(0, height - contentHeight - Kirigami.Units.largeSpacing * 3)
                    bottomMargin: Kirigami.Units.largeSpacing

                    //onContentHeightChanged: flick(0, 100);
                    //contentY = contentHeight - height - topMargin + bottomMargin;

                    model: ListModel {
                        id: conversationModel
                    }
                    delegate: ConversationDelegate {}
                }
            }
        }
    }
    
    Item {
        id: bottomBar
        anchors.bottom: root.bottom
        anchors.left: root.left
        anchors.right: root.right
        height: Kirigami.Units.gridUnit * 4

        BottomBarViewComponent {
            id: bottomBarView
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        opacity: Mycroft.MycroftController.status != Mycroft.MycroftController.Open

        Behavior on opacity {
            OpacityAnimator {
                duration: Kirigami.Units.longDuration
                easing.type: Easing.InOutCubic
            }
        }

        Kirigami.Heading {
            Layout.fillWidth: true
            text: i18n("Mycroft not connected")
            wrapMode: Text.WordWrap
        }
        Controls.Button {
            Layout.alignment: Qt.AlignHCenter
            text: i18n("Connect")
            onClicked: {
                Mycroft.MycroftController.start();
            }
        }
    }
    
    ColumnLayout {
        id: mycroftSkillscolumntab
        visible: tabBar.currentTab == mycroftSkillsTab;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomBar.top
        anchors.top: topBar.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing + Kirigami.Units.smallSpacing
        anchors.bottomMargin: Kirigami.Units.smallSpacing
        
        HintsViewComponent {
            id: hintsView
        }
    }
    
    ColumnLayout {
        id: mycroftMsmColumn
        visible: tabBar.currentTab == mycroftMSMinstTab;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomBar.top
        anchors.top: topBar.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing + Kirigami.Units.smallSpacing
        anchors.bottomMargin: Kirigami.Units.smallSpacing
        
        SkillsInstallerComponent{
            id: skillsInstallerView
        }
    }

    Mycroft.StatusIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
        y: skillView.currentItem == skillView.initialItem ? parent.height/2 - height/2 : parent.height - height - Kirigami.Units.largeSpacing
    }
}
