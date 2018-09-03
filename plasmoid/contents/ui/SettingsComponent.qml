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
    id: settingsComponent
    anchors.fill: parent
    property alias innerset: appletConfiguration
    property alias dasboardSwitch: dashswitch
    
    PlasmaComponents.TabBar {
        id: settingstabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent. right
        height: units.gridUnit * 2
        tabPosition: Qt.TopEdge;
        
        PlasmaComponents.TabButton {
                id: generalSettingsTab
                text: "General"
        }
        
        PlasmaComponents.TabButton {
            id: dashSettingsTab
            text: "Dash"
            }
        }

    Item {
                    id: settingscontent
                    Layout.fillWidth: true;
                    Layout.fillHeight: true;
                    anchors.top: settingstabBar.bottom
                    anchors.topMargin: units.gridUnit * 0.50
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    visible: settingstabBar.currentTab == generalSettingsTab;

    Flickable {
        id: settingFlick
        anchors.fill: parent;
        contentWidth: mycroftSettingsColumn.width
        contentHeight: units.gridUnit * 22
        clip: true;
        
                PlasmaComponents.Label {
                    id: settingsTabUnits
                    anchors.top: parent.top;
                    anchors.topMargin: 5
                    text: i18n("<i>Your Mycroft Core Installation Path</i>")
                    }
                    
                PlasmaComponents.ButtonColumn {
                    id: radiobuttonColoumn
                    anchors.top: settingsTabUnits.bottom
                    anchors.topMargin: 5
                    
                    PlasmaComponents.RadioButton {
                        id: settingsTabUnitsOpZero
                        exclusiveGroup: installPathGroup
                        text: i18n("Default Path")
                        checked: true
                        
                        onCheckedChanged: {
                            locationUserSelected = true
                            if (settingsTabUnitsOpZero.checked === true && coreinstallstartpath === packagemcorestartcmd) {
                                coreinstallstartpath = defaultmcorestartpath;
                            }
                            else if (settingsTabUnitsOpZero.checked === true && coreinstallstartpath === customlocstartpath) {
                                coreinstallstartpath = defaultmcorestartpath;   
                            }
                            
                            if (settingsTabUnitsOpZero.checked === true && coreinstallstoppath === packagemcorestopcmd) {
                                coreinstallstoppath = defaultmcorestoppath;
                            }
                            
                            else if (settingsTabUnitsOpZero.checked === true && coreinstallstoppath === customlocstoppath) {
                                coreinstallstoppath = defaultmcorestoppath;   
                            }
                        }
                    }
                    
                    PlasmaComponents.RadioButton {
                        id: settingsTabUnitsOpOne
                        exclusiveGroup: installPathGroup
                        text: i18n("Installed Using Mycroft Package")
                        checked: false
                        
                        onCheckedChanged: {
                            
                            if (settingsTabUnitsOpOne.checked === true && coreinstallstartpath === defaultmcorestartpath) {
                                coreinstallstartpath = packagemcorestartcmd;
                            }
                            else if (settingsTabUnitsOpOne.checked === true && coreinstallstartpath === customlocstartpath) {
                                coreinstallstartpath = packagemcorestartcmd;   
                            }
                            
                            if (settingsTabUnitsOpOne.checked === true && coreinstallstoppath === defaultmcorestoppath) {
                                coreinstallstoppath = packagemcorestopcmd;
                            }
                            
                            else if (settingsTabUnitsOpOne.checked === true && coreinstallstoppath === customlocstoppath) {
                                coreinstallstoppath = packagemcorestopcmd;   
                            }
                        }
                    }
                    
                    PlasmaComponents.RadioButton {
                        id: settingsTabUnitsOpTwo
                        exclusiveGroup: installPathGroup
                        text: i18n("Location of Mycroft-Core Directory")
                        checked: false
                        
                        onCheckedChanged: {
                            locationUserSelected = true
                            if (settingsTabUnitsOpTwo.checked === true && coreinstallstartpath === defaultmcorestartpath) {
                                coreinstallstartpath = customlocstartpath;
                            }
                            else if (settingsTabUnitsOpTwo.checked === true && coreinstallstartpath === packagemcorestartcmd) {
                                coreinstallstartpath = customlocstartpath;   
                            }
                            
                            if (settingsTabUnitsOpTwo.checked === true && coreinstallstoppath === defaultmcorestoppath) {
                                coreinstallstoppath = customlocstoppath;
                            }
                            
                            else if (settingsTabUnitsOpTwo.checked === true && coreinstallstoppath === packagemcorestopcmd) {
                                coreinstallstoppath = customlocstoppath;   
                            }
                            
                        }
                    } 
                        }
                    
                    PlasmaComponents.TextField {
                        id: settingsTabUnitsOpThree
                        width: settingscontent.width / 1.1
                        anchors.top: radiobuttonColoumn.bottom
                        anchors.topMargin: 10
                        placeholderText: i18n("<custom location>/mycroft-core/")
                        
                        onTextChanged: {
                            var cstloc = settingsTabUnitsOpThree.text
                            customloc = cstloc
                        }
                    }
                    
                PlasmaComponents.Button {
                    id: acceptcustomPath
                    anchors.left: settingsTabUnitsOpThree.right
                    anchors.verticalCenter: settingsTabUnitsOpThree.verticalCenter
                    anchors.right: parent.right
                    iconSource: "checkbox"
                    
                    onClicked: {
                        var cstlocl = customloc
                        var ctstart = cstlocl + "start-mycroft.sh all" 
                        var ctstop = cstlocl + "stop-mycroft.sh" 
                            startsrvcustom.text = ctstart
                            stopsrvcustom.text = ctstop
                            console.log(startsrvcustom.text)                    
                        }
                    } 
                    
                PlasmaComponents.TextField {
                        id: settingsTabUnitsWSpath
                        width: settingscontent.width / 1.1
                        anchors.top: settingsTabUnitsOpThree.bottom
                        anchors.topMargin: 10
                        placeholderText: i18n("ws://0.0.0.0:8181/core")
                        text: i18n("ws://0.0.0.0:8181/core")
                    }
                    
                PlasmaComponents.Button {
                    id: acceptcustomWSPath
                    anchors.left: settingsTabUnitsWSpath.right
                    anchors.verticalCenter: settingsTabUnitsWSpath.verticalCenter
                    anchors.right: parent.right
                    iconSource: "checkbox"
                    
                    onClicked: { 
                        innerset.wsurl = settingsTabUnitsWSpath.text
                        }
                    }
                    
                                
                PlasmaComponents.TextField {
                        id: settingsTabUnitsIRCmd
                        width: settingscontent.width / 1.1
                        anchors.top: settingsTabUnitsWSpath.bottom
                        anchors.topMargin: 10
                        placeholderText: i18n("Your Custom Image Recognition Skill Voc Keywords")
                        text: i18n("search image url")
                    }
                    
                PlasmaComponents.Button {
                    id: acceptcustomIRCmd
                    anchors.left: settingsTabUnitsIRCmd.right
                    anchors.verticalCenter: settingsTabUnitsIRCmd.verticalCenter
                    anchors.right: parent.right
                    iconSource: "checkbox"
                }    
                    
                    
                PlasmaComponents.TextField {
                        id: settingsTabUnitsOCRCmd
                        width: settingscontent.width / 1.1
                        anchors.top: settingsTabUnitsIRCmd.bottom
                        anchors.topMargin: 10
                        placeholderText: i18n("Your Custom Image OCR Skill Voc Keywords")
                        text: i18n("ocr image url")
                    }
                    
                PlasmaComponents.Button {
                    id: acceptcustomOCRCmd
                    anchors.left: settingsTabUnitsOCRCmd.right
                    anchors.verticalCenter: settingsTabUnitsOCRCmd.verticalCenter
                    anchors.right: parent.right
                    iconSource: "checkbox"
                } 
                    
                    
                PlasmaComponents.Switch {
                        id: notificationswitch
                        anchors.top: settingsTabUnitsOCRCmd.bottom
                        anchors.topMargin: 10
                        text: i18n("Enable Notifications")
                        checked: true
                }
                    
                    
                PlasmaComponents.Switch {
                        id: wolframfallbackswitch
                        anchors.top: notificationswitch.bottom
                        anchors.topMargin: 10
                        text: i18n("Enable Fallback To Wolfram Alpha Web-Search")
                        checked: true
                    }
                
                PlasmaComponents.Label {
                    id: wolframkeylabel
                    text: i18n("Wolfram Alpha API:")
                    anchors.top: wolframfallbackswitch.bottom
                    anchors.topMargin: 10
                }
                
                PlasmaComponents.TextField {
                        id: wolframapikeyfld
                        anchors.right: parent.right
                        anchors.rightMargin: units.gridUnit * 0.25
                        anchors.left: wolframkeylabel.right
                        anchors.leftMargin: units.gridUnit * 0.25
                        anchors.verticalCenter: wolframkeylabel.verticalCenter
                        text: i18n("RJVUY3-T6YLWQVXRR")
                }
                
                PlasmaExtras.Paragraph {
                        id: settingsTabTF2
                        anchors.top: wolframapikeyfld.bottom
                        anchors.topMargin: 15
                        text: i18n("<i>Please Note: Default path is set to /home/$USER/mycroft-core/. Change the above settings to match your installation</i>")
                    }
                    
                PlasmaComponents.Label {
                    id: startsrvcustom
                    visible: false
                }
                
                PlasmaComponents.Label {
                    id: stopsrvcustom
                    visible: false
                }   
            }
        }
        
    Item {
        id: dashsettingscontent
        Layout.fillWidth: true;
        Layout.fillHeight: true;
        anchors.top: settingstabBar.bottom
        anchors.topMargin: units.gridUnit * 0.50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: settingstabBar.currentTab == dashSettingsTab;

    Flickable {
        id: dashsettingFlick
        anchors.fill: parent;
        contentWidth: mycroftSettingsColumn.width
        contentHeight: units.gridUnit * 22
        clip: true;

        Column {
        spacing: 6
        
        PlasmaComponents.Switch {
            id: dashswitch
            text: i18n("Enable / Disable Dashboard")
            checked: true
            
            onCheckedChanged:   {
                if(dashswitch.checked){
                    tabBar.currentTab = mycroftTab
                    disclaimbox.visible = false
                    Dash.showDash("setVisible")
                }
                else if(!dashswitch.checked){
                    mycroftConversationComponent.conversationModel.clear()
                    if(!socket.active){
                        disclaimbox.visible = true   
                    }
                }
            }
        }

        PlasmaComponents.Label {
                id: dashSettingsLabel1
                text: i18n("Card Settings:")
                font.bold: true;
            }
            
        PlasmaComponents.Switch {
            id: disclaimercardswitch
            text: i18n("Enable / Disable Disclaimer Card")
            checked: true
        }
            
        PlasmaComponents.Switch {
            id: newscardswitch
            text: i18n("Enable / Disable News Card")
            checked: true
        }
        
        PlasmaComponents.Switch {
            id: cryptocardswitch
            text: i18n("Enable / Disable Cryptocurrency Card")
            checked: false
        }
        
        Row {
        spacing: 2
            PlasmaComponents.Label{
                id: cryptoCurrencySelected
                text: "Selected CryptoCurrency:"
            }
            PlasmaComponents3.ComboBox {
                id: cryptoSelectedBox
                textRole: "cryptoname"
                displayText: currentText
                model: CrypCurModel{}
                property string cryptInfo: cryptoSelectedBox.model.get(currentIndex).value
            }
        }
        
        PlasmaComponents.Label{
            id: localCurrencySelected
            text: "Display Currencies:"
        }
        
        PlasmaComponents3.ComboBox {
            id: cryptoSelectCur1
            textRole: "currencyname"
            displayText: currentText
            model: CurModel{}
            property string cur1Info: cryptoSelectCur1.model.get(currentIndex).value
        }
        
        PlasmaComponents3.ComboBox {
            id: cryptoSelectCur2
            textRole: "currencyname"
            displayText: currentText
            model: CurModel{}
            property string cur2Info: cryptoSelectCur2.model.get(currentIndex).value
        }
        
        PlasmaComponents3.ComboBox {
            id: cryptoSelectCur3
            textRole: "currencyname"
            displayText: currentText
            model: CurModel{}
            property string cur3Info: cryptoSelectCur3.model.get(currentIndex).value
        }
        
        Row {
        spacing: 2
           PlasmaComponents.Label { 
                id: newsApiKeyLabelFld
                text: "NewsApi App_Key:"
            }
            PlasmaComponents.TextField{
                id: newsApiKeyTextFld
                width: units.gridUnit * 12
                text: "a1091945307b434493258f3dd6f36698"
            }
        }
                    
        PlasmaComponents.Switch {
            id: weathercardswitch
            text: i18n("Enable / Disable Weather Card")
            checked: true
        }
        
        Row {
        spacing: 2
           PlasmaComponents.Label { 
                id: owmApiKeyLabelFld
                text: "Open Weather Map App_ID:"
                }
            PlasmaComponents.TextField{
                id: owmApiKeyTextFld
                width: units.gridUnit * 12
                text: "7af5277aee7a659fc98322c4517d3df7"
                }
        }
            
        Row{
        id: weatherCardMetricsRowList
        spacing: 2
        
           PlasmaComponents.Button { 
                id: owmApiKeyMetricCel
                text: i18n("Celcius")
                onClicked: {
                    weatherMetric = "metric"
                    Dash.updateCardData()
                }
            }
            PlasmaComponents.Button{
                id: owmApiKeyMetricFar
                text: i18n("Fahrenheit")
                onClicked: {
                    weatherMetric = "imperial"
                    Dash.updateCardData()
                }
            }
        }
                    
                }
            }
        }
        
        Settings {
            id: appletConfiguration
            property alias wsurl: settingsTabUnitsWSpath.text
            property alias customrecog: settingsTabUnitsIRCmd.text
            property alias customocrrecog: settingsTabUnitsOCRCmd.text
            property alias customsetuppath: settingsTabUnitsOpThree.text
            property alias notifybool: notificationswitch.checked
            property alias wolffallbackbool: wolframfallbackswitch.checked
            property alias wolframKey: wolframapikeyfld.text
            property alias radiobt1: settingsTabUnitsOpOne.checked
            property alias radiobt2: settingsTabUnitsOpTwo.checked
            property alias radiobt3: settingsTabUnitsOpZero.checked
            property alias dashboardSetting: dashswitch.checked
            property alias disclaimerCardSetting: disclaimercardswitch.checked
            property alias newsCardSetting: newscardswitch.checked
            property alias newsCardAPIKey: newsApiKeyTextFld.text
            property alias weatherCardSetting: weathercardswitch.checked
            property alias weatherCardAPIKey: owmApiKeyTextFld.text
            property alias weatherMetricC: owmApiKeyMetricCel.checked
            property alias weatherMetricF: owmApiKeyMetricFar.checked
//            property alias versionIndex: versionBox.currentIndex
//            property alias versionUrl: versionBox.versionInfo
            property alias cryptoCardSetting: cryptocardswitch.checked
            property alias selectedCryptoidx: cryptoSelectedBox.currentIndex
            property alias selectedCrypto: cryptoSelectedBox.cryptInfo
            property alias selectedCur1idx: cryptoSelectCur1.currentIndex
            property alias selectedCur1: cryptoSelectCur1.cur1Info
            property alias selectedCur2idx: cryptoSelectCur2.currentIndex
            property alias selectedCur2: cryptoSelectCur2.cur2Info
            property alias selectedCur3idx: cryptoSelectCur3.currentIndex
            property alias selectedCur3: cryptoSelectCur3.cur3Info
        }
}
