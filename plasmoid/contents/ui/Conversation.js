    function getFallBackResult(failedQuery){
      var url = "http://api.wolframalpha.com/v1/simple?appid=" + innerset.wolframKey + "&i=" + failedQuery + "&width=1024&fontsize=32"
      mycroftConversationComponent.conversationModel.append({"itemType": "FallBackType", "InputQuery": url})
    }
    
        function filterSpeak(msg){
        mycroftConversationComponent.conversationModel.append({
            "itemType": "NonVisual",
            "InputQuery": msg
        })
           mycroftConversationComponent.conversationListView.positionViewAtEnd();
    }
    
    function filterincoming(intent, metadata) {
        var intentVisualArray = ['handle_current_weather'];
        var itemType
        var filterintentname = intent.split(':');
        var intentname = filterintentname[1];
        console.log("IntentName: " + intentname)
        if (intentVisualArray.indexOf(intentname) !== -1) {
                switch (intentname){
                case "handle_current_weather":
                    itemType = "CurrentWeather"
                    break;
                }
              mycroftConversationComponent.conversationModel.append({"itemType": itemType, "itemData": metadata})
                }

        else {
            mycroftConversationComponent.conversationModel.append({"itemType": "WebViewType", "InputQuery": metadata.url})
        }
    }
    
    function filtervisualObj(metadata){
                mycroftConversationComponent.conversationModel.append({"itemType": "LoaderType", "InputQuery": metadata.url})
                mycroftConversationComponent.conversationListView.positionViewAtEnd();
          }
          
    function filterplacesObj(metadata){
        var filteredData = JSON.parse(metadata.data);
        var locallat = JSON.parse(metadata.locallat);
        var locallong = JSON.parse(metadata.locallong);
        var hereappid = metadata.appid
        var hereappcode = metadata.appcode;
        mycroftConversationComponent.conversationModel.clear()
        placesListModel.clear()
        for (var i = 0; i < filteredData.results.items.length; i++){
            var itemsInPlaces = JSON.stringify(filteredData.results.items[i])
            var fltritemsinPlc = JSON.parse(itemsInPlaces)
            var fltrtags = getTags(filteredData.results.items[i].tags)
            placesListModel.insert(i, {placeposition: JSON.stringify(fltritemsinPlc.position), placetitle: JSON.stringify(fltritemsinPlc.title), placedistance: JSON.stringify(fltritemsinPlc.distance), placeloc: JSON.stringify(fltritemsinPlc.vicinity), placeicon: JSON.stringify(fltritemsinPlc.icon), placetags: fltrtags, placelocallat: locallat, placelocallong: locallong, placeappid: hereappid, placeappcode: hereappcode})
        }
        mycroftConversationComponent.conversationModel.append({"itemType": "PlacesType", "InputQuery": ""});
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
        mycroftConversationComponent.conversationModel.clear()
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
        mycroftConversationComponent.conversationModel.append({"itemType": "RecipeType", "InputQuery": ""})
    }
    
    function filterBalooObj(metadata){
        var BalooObj = metadata;
        var baloosearchTerm = metadata.searchType
        mycroftConversationComponent.conversationModel.clear()
        for (var i = 0; i < BalooObj.data.length; i++){
            if(baloosearchTerm == "type:audio"){
                mycroftConversationComponent.conversationModel.append({"itemType": "AudioFileType", "InputQuery": metadata.data[i]})   
            }
            if(baloosearchTerm == "type:video"){
                mycroftConversationComponent.conversationModel.append({"itemType": "VideoFileType", "InputQuery": metadata.data[i]})   
            }
            if(baloosearchTerm == "type:document" || baloosearchTerm == "type:spreadsheet" || baloosearchTerm == "type:presentation" || baloosearchTerm == "type:archive" ){
                mycroftConversationComponent.conversationModel.append({"itemType": "DocumentFileType", "InputQuery": metadata.data[i]})   
            }
        }
    }
    
    function filterstackObj(metadata){
        var filterStackMeta = JSON.parse(metadata.data)
        mycroftConversationComponent.conversationModel.clear()
        stackexListModel.clear()
        for (var i = 0; i < filterStackMeta.items.length; i++){
            stackexListModel.insert(i, {sQuestion: filterStackMeta.items[i].title, sLink: filterStackMeta.items[i].link, sAuthor: filterStackMeta.items[i].owner.display_name, sIsAnswered: filterStackMeta.items[i].is_answered, sAnswerCount: filterStackMeta.items[i].answer_count})
        }
        mycroftConversationComponent.conversationModel.append({"itemType": "StackObjType", "InputQuery": ""})
        mycroftConversationComponent.conversationListView.positionViewAtEnd();
    }
    
    function filterbookObj(metadata){
        var filterBookMeta = JSON.parse(metadata.data)
        bookListModel.clear()
        bookListModel.append({bookcover: filterBookMeta.bkcover, bookurl: filterBookMeta.bkurl, bookstatus: filterBookMeta.bkstatus, booktitle: filterBookMeta.bktitle, bookauthor: filterBookMeta.bkauthor, bookdate: filterBookMeta.bkyear, bookpublisher: filterBookMeta.bkpublisher})
        mycroftConversationComponent.conversationModel.append({"itemType": "BookType", "InputQuery": ""})
        mycroftConversationComponent.conversationListView.positionViewAtEnd();
    }
    
    function filterwikiObj(metadata){
        var wikiSummary = JSON.stringify(metadata.data.summary)
        var wikiImage = JSON.stringify(metadata.data.image)
        wikiSummary = wikiSummary.replace(/['"]+/g, '')
        wikiImage = wikiImage.replace(/['"]+/g, '')
        mycroftConversationComponent.conversationModel.clear()
        wikiListModel.clear()
        wikiListModel.append({summary: wikiSummary, image: wikiImage})
        mycroftConversationComponent.conversationModel.append({"itemType": "WikiType", "InputQuery": ""})
        mycroftConversationComponent.conversationListView.positionViewAtEnd();
    }
    
    function filterwikiMoreObj(metadata){
        var wikiSummaryMore = JSON.stringify(metadata.data.summarymore)
        var wikiImageMore = JSON.stringify(metadata.data.imagemore)
        mycroftConversationComponent.conversationModel.clear()
        wikiListModel.clear()
        wikiSummaryMore = wikiSummaryMore.replace(/['"]+/g, '')
        wikiImageMore = wikiImageMore.replace(/['"]+/g, '')
        wikiListModel.append({summary: wikiSummaryMore, image: wikiImageMore})
        mycroftConversationComponent.conversationModel.append({"itemType": "WikiType", "InputQuery": ""})
    }
    
    function filteryelpObj(metadata){
        var filtermetayelp = metadata
        yelpListModel.clear()
        yelpListModel.append({'restaurant': filtermetayelp.data.restaurant, 'phone': filtermetayelp.data.phone, 'location': filtermetayelp.data.location, 'status': filtermetayelp.data.status, 'url': filtermetayelp.data.url, 'image_url': filtermetayelp.data.image_url, 'rating': filtermetayelp.data.rating})
        mycroftConversationComponent.conversationModel.append({"itemType": "YelpType", "InputQuery": ""})
    }

    function filterImageObject(metadata){
        mycroftConversationComponent.conversationModel.append({"itemType": "ImageType", "InputQuery": metadata.data})
    }
