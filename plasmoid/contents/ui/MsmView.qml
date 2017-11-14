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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import Qt.labs.settings 1.0

Rectangle {
                id: skillcontent
                Layout.fillWidth: true;
                anchors { 
                    left: parent.left;
                    leftMargin: 0.5;
                    right: parent.right 
                    }
                height: units.gridUnit * 4
                border.width: 1        
                border.color: Qt.darker(theme.linkColor, 1.2)
                color: Qt.darker(theme.backgroundColor, 1.2)
                
                function exec(msmparam) {
                    var bscrpt = "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/msm.sh"
                    return launchinstaller.msmapp("bash " + bscrpt + " install " + model.url)
                }
                
                function getSkillInfoLocal() {
                    var customFold = '/opt/mycroft/skills/'
                    var skillPath = customFold + model.name
                    if(PlasmaLa.FileReader.file_exists_local(skillPath)){
                        installLabl.text = "Installed"
                        getskillviamsmRect.color = Qt.lighter(theme.textColor, 1.2)
                        installLabl.color = Qt.darker(theme.backgroundColor, 1.2)
                        skillcontent.border.color = Qt.lighter(theme.textColor, 1.2)
                    }
                }
                
                PlasmaLa.MsmApp{
                    id: launchinstaller
                }
                
                Component.onCompleted: {
                    msmSkillInstallProgBar.visible = false;
                    getSkillInfoLocal();
                }
                
                PlasmaComponents.Label {
                id: skllname
                font.capitalization: Font.AllUppercase
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.5
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.5
                wrapMode: Text.WordWrap
                text: model.name
                    Rectangle {
                        id: sepratrmsm
                        width: parent.width
                        height: 1
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        color: Qt.darker(theme.linkColor, 1.2)
                            }
                        }

                PlasmaComponents.Label {
                id: urlskllable
                anchors.top: skllname.bottom
                anchors.topMargin: units.gridUnit * 0.03
                anchors.left: parent.left
                anchors.leftMargin: units.gridUnit * 0.5
                anchors.right: parent.right
                anchors.rightMargin: units.gridUnit * 0.5
                wrapMode: Text.WordWrap
                color: theme.textColor
                text: model.url
                
                MouseArea{
                    id: gotoGit
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {Qt.openUrlExternally(model.url)}
                    onEntered: {
                        urlskllable.color = Qt.darker(theme.linkColor, 1.2)
                    }
                    onExited: {
                        urlskllable.color = theme.textColor
                        }
                    }
                }

                Rectangle {
                    id: getskillviamsmRect
                    width: parent.width
                    height: units.gridUnit * 1
                    anchors.bottom: parent.bottom
                    color: Qt.darker(theme.linkColor, 1.2)

                    PlasmaComponents.Label{
                       id: installLabl
                       wrapMode: Text.WordWrap
                       anchors.centerIn: parent
                       text: "Install"
                       color: Qt.darker(theme.backgroundColor, 1.2)
                    }

                    PlasmaComponents.ProgressBar {
                        anchors.centerIn: parent
                        width: parent.width / 1.2
                        id: msmSkillInstallProgBar
                        visible: false
                        indeterminate: false
                      }

                    MouseArea  {
                    anchors.fill:  parent
                    hoverEnabled: true
                    onEntered: {
                        switch(installLabl.text){
                            case "Install":
                                getskillviamsmRect.color = Qt.lighter(theme.backgroundColor, 1.2)
                                installLabl.color = Qt.darker(theme.linkColor, 1.2)
                                getskillviamsmRect.border.width = 1        
                                getskillviamsmRect.border.color = Qt.darker(theme.linkColor, 1.2)
                                break
                            case "Installed":
                                getskillviamsmRect.color = Qt.lighter(theme.textColor, 1.2)
                                installLabl.color = Qt.darker(theme.backgroundColor, 1.2)
                                getskillviamsmRect.border.width = 0        
                                getskillviamsmRect.border.color = Qt.darker(theme.backgroundColor, 1.2)
                                skillcontent.border.color = Qt.darker(theme.textColor, 1.2)
                                break
                        }
                    }
                    onExited: {
                        switch(installLabl.text){
                            case "Install":
                                getskillviamsmRect.color = Qt.darker(theme.linkColor, 1.2)
                                installLabl.color = Qt.darker(theme.backgroundColor, 1.2)
                                getskillviamsmRect.border.width = 0
                                break
                            case "Installed":
                                getskillviamsmRect.color = Qt.lighter(theme.textColor, 1.2)
                                installLabl.color = Qt.darker(theme.backgroundColor, 1.2)
                                getskillviamsmRect.border.width = 0
                                getskillviamsmRect.color = Qt.lighter(theme.textColor, 1.2)
                                skillcontent.border.color = Qt.lighter(theme.textColor, 1.2)
                                break
                        }
                    }
                    onClicked: {
                        var msmprogress = exec()
                        var getcurrentprogress = msmprogress.split("\n")
                        if(getcurrentprogress.indexOf("Cloning repository") != -1)
                            {
                             installLabl.visible = false
                             msmSkillInstallProgBar.visible = true;
                             msmSkillInstallProgBar.indeterminate = true;
                            }
                        if(getcurrentprogress.indexOf("Skill installed!") != -1)
                            {
                            msmSkillInstallProgBar.visible = false
                            installLabl.visible = true
                            installLabl.text = "Installed"
                            getSkillInfoLocal()
                            }
                        }
                    }
                }
            }
                    
