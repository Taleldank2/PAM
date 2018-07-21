//----------------------------------------------------------------------------------------
//                                      local - false if app mode
//                                              true if web mode
//----------------------------------------------------------------------------------------
var local = true;
var ASMXURL = 'WebService.asmx/';
if (!local) {
    ASMXURL = 'http://proj.ruppin.ac.il/bgroup57/test1/tar1/WebService.asmx/';
}



//--------------------------------------------------------------------
//                            index Page
//--------------------------------------------------------------------

function getUserLastEvent() {
    $.ajax({
        url: ASMXURL+ 'getUserLastEvent',
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


function getName() {
    $.ajax({
        url: ASMXURL+ 'getName',
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
        url: ASMXURL+ 'getUserDetails',
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

    var birthDate = parseInt(results[0]["BirthDate"].split("(")[1].split(")")[0]);
    var tempProfileAge = new Date(birthDate);
    strProfileAge = tempProfileAge.getDate() + "/" + (tempProfileAge.getMonth()+1) + "/" + tempProfileAge.getFullYear();
    $("#ProfileAge").append(strProfileAge);
    
    strProfileCity = results[0].City;
    $("#ProfileCity").append(strProfileCity);

    strProfileEmail = results[0].Email;
    $("#ProfileEmail").append(strProfileEmail);
    
    strProfilePhone = results[0].PhoneNumber;
    $("#ProfilePhone").append(strProfilePhone);
    
}


//--------------------------------------------------------------------
//                           Results Page
//--------------------------------------------------------------------

function getUserResults() {
    $.ajax({
        url: ASMXURL+ 'getUserResults',
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
        url: ASMXURL+ 'getUserType',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
       
    }) // end of ajax call

   return userType.responseJSON.d
}

function getUserEvents() {

    events = $.ajax({
        url: ASMXURL+ 'getUserEvents',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8'
    }) // end of ajax call

    return events.responseJSON.d
}

function getCoachEvents() {

    events = $.ajax({
        url: ASMXURL+ 'getCoachEvents',
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8'
    }) // end of ajax call

    return events.responseJSON.d
}

function addEvent() {

    var EventType = $('#EventModalTitle').val()
    alert(EventType);

    eventName = $('#EventName').val();
    eventDate = $('#EventDate').val();
    startTime = $('#StartTime').val();
    endTime = $('#EndTime').val();
    eventDesc = $('#EventDesc').val();
    eventType = EventType;
    eventLocation = $('#EventLocation').val();

    request = {
        "eventName": eventName,
        "eventDate": eventDate,
        "startTime": startTime,
        "endTime": endTime,
        "eventDesc": eventDesc,
        "eventType": eventType,
        "eventLocation": eventLocation,
        
    };

    var dataString = JSON.stringify(request);

    alert(dataString);

    $.ajax({
        url: ASMXURL+ 'addEvent',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: addEventCompleted,
        error: errorCB
    })

    function addEventCompleted(result) {
        alert(result);
        results = $.parseJSON(result.d);
        alert(result[0]);
        alert("אירוע חדש נקלט בהצלחה");
        
    }

    function errorCB(e) {
        alert("The exception message is : " + e.responseText);
    }

    

}



//--------------------------------------------------------------------
//                             Register
//--------------------------------------------------------------------
function getPicturePath() {
    $.ajax({
        url: ASMXURL+ 'getPicturePath',
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


//---------------------------------//

function getCoachLastResults() {
    $.ajax({
        url: ASMXURL+ 'getCoachLastResults',
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
    $(function () {
        $.each(results, function (i, item) {

            //parse time
            min = item.rTime.Minutes;
            sec = item.rTime.Seconds;
            if (item.rTime.Minutes < 10)
                min = "0" + item.rTime.Minutes;
            if (item.rTime.Seconds < 10)
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
                 $('<td>').text(item.FirstName+" "+item.LastName),
                $('<td>').html("<i class='" + resultType + "'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(min + ":" + sec),
                $('<td>').text(strDate)
            ).appendTo('#ResultsTableDashboard');
        });
    });
    
}


//---------------------------------//

function getCoachLastMessages() {

    $.ajax({
        url: ASMXURL+ 'getCoachLastMessages',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseCoachLastMessages
    })
}

function parseCoachLastMessages(results) {
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
            if (min == 0)
                min = "00";
            else if (min < 10)
                min = "0" + item.mTime.Minutes;

            //parse table
            var messageid = item["MessageID"]
            var $tr = $('<tr class="email-msg">').append(
                $('<td>').html("<a class=''></a>").text(item.TeamName),
                $('<td class="hidden-xs">').html("<a id='" + messageid + "' class='email-msg'>" + item.Title + "</a>"),
                $('<td class="text-right">').text(item.mTime.Hours + ":" + min),
                $('<td class="text-right">').text(strDate)
            ).appendTo('#MessagesTableDashboard');
        });
    });
}


//---------------------------------//


//--------------------------------------------------------------------
//                             Results
//--------------------------------------------------------------------
function getCoachResults() {
    $.ajax({
        url: ASMXURL+ 'getCoachResults',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseCoachResluts,
        error: errorCoachResults
    }) // end of ajax call
}

function errorCoachResults(e) {
    alert(e.responseText);
}

function parseCoachResluts(results) {
    results = $.parseJSON(results.d);
    $(function () {
        $.each(results, function (i, item) {

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

            //parse time
            min = item.rTime.Minutes;
            sec = item.rTime.Seconds;
            if (item.rTime.Minutes < 10)
                min = "0" + item.rTime.Minutes;
            if (item.rTime.Seconds < 10)
                sec = "0" + item.rTime.Seconds;

            //parse note
            if (item.Note == null)
                note = "";
            else
                note = item.Note;

            //parse table
            var $tr = $('<tr>').append(
                 $('<td>').text(item.FirstName + " " + item.LastName),
                $('<td>').html("<i class='" + resultType + "'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(min + ":" + sec),
                $('<td>').text(strDate),
                $('<td>').text(note)
            ).appendTo('#ResultsTable');
        });
    });

}


//--------------------------------------------------------------------
//                           Messages
//--------------------------------------------------------------------

//---------------------------------//

function getMessagesCount() {
    $.ajax({
        url: ASMXURL+ 'getMessagesCount',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseMessagesCount
    })
}

function parseMessagesCount(results) {
    counter = 0;
    str = "Showing " + (counter + 1) + " - ";
    if (((counter + 1) * 20) > results.d)
        str += results.d;
    else
        str += ((counter + 1) * 20);
    str += " of " + results.d;
    $("#CountInbox").html(str);
}
;                                                                                                                       

function getCoachMessages() {

    $.ajax({
        url: ASMXURL+ 'getCoachMessages',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseCoachMessages
    })
}

function parseCoachMessages(results) {
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
            var messageid = item["MessageID"];
            var $tr = $('<tr class="email-msg">').append(
                $('<td>').html("<a class=''></a>").text(item.TeamName),
                $('<td class="text-right">').text(item.Title),
                $('<td class="text-right">').text(item.mBody),
                $('<td class="text-right">').text(item.mTime.Hours + ":" + min),
                $('<td class="text-right">').text(strDate)
            ).appendTo('#MessagesTable');
        });
    });
}

//function UserMessageModal() {

//    $.ajax({
//        url: ASMXURL+ 'getUserMessages',
//        type: 'POST',
//        async: true,
//        dataType: 'json',
//        contentType: 'application/json; charset = utf-8',
//        success: parseUserMessageModal,
//        error: messageModalError

//    });

//}

//function parseUserMessageModal(results) {

//    //Convert results back to JSON
//    results = $.parseJSON(results.d);

//    //Go Over the results;
//    for (var i = 0; i < results.length; i++) {
//        if (results[i].MessageID == MessageInfo.id) {
//            //load values to data modal
//            document.getElementById("messageModalTitle").innerText = results[i].Title;
//            document.getElementById("messageModalBody").innerText = results[i].mBody;
//            //open modal
//            $('#message-modal').modal('show');
//            return;
//        }

//    }
//    alert("Could not find message");
//}

//function messageModalError(a, b, c) {
//    console.log(a);
//    console.log(b);
//    console.log(c);
//    alert('getUserMessagesbyID() error');
//}