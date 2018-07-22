
//--------------------------------------------------------------------
//                            get the user id
//--------------------------------------------------------------------

function getUserId() {
    userIdNum = localStorage["UserID"];
    request = {
        userId: userIdNum
    };
    return request;
}


//--------------------------------------------------------------------
//                            index Page
//--------------------------------------------------------------------


function getUserLastEvent() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getUserLastEvent',
        data: dataString,
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

    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getLastResult',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserLastResult
    }) // end of ajax call

}

function parseUserLastResult(results) {

    results = $.parseJSON(results.d);

    //parse time
    min = results[0].rTime.Minutes;
    sec = results[0].rTime.Seconds;
    if (results[0].rTime.Minutes < 10)
        min = "0" + results[0].rTime.Minutes;
    if (results[0].rTime.Seconds < 10)
        sec = "0" + results[0].rTime.Seconds;

    str = results[0].Distance + " מטר | " + results[0].Description + " | " + min + ":" + sec;
    $("#MainLastResult").html(str);
}

//---------------------------------//

function getMessagesCount() {
    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getMessagesCount',
        data: dataString,
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
    parseMessagesCountAthlete(results);
}

//---------------------------------//

function getScore() {

    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getScore',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseScore
    }) 

}

function parseScore(results) {
    str = results.d;
    $("#MainAppScore").append(" " + str);
}


//---------------------------------//

function getName() {
    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getName',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseName
    })
}

function parseName(results) {
    str = results.d;
    $("#MainWelcome").append(" " + str);
}


//--------------------------------------------------------------------
//                           Profile Page
//--------------------------------------------------------------------

function getUserDetails() {
    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getUserDetails',
        data: dataString,
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
    strProfileAge = tempProfileAge.getDate() + "/" + (tempProfileAge.getMonth() +1) + "/" + tempProfileAge.getFullYear();
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
    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getUserResults',
        data: dataString,
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

            //parse time
            min = item.rTime.Minutes;
            sec = item.rTime.Seconds;
            if (item.rTime.Minutes < 10)
                min = "0" + item.rTime.Minutes;
            if (  item.rTime.Seconds < 10)
                sec = "0" + item.rTime.Seconds;

            //parse date
            var eventTime = parseInt(item["rDate"].split("(")[1].split(")")[0]);
            var eventStartDate = new Date(eventTime);
            var strDate = "";
            strDate += eventStartDate.getDate() + "/" + (eventStartDate.getMonth()+1) + "/" + eventStartDate.getFullYear();
            
            //parse type
            var resultType;
            if (item.ResultType == 1)
                resultType = "mdi mdi-swim";
            else if (item.ResultType == 2)
                resultType = "mdi mdi-run-fast";
            else
                resultType = "mdi mdi-clock-fast";

            //parse table
            var $tr = $('<tr>').append(
                $('<td>').html("<i class='"+resultType+"'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(min +":" + sec),
                $('<td>').text(strDate)
            ).appendTo('#ResultsTable');
        });
    });

}

//--------------------------------------------------------------------
//                           Events Page
//--------------------------------------------------------------------

//function getUserType() {
//    var request = getUserId();
//    dataString = JSON.stringify(request);

//    userType = $.ajax({
//        url: ASMXURL + 'getUserType',
//        data: dataString,
//        type: 'POST',
//        async: false,
//        dataType: 'json',
//        contentType: 'application/json; charset = utf-8',
       
//    }) // end of ajax call

//   return userType.responseJSON.d
//}

function getUserEvents() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    events = $.ajax({
        url: ASMXURL + 'getUserEvents',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8'
    }) // end of ajax call

    return events.responseJSON.d
}

function getCoachEvents() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    events = $.ajax({
        url: ASMXURL + 'getCoachEvents',
        data: dataString,
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

//---------------------------------//

function parseMessagesCountAthlete(results) {
    counter=0;
    str = "Showing " + (counter + 1) + " - ";
    if (((counter + 1) * 20) > results.d)
        str +=results.d;
    else
        str += ((counter + 1) * 20);
    str += " of " + results.d;
    $("#CountInbox").html(str);
}

function getUserMessages() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getUserMessages',
        data: dataString,
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

            //parse date
            var messageDate = parseInt(item["mDate"].split("(")[1].split(")")[0]);
            var messageStartDate = new Date(messageDate);
            var strDate = "";
            strDate += messageStartDate.getDate() + "/" + (messageStartDate.getMonth() + 1) + "/" + messageStartDate.getFullYear();

            //parse time
            min = item.mTime.Minutes;
            if (min < 10)
                min = "0" + item.mTime.Minutes;

            //parse table
            var messageid = item["MessageID"]
            var $tr = $('<tr class="email-msg">').append(
                $('<td>').html("<a class=''></a>").text(item.FirstName + " " + item.LastName),
                $('<td class="hidden-xs">').html("<a id='" + messageid + "' class='email-msg'>"+item.Title+"</a>"),
                $('<td class="text-right">').text(item.mTime.Hours + ":" + min),
                $('<td class="text-right">').text(strDate)
            ).appendTo('#InboxTable');
        });
    });   
}

function UserMessageModal() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getUserMessages',
        data: dataString,
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
    var request = getUserId();
    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getPicturePath',
        data: dataString,
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