//--------------------------------------------------------------------
//                            get the user id
//--------------------------------------------------------------------

function getUserId() {
    userIdNum = localStorage["UserID"];
    request = {
        coachId: userIdNum
    };
    return request;
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

    var birthDate = parseInt(results[0]["BirthDate"].split("(")[1].split(")")[0]);
    var tempProfileAge = new Date(birthDate);
    strProfileAge = tempProfileAge.getDate() + "/" + (tempProfileAge.getMonth() + 1) + "/" + tempProfileAge.getFullYear();
    $("#ProfileAge").append(strProfileAge);

    strProfileCity = results[0].City;
    $("#ProfileCity").append(strProfileCity);

    strProfileEmail = results[0].Email;
    $("#ProfileEmail").append(strProfileEmail);

    strProfilePhone = results[0].PhoneNumber;
    $("#ProfilePhone").append(strProfilePhone);

}


//--------------------------------------------------------------------
//                           Events Page
//--------------------------------------------------------------------

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

function addEvent() {

    teamId = $('#CalTeams option:selected');


    eventName = $('#EventName').val();
    eventDate = $('#EventDate').val();
    startTime = $('#StartTime').val();
    endTime = $('#EndTime').val();
    eventDesc = $('#EventDesc').val();
    eventType = EventType.value;
    eventLocation = $('#EventLocation').val();

    request = {
        "teamId": teamId[0].value,
        "eventName": eventName,
        "eventDate": eventDate,
        "startTime": startTime,
        "endTime": endTime,
        "eventDescription": eventDesc,
        "eventType": eventType,
        "eventLocation": eventLocation,
    };

    var dataString = JSON.stringify(request);

    //alert(dataString);

    $.ajax({
        url: ASMXURL + 'addEvent',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: addEventCompleted,
        error: errorCB
    })

}

function addEventCompleted(result) {
    results = $.parseJSON(result.d);
    alert(results);
    window.location = "Calendar.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}

function getCoachCalTeams() {
    var request = getUserId();

    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getCoachTeams',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: updateCoachCalTeams
    })
}

function updateCoachCalTeams(response) {
    teams = JSON.parse(response.d)

    for (i = 0; i < teams.length; i++) {
        teamID = teams[i].TeamID;
        teamName = teams[i].TeamName;
        $("#CalTeams").append("<option value='" + teamID + "'>" + teamName + "</option>")
    }
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

//--------------------------------------------------------------------
//                             Dashboard
//--------------------------------------------------------------------


function getCoachLastResults() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getCoachLastResults',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseCoachLastResluts,
        error: errorCoachLastResults
    }) // end of ajax call
}

function errorCoachLastResults(e) {
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
            strDate += eventStartDate.getDate() + "/" + (eventStartDate.getMonth() + 1) + "/" + eventStartDate.getFullYear();

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
                 $('<td>').text(item.FirstName + " " + item.LastName),
                $('<td>').html("<i class='" + resultType + "'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(min + ":" + sec),
                $('<td>').text(strDate)
            ).appendTo('#ResultsTableDashboard');
        });
    });

}

function getCoachLastMessages() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getCoachLastMessages',
        data: dataString,
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



//--------------------------------------------------------------------
//                             Results
//--------------------------------------------------------------------

function getCoachResults() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getCoachResults',
        data: dataString,
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
            strDate += eventStartDate.getDate() + "/" + (eventStartDate.getMonth() + 1) + "/" + eventStartDate.getFullYear();

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


function sendMessage() {

    teams = []

    teamList = $('#teams option:selected')

    for (i = 0 ; i < teamList.length; i++) {
        teams.push(teamList[i].value)
    }

    title = $('#Title').val()
    message = $('#Message').val()

    request = {
        "coachId": getUserId(),
        "title": title,
        "message": message,
        "teamIds": teams
    };

    var dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'createMessage',
        type: 'POST',
        data: dataString,
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: function () {
            alert("הודעה נשלחה בהצלחה");
            window.location = "/Inbox.html";
        },
        error: function (response) {
            console.log("bad " + response.responseJSON.Message)
            debugger;
        }
    })
}

function getCoachTeams() {
    var request = getUserId();

    dataString = JSON.stringify(request);
    $.ajax({
        url: ASMXURL + 'getCoachTeams',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: updateCoachTeams
    })
}

function updateCoachTeams(response) {
    teams = JSON.parse(response.d)

    for (i = 0; i < teams.length; i++) {
        teamID = teams[i].TeamID;
        teamName = teams[i].TeamName;

        $("#teams").append("<option value='" + teamID + "'>" + teamName + "</option>")
    }

    $('#teams').multipleSelect();
}

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
    counter = 0;
    str = "Showing " + (counter + 1) + " - ";
    if (((counter + 1) * 20) > results.d)
        str += results.d;
    else
        str += ((counter + 1) * 20);
    str += " of " + results.d;
    $("#CountInbox").html(str);
}

function getCoachMessages() {
    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getCoachMessages',
        data: dataString,
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


//--------------------------------------------------------------------
//                           Attendance
//--------------------------------------------------------------------


function getEventsList() {

    var request = getUserId();
    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getTodayEvents',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseTodayEvents
    })
}

function parseTodayEvents(results) {
    results = $.parseJSON(results.d);

    $(function () {
        var str = "<div class='form-group'><div class='input-group'><div class='input-group-prepend'>" +
                "<span class='input-group-text'><i class='mdi mdi-flash'></i></span></div>" +
                "<select onchange='getEventMembers()' id='todayEvents' class='form-control select2 select2-hidden-accessible' tabindex='-1' " +
                "aria-hidden='true'><option value='' disabled selected>בחר אימון</option> ";
        $.each(results, function (i, item) {
            str += "<option value=" + item.EventID + ">" + item.Title + "</option>";
        });
        str += "</select></div> </div>";
        $('#EventsDDL').append(str);
    });
}

function getEventMembers() {

    eventId = $('#todayEvents').find(":selected").val();
    var request = {
        EventId: eventId
    };

    dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'getEventMembers',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseEventMembers
    })

}

function parseEventMembers(results) {
    document.getElementById("confirmBTN").style.visibility = "visible";
    results = $.parseJSON(results.d);
    $(function () {
        $('#athletesTable').html("");
        $.each(results, function (i, item) {

            //parse table
            var $tr = $('<tr class="email-msg">').append(
                $('<td>').html("<input type='checkbox' checked='checked' id='" + item.UserID + "' />"),
                $('<td>').html("<a class=''></a>").text(item.FirstName + " " + item.LastName)
            ).appendTo('#athletesTable');
        });
    });
}

//document.getElementById("confirmBTN").onclick = sendList();

function sendList() {


    //Create object arraט to cintain the rows data
    var attendanceArr = [];

    //Go over list and create object for each row

    $('input[type=checkbox]').each(function () {

        //decleration
        var eventId;
        var athleteId;
        var present;
        var note;

        //user is not attend by deafult
        var userId = (this.attributes[2].value);
        var isChecked = 0

        if (this.attributes[1] = 'checked') {
            isChecked = 1
        }

        //Create object for each row
        var row = {
            athleteId: userId,
            eventId: 1,
            present: isChecked,
            note: "some note"
        }

        //insert the the object to the array
        attendanceArr.push(row);

    });

    //send list to database
    dataString = JSON.stringify({ 'attendanceArr': attendanceArr });
    console.log(dataString);


    $.ajax({
        url: ASMXURL + 'insertAttendance',
        data: dataString,
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: function (response) {
            console.log("good " + response.responseJSON.Message)
        },
        error: function (response) {
            console.log("bad " + response.responseJSON.Message)
            debugger;
        }
    }) // end of ajax call


}