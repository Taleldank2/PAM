$(document).ready(function () {

    cookie = document.cookie

    arr = cookie.split("=")

    if (arr.length == 3) {
        if (arr[0] == "session") {
            session = arr[2]

            checkUserExists(session)
        }
        else {
            window.location = "Login.html";
        }
    }
    else
    {
        window.location = "Login.html";
    }

});

function checkUserExists(session) {
    request = {
        userSession: session,
    };

    var dataString = JSON.stringify(request);

    $.ajax({
        url: 'WebService.asmx/checkUserSession',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: checkSession,
        error: err
    }) // end of ajax call

}

function checkSession(results) {
    //this is the callBackFunc
    response = results.d

    if (response == "false") {
        window.location = "Login.html";
    }
    else
    {
        // Load Data to html on every page when session is verified.
        if (window.location.pathname == "/Main.html")
        {
            getPicturePath()
            getUserLastEvent()
            getLastResult()
            getMessagesCount()
            getScore()
        }
        else if (window.location.pathname == "/Results.html")
        {
            getUserResults()
        }
        else if (window.location.pathname == "/Calender.html")
        {
            getUserEvents()
        }
        else if (window.location.pathname == "/Inbox.html")
        {
            getUserMessages()
        }
    }
}

function err(e)
{
    alert(e)
    window.location = "Login.html";
}

