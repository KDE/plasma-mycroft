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
import "Applet.js" as Applet
import "Autocomplete.js" as Autocomplete
import "Conversation.js" as Conversation
import "Dashboard.js" as Dash

Item {
    id: skillsInstallerComponent
    anchors.fill:parent
    property alias skillInstallerConfig: skillInstallerSettings
    
    function refreshAllSkills(){
        getSkills();
        msmskillsModel.reload();
    }
    
    function getAllSkills(){
        if(skillList.length <= 0){
            getSkills();
        }
        return skillList;
    }
    function getSkillByName(skillName){
        var tempSN=[];
        for(var i = 0; i <skillList.length;i++){
            var sList = skillList[i].name;
            if(sList.indexOf(skillName) !== -1){
                tempSN.push(skillList[i]);
            }
        }
        return tempSN;
    }
    
    function getSkills() {
      var doc = new XMLHttpRequest()
      var url = skillInstallerConfig.versionUrl
      doc.open("GET", url, true);
      doc.send();

      doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE) {
          var path, list;
          var tempRes = doc.responseText
          var moduleList = tempRes.split("[");
          skillList.length = 0
          for (var i = 1; i < moduleList.length; i++) {
            path = moduleList[i].substring(moduleList[i].indexOf("= ") + 2, moduleList[i].indexOf("url")).replace(/^\s+|\s+$/g, '');
            url = moduleList[i].substring(moduleList[i].search("url =") + 6).replace(/^\s+|\s+$/g, '');
            skillList[i-1] = {"name": path, "url": url};
            msmskillsModel.reload();
          }
        }
      }
    }

        Item { 
                id: msmtabtopbar
                width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                height: units.gridUnit * 2
                
        PlasmaComponents3.ComboBox {
            id: versionBox
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width / 3.5
            textRole: "key"
            displayText: "Version: " + currentText
            property string versionInfo: versionItem.get(currentIndex).value
            
            model: ListModel {
                id: versionItem
                ListElement { key: "18.02"; value: "https://raw.githubusercontent.com/MycroftAI/mycroft-skills/18.02/.gitmodules" }
                ListElement { key: "18.0x"; value: "https://raw.githubusercontent.com/MycroftAI/mycroft-skills/master/.gitmodules" }
            }
            onActivated: {
                msmskillsModel.clear();
                getSkills();
            }
        }
        
        PlasmaComponents.TextField {
                id: msmsearchfld
                anchors.left: versionBox.right
                anchors.leftMargin: units.gridUnit * 0.50
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: getskillsbx.left
                placeholderText: i18n("Search Skills")
                clearButtonShown: true
                
                onTextChanged: {
                if(text.length > 0 ) {
                    msmskillsModel.applyFilter(text.toLowerCase());
                } else {
                    msmskillsModel.reload();
                }
            }
        }    
            
            PlasmaComponents.ToolButton {
                    id: getskillsbx
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    iconSource: "view-refresh"
                    tooltip: i18n("Refresh List")
                    flat: true
                    width: Math.round(units.gridUnit * 2)
                    height: width
                    z: 102
        
                    onClicked: {
                            msmskillsModel.clear();
                            refreshAllSkills();
                        }    
                    }
            }
            
            ListModel {
                id: msmskillsModel
                
                Component.onCompleted: {
                    reload();
                }
                
                function reload() {
                    var skList = getAllSkills();
                    msmskillsModel.clear();
                    for( var i=0; i < skList.length ; ++i ) {
                        msmskillsModel.append(skList[i]);
                    }
                }

                function applyFilter(skName) {
                    var skList = getSkillByName(skName);
                    msmskillsModel.clear();
                    for( var i=0; i < skList.length ; ++i ) {
                        msmskillsModel.append(skList[i]);
                    }
                }
            }
            
            ListView {
                id: msmlistView    
                anchors.top: msmtabtopbar.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                model: msmskillsModel
                delegate: MsmView{}
                spacing: 4
                focus: false
                interactive: true
                clip: true;
                }
                
    Settings {
        id: skillInstallerSettings
        property alias versionIndex: versionBox.currentIndex
        property alias versionUrl: versionBox.versionInfo
    }
}
