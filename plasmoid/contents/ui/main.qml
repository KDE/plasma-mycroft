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
import Qt.WebSockets 1.0
import Qt.labs.settings 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.private.mycroftplasmoid 1.0 as PlasmaLa
import QtWebKit 3.0
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: main
    Layout.fillWidth: true;
    Plasmoid.toolTipMainText: i18n("Mycroft")
    Plasmoid.switchWidth: units.gridUnit * 15
    Plasmoid.switchHeight: units.gridUnit * 15
    Layout.minimumHeight: units.gridUnit * 24
    Layout.minimumWidth: units.gridUnit * 26
    
    Component.onCompleted: {
        mycroftStatusCheckSocket.active = true
        detectInstallType();
        refreshAllSkills();
    }
    
    property var skillList: []
    property alias cbwidth: rectangle2.width
    property alias cbheight: rectangle2.height
    property var dwrpaddedwidth: main.width + units.gridUnit * 1
    property var cbdrawercontentheight: parent.height + units.gridUnit * 0.5 - rectanglebottombar.height
    property string defaultmcorestartpath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/startservice.sh"
    property string defaultmcorestoppath: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/stopservice.sh"
    property string packagemcorestartcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstartservice.sh"
    property string packagemcorestopcmd: "/usr/share/plasma/plasmoids/org.kde.plasma.mycroftplasmoid/contents/code/pkgstopservice.sh"
    property string customlocstartpath: startsrvcustom.text
    property string customlocstoppath: stopsrvcustom.text
    property string customloc: " "
    property string coreinstallstartpath: defaultmcorestartpath
    property string coreinstallstoppath: defaultmcorestoppath
    property variant searchIndex: []
    property variant results: []
    property var smintent
    property var dataContent
    property alias autoCompModel: completionItems
    property alias textInput: qinput
    property alias plcLmodel: placesListModel
    property alias dashLmodel: dashListModel
    property alias recipeLmodel: recipesListModel
    property alias recipeReadLmodel: recipeReadListModel
    property alias stackLmodel: stackexListModel
    property alias bookLmodel: bookListModel
    property alias wikiLmodel: wikiListModel
    property alias yelpLmodel: yelpListModel
    property bool intentfailure: false
    property bool locationUserSelected: false
    property bool connectCtx: false
    property bool micIsMuted
    property var geoLat
    property var geoLong
    property var globalcountrycode
    property var weatherMetric: "metric"
    
    Connections {
        target: plasmoid
        onExpandedChanged: {
            if (plasmoid.expanded) {
                checkDashStatus()
            }
        }
    }
    
    Connections {
        target: PlasmaLa.Notify
        onNotificationStopSpeech: {
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = ["stop"];
            socket.sendTextMessage(JSON.stringify(socketmessage));
        }
        onNotificationShowResponse: {
           plasmoid.expanded = !plasmoid.expanded
           tabBar.currentTab = mycroftTab
        }
    }
    
    Connections {
        target: main2
        ignoreUnknownSignals: true
        
        onSendShowMycroft: {
            plasmoid.expanded = !plasmoid.expanded
            tabBar.currentTab = mycroftTab
        }
        onSendShowSkills: {
            tabBar.currentTab = mycroftSkillsTab
            if(plasmoid.expanded = !plasmoid.expanded){
                plasmoid.expanded
            }
        }
        onInstallList: {
            tabBar.currentTab = mycroftMSMinstTab
            if(plasmoid.expanded = !plasmoid.expanded){
                plasmoid.expanded
            }
        }
    }
    
    function detectInstallType(){
        if(locationUserSelected == false && PlasmaLa.FileReader.file_exists_local("/usr/bin/mycroft-messagebus")){
            settingsTabUnitsOpOne.checked = true
            coreinstallstartpath = packagemcorestartcmd
            coreinstallstoppath = packagemcorestopcmd
        }
    }
    
    function checkDashStatus(){
        if(dashListModel.count == 0){
            checkConnectionStatus()
        }
    }
    
    function checkConnectionStatus(){
        var isConnected = PlasmaLa.ConnectionCheck.checkConnection()
        if(!isConnected){
               if(!connectCtx){
               var conError = i18n("I am not connected to the internet, Please check your network connection")
               convoLmodel.append({"itemType": "NonVisual", "InputQuery": conError});
               connectCtx = true
               }
            }
        else {
            geoDataSource.connectedSources = ["location"]
            }
    }
    
    function toggleInputMethod(selection){
        switch(selection){
        case "KeyboardSetActive":
            qinput.visible = true
            suggestionbottombox.visible = true
            customMicIndicator.visible = false
            keybindic.color = "green"
            break
        case "KeyboardSetDisable":
            qinput.visible = false
            suggestionbottombox.visible = false
            customMicIndicator.visible = true
            keybindic.color = theme.textColor
            break
        }
   }
    
    function retryConn(){
        socket.active = true
        if (socket.active = false){
               convoLmodel.append({"itemType": "NonVisual", "InputQuery": socket.errorString})
        }
    }
    
    function filterSpeak(msg){
        convoLmodel.append({
            "itemType": "NonVisual",
            "InputQuery": msg
        })
           inputlistView.positionViewAtEnd();
    }
    
    function filterincoming(intent, metadata) {
        var intentVisualArray = ['CurrentWeatherIntent'];
        var itemType
        var filterintentname = intent.split(':');
        var intentname = filterintentname[1];

        if (intentVisualArray.indexOf(intentname) !== -1) {
                switch (intentname){
                case "CurrentWeatherIntent":
                    itemType = "CurrentWeather"
                    break;
                }
              convoLmodel.append({"itemType": itemType, "itemData": metadata})
                }

        else {
            convoLmodel.append({"itemType": "WebViewType", "InputQuery": metadata.url})
        }
    }
    
    function filtervisualObj(metadata){
                convoLmodel.append({"itemType": "LoaderType", "InputQuery": metadata.url})
                inputlistView.positionViewAtEnd();
          }
          
    function filterplacesObj(metadata){
        var filteredData = JSON.parse(metadata.data);
        var locallat = JSON.parse(metadata.locallat);
        var locallong = JSON.parse(metadata.locallong);
        var hereappid = metadata.appid
        var hereappcode = metadata.appcode;
        convoLmodel.clear()
        placesListModel.clear()
        for (var i = 0; i < filteredData.results.items.length; i++){
            var itemsInPlaces = JSON.stringify(filteredData.results.items[i])
            var fltritemsinPlc = JSON.parse(itemsInPlaces)
            var fltrtags = getTags(filteredData.results.items[i].tags)
            placesListModel.insert(i, {placeposition: JSON.stringify(fltritemsinPlc.position), placetitle: JSON.stringify(fltritemsinPlc.title), placedistance: JSON.stringify(fltritemsinPlc.distance), placeloc: JSON.stringify(fltritemsinPlc.vicinity), placeicon: JSON.stringify(fltritemsinPlc.icon), placetags: fltrtags, placelocallat: locallat, placelocallong: locallong, placeappid: hereappid, placeappcode: hereappcode})
        }
        convoLmodel.append({"itemType": "PlacesType", "InputQuery": ""});
    }

    function getTags(fltrTags){
        if(fltrTags){
            var tags = '';
            for (var i = 0; i < fltrTags.length; i++){
                if(tags)
                    tags += ', ' + fltrTags[i].title;
                else
                    tags += fltrTags[i].title;
            }
            return tags;
        }
        return '';
    }
    
    function filterRecipeObj(metadata){
        var filteredData = JSON.parse(metadata.data);
        convoLmodel.clear()
        recipeLmodel.clear()
        for (var i = 0; i < filteredData.hits.length; i++){
            var itemsInRecipes = filteredData.hits[i].recipe
            var itemsReadRecipe = itemsInRecipes.ingredientLines.join(",")
            var itemsReadRecipeHealthTags = itemsInRecipes.healthLabels[0]
            var itemsReadRecipeDietType = itemsInRecipes.dietLabels.join(",")
            var itemsReadRecipeCalories = Math.round(itemsInRecipes.calories)
            if(itemsReadRecipeDietType == ""){
                itemsReadRecipeDietType = "Normal"
            }
            recipeLmodel.insert(i, {recipeLabel: itemsInRecipes.label, recipeSource: itemsInRecipes.source, recipeImageUrl: itemsInRecipes.image, recipeCalories: itemsReadRecipeCalories, recipeIngredientLines: itemsReadRecipe, recipeDiet: itemsReadRecipeDietType, recipeHealthTags: itemsReadRecipeHealthTags})
        }
        convoLmodel.append({"itemType": "RecipeType", "InputQuery": ""})
    }
    
    function filterBalooObj(metadata){
        var BalooObj = metadata;
        var baloosearchTerm = metadata.searchType
        convoLmodel.clear()
        for (var i = 0; i < BalooObj.data.length; i++){
            if(baloosearchTerm == "type:audio"){
                convoLmodel.append({"itemType": "AudioFileType", "InputQuery": metadata.data[i]})   
            }
            if(baloosearchTerm == "type:video"){
                convoLmodel.append({"itemType": "VideoFileType", "InputQuery": metadata.data[i]})   
            }
            if(baloosearchTerm == "type:document" || baloosearchTerm == "type:spreadsheet" || baloosearchTerm == "type:presentation" || baloosearchTerm == "type:archive" ){
                convoLmodel.append({"itemType": "DocumentFileType", "InputQuery": metadata.data[i]})   
            }
        }
    }
    
    function filterstackObj(metadata){
        var filterStackMeta = JSON.parse(metadata.data)
        convoLmodel.clear()
        stackexListModel.clear()
        for (var i = 0; i < filterStackMeta.items.length; i++){
            stackexListModel.insert(i, {sQuestion: filterStackMeta.items[i].title, sLink: filterStackMeta.items[i].link, sAuthor: filterStackMeta.items[i].owner.display_name, sIsAnswered: filterStackMeta.items[i].is_answered, sAnswerCount: filterStackMeta.items[i].answer_count})
        }
        convoLmodel.append({"itemType": "StackObjType", "InputQuery": ""})
        inputlistView.positionViewAtEnd();
    }
    
    function filterbookObj(metadata){
        var filterBookMeta = JSON.parse(metadata.data)
        bookListModel.clear()
        bookListModel.append({bookcover: filterBookMeta.bkcover, bookurl: filterBookMeta.bkurl, bookstatus: filterBookMeta.bkstatus, booktitle: filterBookMeta.bktitle, bookauthor: filterBookMeta.bkauthor, bookdate: filterBookMeta.bkyear, bookpublisher: filterBookMeta.bkpublisher})
        convoLmodel.append({"itemType": "BookType", "InputQuery": ""})
        inputlistView.positionViewAtEnd();
    }
    
    function filterwikiObj(metadata){
        var wikiSummary = JSON.stringify(metadata.data.summary)
        var wikiImage = JSON.stringify(metadata.data.image)
        wikiSummary = wikiSummary.replace(/['"]+/g, '')
        wikiImage = wikiImage.replace(/['"]+/g, '')
        convoLmodel.clear()
        wikiListModel.clear()
        wikiListModel.append({summary: wikiSummary, image: wikiImage})
        convoLmodel.append({"itemType": "WikiType", "InputQuery": ""})
        inputlistView.positionViewAtEnd();
    }
    
    function filterwikiMoreObj(metadata){
        var wikiSummaryMore = JSON.stringify(metadata.data.summarymore)
        var wikiImageMore = JSON.stringify(metadata.data.imagemore)
        convoLmodel.clear()
        wikiListModel.clear()
        wikiSummaryMore = wikiSummaryMore.replace(/['"]+/g, '')
        wikiImageMore = wikiImageMore.replace(/['"]+/g, '')
        wikiListModel.append({summary: wikiSummaryMore, image: wikiImageMore})
        convoLmodel.append({"itemType": "WikiType", "InputQuery": ""})
    }
    
    function filteryelpObj(metadata){
        var filtermetayelp = metadata
        yelpListModel.clear()
        yelpListModel.append({'restaurant': filtermetayelp.data.restaurant, 'phone': filtermetayelp.data.phone, 'location': filtermetayelp.data.location, 'status': filtermetayelp.data.status, 'url': filtermetayelp.data.url, 'image_url': filtermetayelp.data.image_url, 'rating': filtermetayelp.data.rating})
        convoLmodel.append({"itemType": "YelpType", "InputQuery": ""})
    }

    function isBottomEdge() {
        return plasmoid.location == PlasmaCore.Types.BottomEdge;
    }
    
    function clearList() {
            inputlistView.clear()
        }
    
    function checkMicrophoneState(){
            var socketmessage = {};
            socketmessage.type = "mycroft.mic.get_status";
            socketmessage.data = {};
            socket.sendTextMessage(JSON.stringify(socketmessage));
    }

    function muteMicrophone() {
            var socketmessage = {};
            socketmessage.type = "mycroft.mic.mute";
            socketmessage.data = {};
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinputmicbx.iconSource = "mic-off"
        }
    
    function unmuteMicrophone(){
            var socketmessage = {};
            socketmessage.type = "mycroft.mic.unmute";
            socketmessage.data = {};
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinputmicbx.iconSource = "mic-on"
    }
    
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
      var url = innerset.versionUrl
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
    
    function getFileExtenion(filePath){
           var ext = filePath.split('.').pop();
           return ext;
    }

    function validateFileExtension(filePath) {
                  var ext = filePath.split('.').pop();
                  return ext === "jpg" || ext === "png" || ext === "jpeg" || ext === 'mp3' || ext === 'wav' || ext === 'mp4'
    }
        
    function readFile(filename) {
        if (PlasmaLa.FileReader.file_exists_local(filename)) {
            try {
                var content = PlasmaLa.FileReader.read(filename).toString("utf-8");
                return content;
            } catch (e) {
                return 0;
            }
        } else {
            return 0;
        }
    }
    
    function playwaitanim(recoginit){
       switch(recoginit){
       case "recognizer_loop:record_begin":
               drawer.open()
               waitanimoutter.aniRunWorking()
               break
           case "recognizer_loop:wakeword":
                waitanimoutter.aniRunHappy()
                break
           case "intent_failure":
                waitanimoutter.aniRunError()
                intentfailure = true
                break
           case "recognizer_loop:audio_output_start":
               if (intentfailure === false){
                   drawer.close()
               }
               else {
                delay(1500, function() {
                        drawer.close()
                        intentfailure = false;
                    }) 
                }
               break
           case "mycroft.skill.handler.complete":
               if (intentfailure === false){
                   drawer.close()
               }
               else {
                delay(1500, function() {
                        drawer.close()
                        intentfailure = false;
                    }) 
                }
               break
       }
   }
   
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
    
    function fetchDashNews(){
        var doc = new XMLHttpRequest()
        var url = 'https://newsapi.org/v2/top-headlines?' +
                'country=' + globalcountrycode + '&' +
                'apiKey=' + newsApiKeyTextFld.text;
        doc.open("GET", url, true);
        doc.send();

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                var req = doc.responseText;
                var checkNewsItem = JSON.parse(req)
                if (checkNewsItem.totalResults == 0){
                    globalcountrycode = "us"
                    fetchDashNews()
                }
                else {
                dashLmodel.append({"iType": "DashNews", "iObj": req})
                }
            }
        }
    }
    
    function fetchDashWeather(){
        var doc = new XMLHttpRequest()
        var url = 'https://api.openweathermap.org/data/2.5/weather?' +
        'lat=' + geoLat + '&lon=' + geoLong + '&units=' + weatherMetric +
        '&APPID=' + owmApiKeyTextFld.text;

            doc.open("GET", url, true);
            doc.send();

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                var req = doc.responseText;
                dashLmodel.append({"iType": "DashWeather", "iObj": req})
            }
        }   
    }
    
    function fetchDashCryptoCardData(){
        var doc = new XMLHttpRequest
        var url = "https://min-api.cryptocompare.com/data/price?fsym=" + innerset.selectedCrypto + "&tsyms=" + innerset.selectedCur1 + "," + innerset.selectedCur2 + "," + innerset.selectedCur3
        doc.open("Get", url, true);
        doc.send();
        
         doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                 var req = doc.responseText;
                 dashLmodel.append({"iType": "DashCryptoPrice", "iObj": req})
            }
        }
    }
    
    function updateCardData(){
        tabBar.currentTab = mycroftTab
        convoLmodel.clear()
        showDash("setVisible")
    }
    
    function setDisclaimer(){
        dashLmodel.append({"iType": "Disclaimer", "iObj": "none"})
    }
    
    function globalDashRun(){
            if(dashswitch.checked == true){
                if(disclaimercardswitch.checked == true){
                 setDisclaimer()   
                }
                if(newscardswitch.checked == true){
                 fetchDashNews()
                }
                if(weathercardswitch.checked == true){
                 fetchDashWeather()
                }
                if(cryptocardswitch.checked == true){
                 fetchDashCryptoCardData()
                }
                    convoLmodel.append({"itemType": "DashboardType", "InputQuery": ""})
            }
            else {
                convoLmodel.clear()
                if(mycroftStatusCheckSocket._socketIsAlreadyActive == true){
                    disclaimbox.visible = false
                }
                else {
                    disclaimbox.visible = true
                }
            }
        }
        
    function showDash(dashState){
        switch(dashState){
            case "setVisible":
                dashLmodel.clear()
                globalDashRun()
                break
            case "setHide":
                dashLmodel.clear()
                convoLmodel.clear()
                break
        }
    }
    
    function getFallBackResult(failedQuery){
      var url = "http://api.wolframalpha.com/v1/simple?appid=" + innerset.wolframKey + "&i=" + failedQuery + "&width=1024&fontsize=32"
      convoLmodel.append({"itemType": "FallBackType", "InputQuery": url})
    }
    
PlasmaCore.DataSource {
        id: geoDataSource
        dataEngine: "geolocation"
    
        onSourceAdded: {
            connectSource(source)
        }
        
        onNewData: {
            convoLmodel.clear()
            if (sourceName == "location"){
            geoLat = data.latitude
            geoLong = data.longitude
            var globalcountry = data.country
            globalcountrycode = globalcountry.substring(0, 2)
            showDash("setVisible")
                }
            }
        }

ListModel {
         id: dashListModel
    }

ListModel {
        id: placesListModel
    }
    
ListModel{
        id: recipesListModel
    }

ListModel {
        id: recipeReadListModel
    }
    
ListModel {
        id: stackexListModel
    }

ListModel {
        id: bookListModel
    }

ListModel {
        id: wikiListModel
    }
ListModel {
        id: yelpListModel
    }
    
Timer {
           id: timer
    }

       function delay(delayTime, cb) {
               timer.interval = delayTime;
               timer.repeat = false;
               timer.triggered.connect(cb);
               timer.start();
}
    
Item {
 id: topBar
 Layout.fillWidth: true
 height: units.gridUnit * 2
 z: 101
 anchors {
    top: main.top
    topMargin: -1
    left: main.left
    leftMargin: -1
    right: main.right
    rightMargin: -1
    }
    
        
Item {
    id: topBarBGrect
    anchors.fill: parent
    z: 101
         
    Image {
            id: barAnim
            anchors.left: parent.left
            anchors.leftMargin: units.gridUnit * 0.1
            anchors.verticalCenter: parent.verticalCenter
            source: "../images/mycroftsmaller.png"
            width: units.gridUnit * 1.4
            height: units.gridUnit * 1.5
        }
        
    ColorOverlay {
                    anchors.fill: barAnim
                    source: barAnim
                    color: theme.linkColor
    }
    
    PlasmaComponents.Label {
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.left: barAnim.right
                anchors.leftMargin: units.gridUnit * 0.25
                font.capitalization: Font.SmallCaps 
                id: logotextId
                text: i18n("Mycroft")
                font.bold: false;
                color: theme.textColor
    }
    
    PlasmaCore.SvgItem {
        id: topbarLeftDividerline
        anchors {
            left: logotextId.right
            leftMargin: units.gridUnit * 0.34
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linetopleftvertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linetopleftvertSvg;
            imagePath: "widgets/line"
        }
    }  

    PlasmaComponents.Label {
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.left: topbarLeftDividerline.right
                anchors.leftMargin: units.gridUnit * 0.25
                font.capitalization: Font.SmallCaps 
                id: statusId
                text: i18n("<b>Disabled</b>")
                font.bold: false;
                color: theme.textColor
    }
    
    PlasmaComponents.Button {
        id: statusRetryBtn
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: statusId.right
        anchors.leftMargin: units.gridUnit * 0.50
        anchors.bottom: parent.bottom
        anchors.bottomMargin: units.gridUnit * 0.25
        text: i18n("Reconnect")
        width: units.gridUnit * 6
        visible: false
        
        onClicked: {
            retryConn()
        }
    }
    
TopBarAnim {
    id: midbarAnim
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: statusId.left
    anchors.right:  topbarDividerline.left
    height: units.gridUnit * 4
    z: 6
}    
    
    PlasmaCore.SvgItem {
        id: topbarDividerline
        anchors {
            right: mycroftstartservicebutton.left
            rightMargin: units.gridUnit * 0.25
            top: parent.top
            topMargin: 0
            bottom: parent.bottom
            bottomMargin: 0
        }

        width: linetopvertSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: linetopvertSvg;
            imagePath: "widgets/line"
        }
    }   
    
    
        SwitchButton {
                anchors.right: qinputmicbx.left
                anchors.verticalCenter: topBarBGrect.verticalCenter
                id: mycroftstartservicebutton
                checked: false
                width: Math.round(units.gridUnit * 2)
                height: width
                z: 102
                
                onClicked: {
                    if (mycroftstartservicebutton.checked === false) {
                        statusRetryBtn.visible = false
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstoppath);
                        convoLmodel.clear()
                        suggst.visible = true;
                        socket.active = false;
                        midbarAnim.showstatsId()
                        showDash("setVisible")
                    }
                    
                    if (mycroftstartservicebutton.checked === true) {
                        disclaimbox.visible = false;
                        PlasmaLa.LaunchApp.runCommand("bash", coreinstallstartpath);
                        if(dashswitch.checked == "false"){
                        convoLmodel.clear()
                        }
                        suggst.visible = true;
                        statusId.color = theme.linkColor
                        statusId.text = i18n("<b>Starting up..please wait</b>")
                        statusId.visible = true
                        delay(15000, function() {
                        socket.active = true;
                        })
                    }
                }
            }
                
        PlasmaComponents.ToolButton {
                id: qinputmicbx
                anchors.right: pinButton.left
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "mic-on"
                tooltip: i18n("Toggle Mic")
                flat: true
                width: Math.round(units.gridUnit * 2)
                height: width
                z: 102
    
                onClicked: {
                    if (qinputmicbx.iconSource == "mic-on") {
                        muteMicrophone()
                    }
                    else if (qinputmicbx.iconSource == "mic-off") {
                        unmuteMicrophone()
                        }
                    } 
        }
    
    PlasmaComponents.ToolButton {
        id: pinButton
        anchors.right: parent.right
        anchors.verticalCenter: topBarBGrect.verticalCenter
        width: Math.round(units.gridUnit * 1.5)
        height: width
        checkable: true
        iconSource: "window-pin"
        onCheckedChanged: plasmoid.hideOnWindowDeactivate = !checked
        z: 102
        }
    }    
}

PlasmaCore.SvgItem {
        anchors {
            left: main.left
            right: main.right
            top: root.top
        }
        width: 1
        height: horlinetopbarSvg.elementSize("horizontal-line").height

        elementId: "horizontal-line"
        z: 110
        svg: PlasmaCore.Svg {
            id: horlinetopbarSvg;
            imagePath: "widgets/line"
        }
}  
    
Item {
        id: root                
        anchors { 
        top: topBar.bottom
        bottom: rectanglebottombar.top
        left: parent.left
        right: parent.right
        }
        
    WebSocket {
        id: mycroftStatusCheckSocket
        url: innerset.wsurl
        active: true
        property bool _socketIsAlreadyActive: false
        onStatusChanged: 
            if (mycroftStatusCheckSocket.status == WebSocket.Open && socket.status == WebSocket.Closed) {
            socket.active = true
            mycroftStatusCheckSocket._socketIsAlreadyActive = true
            disclaimbox.visible = false;
            mycroftstartservicebutton.checked = true
            statusId.text = i18n("<b>Connected</b>")
            statusId.color = "green"
            statusId.visible = true
            }

            else if (mycroftStatusCheckSocket.status == WebSocket.Error) {
            mycroftstartservicebutton.checked = false
            mycroftStatusCheckSocket._socketIsAlreadyActive = false
            statusId.text = i18n("<b>Disabled</b>")
            statusId.color = theme.textColor
            statusId.visible = true
            }
        }
        
    WebSocket {
        id: socket
        url: innerset.wsurl
        onTextMessageReceived: {
            var somestring = JSON.parse(message)
            var msgType = somestring.type;
            playwaitanim(msgType);
            
            if (msgType === "mycroft.mic.get_status.response") {
                var micState = somestring.data.muted
                if(micState) {
                    micIsMuted = true
                    qinputmicbx.iconSource = "mic-off"
                }
                else if(!micState) {
                     micIsMuted = false
                     qinputmicbx.iconSource = "mic-on"
                }
            }

            if (msgType === "mycroft.skills.initialized") {
                PlasmaLa.Notify.mycroftConnectionStatus(i18n("Ready..Let's Talk"))
            }

            if (msgType === "recognizer_loop:utterance") {
                qinput.focus = false;
                var intpost = somestring.data.utterances;
                qinput.text = intpost.toString()
                convoLmodel.append({"itemType": "AskType", "InputQuery": intpost.toString()})
                midbarAnim.wsistalking()
            }
            
            if (msgType === "recognizer_loop:utterance" && dashLmodel.count != 0){
                showDash("setHide")
            }
            
            if (somestring.data.handler === "fallback" && somestring.data.fallback_handler === "WolframAlphaSkill.handle_fallback" && somestring.type === "mycroft.skill.handler.complete"){
                        if(wolframfallbackswitch.checked == true){
                            getFallBackResult(qinput.text)
                    }
            }
            
            if (somestring && somestring.data && typeof somestring.data.intent_type !== 'undefined'){
                smintent = somestring.data.intent_type;
            }
            
            if(somestring && somestring.data && typeof somestring.data.utterance !== 'undefined' && somestring.type === 'speak'){
                filterSpeak(somestring.data.utterance);
            }

            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "data") {
                dataContent = somestring.data.desktop
                filterincoming(smintent, dataContent)
            }

            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "visualObject") {
                dataContent = somestring.data.desktop
                filtervisualObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "placesObject") {
                dataContent = somestring.data.desktop
                filterplacesObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "recipesObject") {
                dataContent = somestring.data.desktop
                filterRecipeObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "balooObject") {
                dataContent = somestring.data.desktop
                filterBalooObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "stackresponseObject") {
                dataContent = somestring.data.desktop
                filterstackObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "bookObject") {
                dataContent = somestring.data.desktop
                filterbookObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiObject") {
                dataContent = somestring.data.desktop
                filterwikiObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiaddObject") {
                dataContent = somestring.data.desktop
                filterwikiMoreObj(dataContent)
            }
            
            if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "yelpObject") {
                dataContent = somestring.data.desktop
                filteryelpObj(dataContent)
            }
            
            if (msgType === "speak" && !plasmoid.expanded && notificationswitch.checked == true) {
                var post = somestring.data.utterance;
                var title = "Mycroft's Reply:"
                var notiftext = " "+ post;
                PlasmaLa.Notify.mycroftResponse(title, notiftext);
            }
            
             midbarAnim.wsistalking()
        }
                
        onStatusChanged: if (socket.status == WebSocket.Error) {
                                statusId.text = i18n("<b>Connection error</b>")
                                statusId.color = "red"
                                mycroftstartservicebutton.circolour = "red"
                                midbarAnim.showstatsId()
                                statusRetryBtn.visible = true
                                drawer.open()
                                waitanimoutter.aniRunError()
                                delay(1250, function() {
                                    drawer.close()
                                })

                         } else if (socket.status == WebSocket.Open) {
                                statusId.text = i18n("<b>Connected</b>")
                                statusId.color = "green"
                                statusRetryBtn.visible = false
                                mycroftstartservicebutton.circolour = "green"
                                mycroftStatusCheckSocket.active = false;
                                midbarAnim.showstatsId()
                                PlasmaLa.Notify.mycroftConnectionStatus("Connected")
                                drawer.open()
                                waitanimoutter.aniRunHappy()
                                delay(1250, function() {
                                    drawer.close()
                                    checkMicrophoneState()
                                })
                         } else if (socket.status == WebSocket.Closed) {
                                statusId.text = i18n("<b>Disabled</b>")
                                statusId.color = theme.textColor
                                PlasmaLa.Notify.mycroftConnectionStatus("Disconnected")
                                mycroftstartservicebutton.circolour = Qt.lighter(theme.backgroundColor, 1.5)
                                midbarAnim.showstatsId()
                         } else if (socket.status == WebSocket.Connecting) {
                                statusId.text = i18n("<b>Starting up..please wait</b>")
                                statusId.color = theme.linkColor
                                mycroftstartservicebutton.circolour = "steelblue"
                                midbarAnim.showstatsId()
                         } else if (socket.status == WebSocket.Closing) {
                                statusId.text = i18n("<b>Shutting down</b>")
                                statusId.color = theme.textColor
                                midbarAnim.showstatsId()
                         }
    }    
        
    ColumnLayout {
    id: sidebar
    height: units.gridUnit * 6
    width: units.gridUnit * 2
    
    PlasmaComponents.TabBar {
        id: tabBar
        anchors.fill: parent
        tabPosition: Qt.LeftEdge;
        
            PlasmaComponents.TabButton {
                id: mycroftTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "go-home"
                
                    PlasmaCore.ToolTipArea {
                        id: tooltiptab1
                        mainText: i18n("Conversation")
                        anchors.fill: parent
                        }
                
                }
                  
            PlasmaComponents.TabButton {
                id: mycroftSkillsTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "games-hint"
                
                    PlasmaCore.ToolTipArea {
                        id: tooltiptab2
                        mainText: i18n("Hints/Tips")
                        anchors.fill: parent
                        }
                
                }
                
            PlasmaComponents.TabButton {
                id: mycroftSettingsTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "games-config-options"
                
                    PlasmaCore.ToolTipArea {
                        id: tooltiptab3
                        mainText: i18n("Settings")
                        anchors.fill: parent
                        }
                
                }
                
            PlasmaComponents.TabButton {
                id: mycroftMSMinstTab
                Layout.fillHeight: true
                Layout.fillWidth: true
                iconSource: "kmouth-phresebook-new"
                
                
                    PlasmaCore.ToolTipArea {
                        id: tooltiptab4
                        mainText: i18n("Skill Browser")
                        anchors.fill: parent
                        }
                
                }  
                
            }
    }

    PlasmaCore.SvgItem {
        anchors {
            left: parent.left
            leftMargin: sidebar.width
            top: parent.top
            topMargin: 1
            bottom: parent.bottom
            bottomMargin: 1
        }

        width: lineSvg.elementSize("vertical-line").width
        z: 110
        elementId: "vertical-line"

        svg: PlasmaCore.Svg {
            id: lineSvg;
            imagePath: "widgets/line"
        }
    }        
                
    ColumnLayout {
    id: mycroftcolumntab    
    visible: tabBar.currentTab == mycroftTab;
    anchors.top: root.top
    anchors.left: sidebar.right
    anchors.leftMargin: units.gridUnit * 0.25
    anchors.right: root.right
    anchors.bottom: root.bottom

    Rectangle {
                    id: rectangle2
                    color: "#00000000"
                    anchors.top: mycroftcolumntab.top
                    anchors.topMargin:15
                    anchors.left: mycroftcolumntab.left
                    anchors.right: mycroftcolumntab.right
                    anchors.bottom: mycroftcolumntab.bottom
                
    DropArea {           
        anchors.fill: parent;
        id: dragTarget
        onEntered: {
            for(var i = 0; i < drag.urls.length; i++)
                if(validateFileExtension(drag.urls[i]))
                return
                console.log("No valid files, refusing drag event")
                drag.accept()
                dragTarget.enabled = false
        }
        
        onDropped: {
            for(var i = 0; i < drop.urls.length; i++){
            var ext = getFileExtenion(drop.urls[i]);
            if(ext === "jpg" || ext === "png" || ext === "jpeg"){
            var durl = String(drop.urls[i]);
            convoLmodel.append({
                "itemType": "DropImg",
                "InputQuery": durl
                })
                inputlistView.positionViewAtEnd();
            }
            
            if(ext === 'mp3'){
                console.log('mp3');
                }
            }
        }
                
        Disclaimer{
            id: disclaimbox
            visible: false
            }
        
        ListModel{
        id: convoLmodel
        }

            Rectangle {
                id: messageBox
                anchors.fill: parent
                anchors.right: parent.right
                anchors.left: parent.left
                color: "#00000000"

                ColumnLayout {
                    id: colconvo
                    anchors.fill: parent

                ListView {
                    id: inputlistView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    verticalLayoutDirection: ListView.TopToBottom
                    spacing: 12
                    clip: true
                    model: convoLmodel
                    ScrollBar.vertical: ScrollBar {}
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
                                        }
                                    property var metacontent : dataContent
                                }
                        }

                onCountChanged: {
                    inputlistView.positionViewAtEnd();
                                }
                                    }
                                        }
                                            }
                                                }
                                                    }
                                                        }
                                                    
    ColumnLayout {
    id: mycroftSkillscolumntab    
    visible: tabBar.currentTab == mycroftSkillsTab;
    anchors.top: root.top
    anchors.left: sidebar.right
    anchors.leftMargin: units.gridUnit * 0.25
    anchors.right: root.right
    anchors.bottom: root.bottom

                ListView {
                    id: skillslistmodelview
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    model: SkillModel{}
                    delegate: SkillView{}
                    spacing: 4
                    focus: false
                    interactive: true
                    clip: true;
                }

        }

    ColumnLayout {
    id: mycroftSettingsColumn
    visible: tabBar.currentTab == mycroftSettingsTab;
    anchors.top: root.top
    anchors.left: sidebar.right
    anchors.leftMargin: units.gridUnit * 0.25
    anchors.right: root.right
    anchors.bottom: root.bottom
    
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
                    showDash("setVisible")
                }
                else if(!dashswitch.checked){
                    convoLmodel.clear()
                    disclaimbox.visible = true
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
                    updateCardData()
                }
            }
            PlasmaComponents.Button{
                id: owmApiKeyMetricFar
                text: i18n("Fahrenheit")
                onClicked: {
                    weatherMetric = "imperial"
                    updateCardData()
                }
            }
        }
                    
                }
            }
        }
    }

    ColumnLayout {
    id: mycroftMsmColumn
    visible: tabBar.currentTab == mycroftMSMinstTab;
    anchors.top: root.top
    anchors.left: sidebar.right
    anchors.leftMargin: units.gridUnit * 0.25
    anchors.right: root.right
    anchors.bottom: root.bottom
            
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
        }
}
                
    PlasmaCore.SvgItem {
        anchors {
            left: main.left
            right: main.right
            bottom: root.bottom
        }
        width: 1
        height: horlineSvg.elementSize("horizontal-line").height

        elementId: "horizontal-line"
                z: 110
        svg: PlasmaCore.Svg {
            id: horlineSvg;
            imagePath: "widgets/line"
        }
    }        
                       
                
Item {
    id: rectanglebottombar
    height: units.gridUnit * 3.5
    anchors.left: main.left
    anchors.right: main.right
    anchors.bottom: main.bottom
    z: 110
    
    ListModel {
        id: completionItems
    }
    
    Drawer {
         id: drawer
          width: dwrpaddedwidth
          height: units.gridUnit * 5.5
          edge: Qt.BottomEdge
 
          Rectangle {
            color: theme.backgroundColor
            anchors.fill: parent
          }

     CustomIndicator {
              id: waitanimoutter
              height: 70
              width: 70
              anchors.verticalCenter: parent.verticalCenter
              anchors.horizontalCenter: parent.horizontalCenter
                  }
          }
    
    Rectangle {
        id: suggestionbottombox
        anchors.top: parent.top
        anchors.bottom: qinput.top
        anchors.right: parent.right
        anchors.left: parent.left
        color: theme.backgroundColor
            
        Suggestions {
            id: suggst
            visible: true;
        }
    }
    
        Rectangle {
        id: keyboardactivaterect
        color: theme.backgroundColor
        border.width: 1
        border.color: Qt.lighter(theme.backgroundColor, 1.2)
        width: units.gridUnit * 2
        height: qinput.height
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        PlasmaCore.IconItem {
            id: keybdImg
            source: "input-keyboard"
            anchors.centerIn: parent
            width: units.gridUnit * 1.5
            height: units.gridUnit * 1.5
        }

        Rectangle {
            id: keybindic
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            height: 2
            color: "green"
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {}
            onExited: {}
            onClicked: {
                if(qinput.visible === false){
                    toggleInputMethod("KeyboardSetActive")
                    }
                else if(qinput.visible === true){
                    toggleInputMethod("KeyboardSetDisable")
                    }
                }
            }
        }
    
    PlasmaComponents.TextField {
        id: qinput
        anchors.left: keyboardactivaterect.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        placeholderText: i18n("Enter Query or Say 'Hey Mycroft'")
        clearButtonShown: true
        
        onAccepted: {
            var doesExist = autoAppend(autoCompModel, function(item) { return item.name === qinput.text }, qinput.text)
            var evaluateExist = doesExist
            if(evaluateExist === null){
                        autoCompModel.append({"name": qinput.text});
            }
            suggst.visible = true;
            var socketmessage = {};
            socketmessage.type = "recognizer_loop:utterance";
            socketmessage.data = {};
            socketmessage.data.utterances = [qinput.text];
            socket.sendTextMessage(JSON.stringify(socketmessage));
            qinput.text = ""; 
            }
        
        onTextChanged: {
            evalAutoLogic();
        }
    }
    
    CustomMicIndicator {
        id: customMicIndicator
        anchors.centerIn: parent
        visible: false
    }
    
    AutocompleteBox {
        id: suggestionsBox
        model: completionItems
        width: parent.width
        anchors.bottom: qinput.top
        anchors.left: parent.left
        anchors.right: parent.right
        filter: textInput.text
        property: "name"
        onItemSelected: complete(item)

        function complete(item) {
            if (item !== undefined)
                textInput.text = item.name
            }
    }
}

    Settings {
            id: innerset
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
            property alias newsCardAPIKey: newsApiKeyLabelFld.text
            property alias weatherCardSetting: weathercardswitch.checked
            property alias weatherCardAPIKey: owmApiKeyLabelFld.text
            property alias weatherMetricC: owmApiKeyMetricCel.checked
            property alias weatherMetricF: owmApiKeyMetricFar.checked
            property alias versionIndex: versionBox.currentIndex
            property alias versionUrl: versionBox.versionInfo
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
