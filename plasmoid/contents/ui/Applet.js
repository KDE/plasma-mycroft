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
            topBarView.micIcon = "mic-off"
        }
    
    function unmuteMicrophone(){
            var socketmessage = {};
            socketmessage.type = "mycroft.mic.unmute";
            socketmessage.data = {};
            socket.sendTextMessage(JSON.stringify(socketmessage));
            topBarView.micIcon = "mic-on"
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
               bottomBarView.animationDrawer.open()
               bottomBarView.animateStepWorking()
               break
           case "recognizer_loop:wakeword":
                bottomBarView.animateStepHappy()
                break
           case "intent_failure":
                bottomBarView.animateStepError()
                intentfailure = true
                break
           case "recognizer_loop:audio_output_start":
               if (intentfailure === false){
                   bottomBarView.animationDrawer.close()
               }
               else {
                delay(1500, function() {
                        bottomBarView.animationDrawer.close()
                        intentfailure = false;
                    }) 
                }
               break
           case "mycroft.skill.handler.complete":
               if (intentfailure === false){
                   bottomBarView.animationDrawer.close()
               }
               else {
                delay(1500, function() {
                        bottomBarView.animationDrawer.close()
                        intentfailure = false;
                    }) 
                }
               break
       }
   }
   
   function preSocketStatus(){
    if (mycroftStatusCheckSocket.status == WebSocket.Open && socket.status == WebSocket.Closed) {
        socket.active = true
        mycroftStatusCheckSocket._socketIsAlreadyActive = true
        disclaimbox.visible = false;
        topBarView.startSwitch.checked = true
        topBarView.mycroftStatus.text = i18n("<b>Connected</b>")
        topBarView.mycroftStatus.color = "green"
        topBarView.mycroftStatus.visible = true
        }

        else if (mycroftStatusCheckSocket.status == WebSocket.Error) {
        topBarView.startSwitch.checked = false
        mycroftStatusCheckSocket._socketIsAlreadyActive = false
        topBarView.mycroftStatus.text = i18n("<b>Disabled</b>")
        topBarView.mycroftStatus.color = theme.textColor
        topBarView.mycroftStatus.visible = true
        }
   }
   
   function mainSocketStatus(){
     if (socket.status == WebSocket.Error) {
        topBarView.mycroftStatus.text = i18n("<b>Connection error</b>")
        topBarView.mycroftStatus.color = "red"
        topBarView.startSwitch.circolour = "red"
        topBarView.talkAnimation.showstatsId()
        topBarView.retryButton.visible = true
        topBarView.retryButton.enabled = true
        bottomBarView.animationDrawer.open()
        bottomBarView.animateStepError()
        delay(1250, function() {
            bottomBarView.animationDrawer.close()
        })

    } else if (socket.status == WebSocket.Open) {
        topBarView.mycroftStatus.text = i18n("<b>Connected</b>")
        topBarView.mycroftStatus.color = "green"
        topBarView.retryButton.visible = false
        topBarView.retryButton.enabled = false
        topBarView.startSwitch.circolour = "green"
        mycroftStatusCheckSocket.active = false;
        topBarView.talkAnimation.showstatsId()
        PlasmaLa.Notify.mycroftConnectionStatus("Connected")
        bottomBarView.animationDrawer.open()
        bottomBarView.animateStepHappy()
        delay(1250, function() {
            bottomBarView.animationDrawer.close()
            Applet.checkMicrophoneState()
        })
    } else if (socket.status == WebSocket.Closed) {
        topBarView.mycroftStatus.text = i18n("<b>Disabled</b>")
        topBarView.mycroftStatus.color = theme.textColor
        PlasmaLa.Notify.mycroftConnectionStatus("Disconnected")
        topBarView.startSwitch.circolour = Qt.lighter(theme.backgroundColor, 1.5)
        topBarView.talkAnimation.showstatsId()
    } else if (socket.status == WebSocket.Connecting) {
        topBarView.mycroftStatus.text = i18n("<b>Starting up..please wait</b>")
        topBarView.mycroftStatus.color = theme.linkColor
        topBarView.startSwitch.circolour = "steelblue"
        topBarView.talkAnimation.showstatsId()
    } else if (socket.status == WebSocket.Closing) {
        topBarView.mycroftStatus.text = i18n("<b>Shutting down</b>")
        topBarView.mycroftStatus.color = theme.textColor
        topBarView.talkAnimation.showstatsId()
    }  
   }
