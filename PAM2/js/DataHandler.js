//--------------------------------------------------------------------
//                            index Page
//--------------------------------------------------------------------

function getUserLastEvent() {
    $.ajax({
        url: 'WebService.asmx/getUserLastEvent',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseLastEvent
    }) 

}

function parseLastEvent(results)
{
    results = $.parseJSON(results.d);
    str = results[0].Title;
    $("#MainNextEvent").html(str);
}

//---------------------------------//

function getLastResult() {
    $.ajax({
        url: 'WebService.asmx/getLastResult',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserLastResult
    }) // end of ajax call

}

function parseUserLastResult(results) {
    results = $.parseJSON(results.d);
    str = results[0].Distance + " מטר | " + results[0].Description + " | " + results[0].rTime.Minutes + ":" + results[0].rTime.Seconds;
    $("#MainLastResult").html(str);
}

//---------------------------------//

function getMessagesCount() {
    $.ajax({
        url: 'WebService.asmx/getMessagesCount',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseMessagesCount
    }) 
}

function parseMessagesCount(results) {
    str = results.d;
    $("#MainMessages").html(str);
}

//---------------------------------//


function getScore() {
    $.ajax({
        url: 'WebService.asmx/getScore',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseScore,
        error: changeToCoachMode
    }) 

}

function parseScore(results) {
    str = results.d;
    if (str == null)
        window.location = "index.html";
    $("#MainAppScore").append(" " + str);
}

//Can remove
function changeToCoachMode(e){
    window.location = "index.html";
}

//---------------------------------//

function getName() {
    $.ajax({
        url: 'WebService.asmx/getName',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseName
    })
}

function parseName(results) {
    str = results.d;
    $("#MainWelcome").append(" "+str);
}


//--------------------------------------------------------------------
//                           Profile Page
//--------------------------------------------------------------------

function getUserDetails() {
    $.ajax({
        url: 'WebService.asmx/getUserDetails',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserDetails
    })
}

function parseUserDetails(results) {
    results = $.parseJSON(results.d);

    strProfileName = results[0].FirstName + " " + results[0].LastName;
    $("#ProfileName").append(strProfileName);

    strProfileWeight = results[0].Weight+" קילו";
    $("#ProfileWeight").append(strProfileWeight);

    strProfileHeight = results[0].Highet +" מטר";
    $("#ProfileHeight").append(strProfileHeight);

    var birthDate = parseInt(results[0]["BirthDate"].split("(")[1].split(")")[0]);
    var tempProfileAge = new Date(birthDate);
    strProfileAge = tempProfileAge.getDay() + "/" + tempProfileAge.getMonth() + "/" + tempProfileAge.getFullYear();
    $("#ProfileAge").append(strProfileAge);
    
    strProfileCity = results[0].City;
    $("#ProfileCity").append(strProfileCity);

    strProfileEmail = results[0].Email;
    $("#ProfileEmail").append(strProfileEmail);
    
    strProfilePhone = results[0].PhoneNumber;
    $("#ProfilePhone").append(strProfilePhone);

    strProfileAppScore = results[0].AppScore;
    $("#ProfileAppScore").append(strProfileAppScore);
    
}


//--------------------------------------------------------------------
//                           Results Page
//--------------------------------------------------------------------

function getUserResults() {
    $.ajax({
        url: 'WebService.asmx/getUserResults',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserResults
    }) 
}

function parseUserResults(results) {
    results = $.parseJSON(results.d);
    $(function () {
        $.each(results, function (i, item) {
            var eventTime = parseInt(item["rDate"].split("(")[1].split(")")[0]);
            var eventStartDate = new Date(eventTime);
            var strDate = "";
            strDate += eventStartDate.getDay() + "/" + eventStartDate.getMonth() + "/" + eventStartDate.getFullYear();
            var resultType;
            if (item.ResultType == 1)
                resultType = "mdi mdi-swim";
            else if (item.ResultType == 2)
                resultType = "mdi mdi-run-fast";
            else
                resultType = "mdi mdi-clock-fast";
            var $tr = $('<tr>').append(
                $('<td>').html("<i class='"+resultType+"'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(item.rTime.Minutes +":" + item.rTime.Seconds),
                $('<td>').text(strDate)
            ).appendTo('#ResultsTable');
        });
    });

}

//--------------------------------------------------------------------
//                           Events Page
//--------------------------------------------------------------------

function getUserType() {

    userType = $.ajax({
        url: 'WebService.asmx/getUserType',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
       
    }) // end of ajax call

   return userType.responseJSON.d
}

function getUserEvents() {

    events = $.ajax({
        url: 'WebService.asmx/getUserEvents',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8'
    }) // end of ajax call

    return events.responseJSON.d
}

function getCoachEvents() {

    events = $.ajax({
        url: 'WebService.asmx/getCoachEvents',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8'
    }) // end of ajax call

    return events.responseJSON.d
}


//--------------------------------------------------------------------
//                           Messages Page
//--------------------------------------------------------------------

function getUserMessages() {

    $.ajax({
        url: 'WebService.asmx/getUserMessages',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserMessages
    })
}

function parseUserMessages(results) {
    results = $.parseJSON(results.d);
    $(function () {
        $.each(results, function (i, item) {

            var messageDate = parseInt(item["mDate"].split("(")[1].split(")")[0]);
            var messageStartDate = new Date(messageDate);
            var strDate = "";
            strDate += messageStartDate.getDay() + "/" + messageStartDate.getMonth() + "/" + messageStartDate.getFullYear();
            var messageid = item["MessageID"]
            var $tr = $('<tr class="email-msg">').append(
                $('<td>').html("<a class=''></a>").text(item.FirstName + " " + item.LastName),
                $('<td class="hidden-xs">').html("<a id='" + messageid + "' class='email-msg'>"+item.Title+"</a>"),
                $('<td class="text-right">').text(item.mTime.Hours + ":" + item.mTime.Minutes),
                $('<td class="text-right">').text(strDate)
            ).appendTo('#InboxTable');
        });
    });   
}

function UserMessageModal() {

    $.ajax({
        url: 'WebService.asmx/getUserMessages',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserMessageModal,
        error: messageModalError
        
    });
    
}

function parseUserMessageModal(results) {
    
    //Convert results back to JSON
    results = $.parseJSON(results.d);  
   
    //Go Over the results;
    for (var i = 0; i < results.length; i++) {
        if (results[i].MessageID == MessageInfo.id) {
            //load values to data modal
            document.getElementById("messageModalTitle").innerText = results[i].Title;
            document.getElementById("messageModalBody").innerText = results[i].mBody;
            //open modal
            $('#message-modal').modal('show');
            return;
        }
       
    }
    alert("Could not find message");
}

function messageModalError(a,b,c)
{
    console.log(a);
    console.log(b);
    console.log(c);
    alert('getUserMessagesbyID() error');
}


//--------------------------------------------------------------------
//                             Register
//--------------------------------------------------------------------
function getPicturePath() {
    $.ajax({
        url: 'WebService.asmx/getPicturePath',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: updateUserPicture
    }) // end of ajax call
}

function updateUserPicture(results) {
        $.get(results.d, function (data) {
            profileImg = $('#profileimage');
            profileImg.attr("src", data);
            profileImgProfilePage = $('#profileimageProfile');
            profileImgProfilePage.attr("src", data);
        });
    }

//--------------------------------------------------------------------
//                             Dashboard
//--------------------------------------------------------------------
function getCoachLastResults() {
    $.ajax({
        url: 'WebService.asmx/getCoachLastResults',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseCoachLastResluts,
        error: errorCoachLastResults
    }) // end of ajax call
}

function errorCoachLastResults(e){
    alert(e.responseText);
}

function parseCoachLastResluts(results) {
    results = $.parseJSON(results.d);
    alert(results.d);
    $(function () {
        $.each(results, function (i, item) {
            var eventTime = parseInt(item["rDate"].split("(")[1].split(")")[0]);
            var eventStartDate = new Date(eventTime);
            var strDate = "";
            strDate += eventStartDate.getDay() + "/" + eventStartDate.getMonth() + "/" + eventStartDate.getFullYear();
            var resultType;
            if (item.ResultType == 1)
                resultType = "mdi mdi-swim";
            else if (item.ResultType == 2)
                resultType = "mdi mdi-run-fast";
            else
                resultType = "mdi mdi-clock-fast";
            var $tr = $('<tr>').append(
                 $('<td>').text(item.FirstName+" "+item.LastName),
                $('<td>').html("<i class='" + resultType + "'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(item.rTime.Minutes + ":" + item.rTime.Seconds),
                $('<td>').text(strDate)
            ).appendTo('#ResultsTableDashboard');
        });
    });
    
}