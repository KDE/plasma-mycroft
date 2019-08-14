/* Copyright 2019 Aditya Mehra <aix.m@outlook.com>                            

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

Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: Kirigami.Theme.backgroundColor
    property var modelCreatedObject
    
    Component.onCompleted: {
        createHintModel()
    }

    function createHintModel(){
        var hintList = []
        var defaultFold = '/opt/mycroft/skills'
        var fileToFind = "README.md"
        var getList = Mycroft.FileReader.checkForMeta(defaultFold, fileToFind)
        for(var i=0; i < getList.length; i++){
            var fileParse = Mycroft.FileReader.read(getList[i]+"/"+fileToFind);
            var matchedRegex = getImgSrc(fileParse)
            var matchedExamples = getExamples(fileParse)
            var matchedCategory = getCategory(fileParse)
            if(matchedRegex !== null && matchedRegex.length > 0 && matchedExamples !== null && matchedExamples.length > 0 && matchedCategory !== null && matchedCategory.length > 0) {
                var metaFileObject = {
                    imgSrc: matchedRegex[1],
                    title: matchedRegex[2],
                    category: matchedCategory[1],
                    examples: matchedExamples
                }
                hintList.push(metaFileObject);
            }
        }
        modelCreatedObject = hintList
    }

    function getImgSrc(fileText){
        var re = new RegExp(/<img[^>]*src='([^']*)'.*\/>\s(.*)/g);
        var match = re.exec(fileText);
        return match;
    }

    function getExamples(fileText){
        var re = new RegExp(/Examples \n.*"(.*)"\n\*\s"(.*)"/g);
        var match = re.exec(fileText);
        return match;
    }

    function getCategory(fileText){
        var re = new RegExp(/## Category\n\*\*(.*)\*\*/g);
        var match = re.exec(fileText);
        return match;
    }
    
    Kirigami.CardsListView {
        id: skillslistmodelview
        anchors.fill: parent;
        clip: true;
        model: modelCreatedObject
        delegate: HintsView{}
    }
}
