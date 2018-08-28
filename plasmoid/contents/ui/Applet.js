    function detectInstallType(){
        if(locationUserSelected == false && PlasmaLa.FileReader.file_exists_local("/usr/bin/mycroft-messagebus")){
            settingsTabUnitsOpOne.checked = true
            coreinstallstartpath = packagemcorestartcmd
            coreinstallstoppath = packagemcorestopcmd
        }
    }
        
    function checkConnectionStatus(){
        var isConnected = PlasmaLa.ConnectionCheck.checkConnection()
        if(!isConnected){
               if(!connectCtx){
               var conError = i18n("I am not connected to the internet, Please check your network connection")
               mycroftConversationComponent.conversationModel.append({"itemType": "NonVisual", "InputQuery": conError});
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
