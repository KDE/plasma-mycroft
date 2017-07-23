import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import Qt.labs.settings 1.0

Rectangle {
                id: skillcontent
                Layout.fillWidth: true;
                anchors { left: parent.left; right: parent.right }
                height: 60 
                border.width: 0        
                border.color: "lightsteelblue"
                radius: 2
                color: theme.backgroundColor
                
                PlasmaLa.MsmApp{
                    id: launchinstaller
                }
                
                Component.onCompleted: {
                    getSkillInfoLocal()
                    msmSkillInstallProgBar.visible = false;
                }
                
                function getSkillInfoLocal() {
                var customFold = '/opt/mycroft/skills/'
                var skillPath = customFold + model.name +'/__init__.py'
                if(PlasmaLa.FileReader.file_exists_local(skillPath)){
                    //msminstllbtn.visible = false
                    instlabel.color = "Green"
                    instlabel.text = "Installed"
                    }
                else {
                    instlabel.text = "Not Installed"
                    }
                }
                
                function exec(msmparam) {
                    var bscrpt = "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/msm.sh"
                    return launchinstaller.msmapp("bash " + bscrpt + " install " + model.url)
                }
                
                Column {
                id: skillcolumn
                width: parent.width / 80
                
                PlasmaComponents.Label {
                font.capitalization: Font.AllUppercase    
                wrapMode: Text.WordWrap 
                text: model.name
                }
                
                PlasmaComponents.Label {
                font.pointSize: 8    
                wrapMode: Text.WordWrap 
                width: units.gridUnit * 14
                text: model.url
                 }
                }
                
                PlasmaComponents.Label {
                    id: instlabel
                font.pointSize: 8    
                wrapMode: Text.WordWrap 
                anchors.right: msminstllbtn.left
                anchors.rightMargin: 5
                text: ""
                }
                
                PlasmaComponents.ToolButton {
                anchors.right: parent.right
                id: msminstllbtn
                visible: true
                iconSource: "download"
                flat: true
                checked: false
                focus: false
                width: Math.round(units.gridUnit * 2)
                height: width
                
                onClicked: {
                    console.log(model.url)
                    var msmprogress = exec()
                    var getcurrentprogress = msmprogress.split("\n")
                    console.log(getcurrentprogress);
                    if(getcurrentprogress.indexOf("Cloning repository") != -1)
                        {
                         msmSkillInstallProgBar.visible = true;   
                         msmSkillInstallProgBar.indeterminate = true;
                        }
                    if(getcurrentprogress.indexOf("Skill installed!") != -1)
                        {
                        msmSkillInstallProgBar.indeterminate = false;
                        msmSkillInstallProgBar.value = 100;
                        instlabel.color = "Green"
                        instlabel.text = "Installed"
                        }
                    }
                
                }
                
                PlasmaComponents.ProgressBar {
                    anchors.right: parent.right
                    anchors.rightMargin: units.gridUnit * 1
                    anchors.bottom: parent.bottom
                    width: units.gridUnit * 4
                    id: msmSkillInstallProgBar
                    visible: false
                    indeterminate: false
                }
        
                }
                    
