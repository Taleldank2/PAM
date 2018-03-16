//--------------------------------------------------------------------
//                            Main Page
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
        success: parseScore
    }) 

}

function parseScore(results) {
    
    str = results.d;
    $("#MainAppScore").html(str);
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
    alert("Name:" + results.d);
    str = results.d;
    $("#MainWelcome").append(" "+str);
}

//---------------------------------//


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
    }) // end of ajax call

}

function parseUserResults(results) {
    alert(results.d);
    results = $.parseJSON(results.d);
    $(function () {
        $.each(results, function (i, item) {
            var $tr = $('<tr>').append(
                $('<td>').html("<i class='mdi mdi-access-point'></i>"),
                $('<td>').text(item.Distance),
                $('<td>').text(item.rTime.Minutes +":" + item.rTime.Seconds),
                $('<td>').text(item.rDate)
            ).appendTo('#ResultsTable');
            //console.log($tr.wrap('<p>').html());
        });
    });
    //$("#ResultsTable").append(str);

}

//--------------------------------------------------------------------
//                           Events Page
//--------------------------------------------------------------------

function getUserEvents() {

    $.ajax({
        url: 'WebService.asmx/getUserEvents',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseUserEvents
    }) // end of ajax call

}

function parseUserEvents(results) {
    alert("events: "+results.d);
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
    }) // end of ajax call

}


function parseUserMessages(results) {
    results = $.parseJSON(results.d);
    $(function () {
        alert("Im in inbox function!!!!")
        $.each(results, function (i, item) {
            var str=item.mDate.toString();
            var $tr = $('<tr>').append(
                $('<td>').html("<a class='email-name'></a>").text(item.CreatorId),
                $('<td class="hidden-xs">').html("<a class='email-msg'></a>").text(item.Title),
                $('<td class="text-right">').text(item.mTime.Minutes + ":" + item.mTime.Seconds),
                $('<td class="text-right">').text(str)
            ).appendTo('#InboxTable');
            //console.log($tr.wrap('<p>').html());
        });
    });   
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

        profileImg = $('#profileimage')
        profileImg.attr("src", data)

    });
}
