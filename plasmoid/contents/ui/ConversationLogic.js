function filterConversation(msgType, somestring){
    if (msgType === "mycroft.mic.get_status.response") {
        var micState = somestring.data.muted
        if(micState) {
            micIsMuted = true
            topBarView.micIcon = "mic-off"
        }
        else if(!micState) {
                micIsMuted = false
                topBarView.micIcon = "mic-on"
        }
    }

    if (msgType === "mycroft.skills.initialized") {
        PlasmaLa.Notify.mycroftConnectionStatus(i18n("Ready..Let's Talk"))
    }

    if (msgType === "recognizer_loop:utterance") {
        bottomBarView.queryInput.focus = false;
        var intpost = somestring.data.utterances;
        bottomBarView.queryInput.text = intpost.toString()
        mycroftConversationComponent.conversationModel.append({itemType: "AskType", inputQuery: "", itemData:{queryData: intpost.toString()}})
        topBarView.animateTalk()
    }
    
    if (msgType === "recognizer_loop:utterance" && dashLmodel.count != 0){
        Dash.showDash("setHide")
    }
    
    if (somestring.data.handler === "fallback" && somestring.data.fallback_handler === "WolframAlphaSkill.handle_fallback" && somestring.type === "mycroft.skill.handler.complete"){
                if(wolframfallbackswitch.checked == true){
                    Conversation.getFallBackResult(bottomBarView.queryInput.text)
            }
    }
    
    if (somestring && somestring.data && typeof somestring.data.intent_type !== 'undefined'){
        smintent = somestring.data.intent_type;
        console.log(smintent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.utterance !== 'undefined' && somestring.type === 'speak'){
        Conversation.filterSpeak(somestring.data.utterance);
    }

    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "data") {
        dataContent = somestring.data.desktop
        Conversation.filterincoming(smintent, dataContent)
    }

    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "visualObject") {
        dataContent = somestring.data.desktop
        Conversation.filtervisualObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "placesObject") {
        dataContent = somestring.data.desktop
        Conversation.filterplacesObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "recipesObject") {
        dataContent = somestring.data.desktop
        Conversation.filterRecipeObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "balooObject") {
        dataContent = somestring.data.desktop
        Conversation.filterBalooObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "stackresponseObject") {
        dataContent = somestring.data.desktop
        Conversation.filterstackObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "bookObject") {
        dataContent = somestring.data.desktop
        Conversation.filterbookObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiObject") {
        dataContent = somestring.data.desktop
        Conversation.filterwikiObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "wikiaddObject") {
        dataContent = somestring.data.desktop
        Conversation.filterwikiMoreObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "yelpObject") {
        dataContent = somestring.data.desktop
        Conversation.filteryelpObj(dataContent)
    }
    
    if(somestring && somestring.data && typeof somestring.data.desktop !== 'undefined' && somestring.type === "imageObject") {
        dataContent = somestring.data.desktop
        Conversation.filterImageObject(dataContent)
    }
    
    
    if (msgType === "speak" && !plasmoid.expanded && appletSettings.innerset.notifybool == true) {
        var post = somestring.data.utterance;
        var title = "Mycroft's Reply:"
        var notiftext = " "+ post;
        PlasmaLa.Notify.mycroftResponse(title, notiftext);
    }
}
