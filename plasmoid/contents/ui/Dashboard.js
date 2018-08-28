    function checkDashStatus(){
        if(dashListModel.count == 0){
            Applet.checkConnectionStatus()
        }
    }
    
    function fetchDashNews(){
        var doc = new XMLHttpRequest()
        var url = 'https://newsapi.org/v2/top-headlines?' +
                'country=' + globalcountrycode + '&' +
                'apiKey=' + appletSettings.innerset.newsCardAPIKey.text;
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
        var url = 'https://api.openweathermap.org/data/2.5/forecast?' +
        'lat=' + geoLat + '&lon=' + geoLong + '&units=' + weatherMetric + '&cnt=3' +
        '&APPID=' + appletSettings.innerset.weatherCardAPIKey.text;

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
        var url = "https://min-api.cryptocompare.com/data/price?fsym=" + appletSettings.innerset.selectedCrypto + "&tsyms=" + appletSettings.innerset.selectedCur1 + "," + appletSettings.innerset.selectedCur2 + "," + appletSettings.innerset.selectedCur3
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
        mycroftConversationComponent.conversationModel.clear()
        showDash("setVisible")
    }
    
    function setDisclaimer(){
        dashLmodel.append({"iType": "Disclaimer", "iObj": "none"})
    }
    
    function globalDashRun(){
            if(appletSettings.innerset.dashboardSetting == true){
                if(appletSettings.innerset.disclaimerCardSetting == true){
                 setDisclaimer()
                }
                if(appletSettings.innerset.newsCardSetting == true){
                 fetchDashNews()
                }
                if(appletSettings.innerset.weatherCardSetting == true){
                 fetchDashWeather()
                }
                if(appletSettings.innerset.cryptoCardSetting == true){
                 fetchDashCryptoCardData()
                }
                    mycroftConversationComponent.conversationModel.append({"itemType": "DashboardType", "InputQuery": ""})
            }
            else {
                mycroftConversationComponent.conversationModel.clear()
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
                mycroftConversationComponent.conversationModel.clear()
                break
        }
    }
