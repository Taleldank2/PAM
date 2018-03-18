 //----------------------------------------------------------------------------------------
//Session handling if the user is trying to navigate to pages before logging to the system
//----------------------------------------------------------------------------------------
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
    
    response = results.d

    if (response == "false") {
        window.location = "Login.html";
    }
    else
    {
        // Load Data to html on every page when session is verified.
        if (window.location.pathname == "/index.html")
        {
            getPicturePath()
            getUserLastEvent()
            getLastResult()
            getMessagesCount()
            getScore()
            getName()
        }
        else if (window.location.pathname == "/Results.html")
        {
            getUserResults()
            getPicturePath()
        }
        else if (window.location.pathname == "/Calendar.html")
        {
            //getUserEvents()
            getPicturePath()
        }
        else if (window.location.pathname == "/Inbox.html")
        {
            getUserMessages()
            getPicturePath()
        }
    }
}

function err(e)
{
    alert(e)
    window.location = "Login.html";
}

function logOut()
{
    document.cookie = "session=;expires=Thu, 01 Jan 1970 00:00:00 UTC";
    document.location = "Login.html";
}

