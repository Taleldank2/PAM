


function getUserLastEvent() {

    $.ajax({
        url: 'WebService.asmx/getUserLastEvent',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseLastEvent
    }) // end of ajax call

}

function parseLastEvent(results)
{
    alert(results.d);
}

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
    alert(results.d);
}

function getMessagesCount() {

    $.ajax({
        url: 'WebService.asmx/getMessagesCount',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseMessagesCount
    }) // end of ajax call

}


function parseMessagesCount(results) {
    alert(results.d);
}

function getScore() {

    $.ajax({
        url: 'WebService.asmx/getScore',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: parseScore
    }) // end of ajax call

}


function parseScore(results) {
    alert(results.d);
}



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
}

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
    alert(results.d);
}


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
    alert(results.d);

}


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
