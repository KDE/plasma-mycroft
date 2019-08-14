/*  Copyright 2019 Aditya Mehra <aix.m@outlook.com>
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
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.3

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.5 as Kirigami

Item {
    id: root

    width: parent.width - Kirigami.Units.largeSpacing
    height: delegate.height

    Controls.Control {
        id: delegate

        anchors {
            top: parent.top
            left: model.inbound ? parent.left : undefined
            right: model.inbound ? undefined : parent.right
            margins: Kirigami.Units.smallSpacing
        }

        padding: Kirigami.Units.gridUnit/2

        width: Math.min(implicitWidth, parent.width - Kirigami.Units.smallSpacing*2)

        contentItem: Controls.Label {
            text: model.text
            wrapMode: Text.WordWrap
        }
        background: Rectangle {
            radius: Kirigami.Units.gridUnit/2
            color: Kirigami.Theme.backgroundColor

            Rectangle {
                anchors {
                    left: model.inbound ? parent.left : undefined
                    top: model.inbound ? parent.top : undefined
                    right: model.inbound ? undefined : parent.right
                    bottom: model.inbound ? undefined : parent.bottom
                }
                width: Kirigami.Units.gridUnit
                height: width
                color: Kirigami.Theme.backgroundColor
            }

            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: Kirigami.Units.gridUnit/8
                radius: Kirigami.Units.gridUnit/2
                samples: 32
                color: Qt.rgba(0, 0, 0, 0.5)
            }
        }
    }
}
