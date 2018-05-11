//----------------------------------------------------------------------------------------
//Session handling if the user is trying to navigate to pages before logging to the system
//----------------------------------------------------------------------------------------
$(document).ready(function () {

    cookie = document.cookie;

    arr = cookie.split("="); //cookie looks like this session=session=123142342-2342342-234234--234234

    if (arr.length == 3) {
        if (arr[0] == "session") {
            session = arr[2]; //aar[2] is the guid number
            checkUserExists(session);
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
    }) 

}

function checkSession(results) {
    
    response = results.d;

    // false = session is not exist
    if (response == "false") {
        window.location = "Login.html";
    }
    else
    {
        // Load Data to html on every page when session is verified
        if (window.location.pathname == "/index.html" || window.location.pathname == "/bgroup57/test1/tar1/index.html")
        {
            getCoachLastResults();
            getPicturePath();
            //getUserLastEvent();
            //getLastResult();
            //getMessagesCount(); 
            //getName();
        }
        else if (window.location.pathname == "/Results.html" || window.location.pathname == "/bgroup57/test1/tar1/Results.html")
        {
            getCoachResults();
            //getUserResults();
            getPicturePath();
        }
        else if (window.location.pathname == "/Profile.html" || window.location.pathname == "/bgroup57/test1/tar1/Profile.html") {
            getUserDetails();
            getPicturePath();
        }
        else if (window.location.pathname == "/Calendar.html" || window.location.pathname == "/bgroup57/test1/tar1/Calendar.html")
        {
            //getUserEvents() ---> jquery.fullcalendar.js is calling this function on page load
            getPicturePath();
        }
        else if (window.location.pathname == "/Inbox.html" || window.location.pathname == "/bgroup57/test1/tar1/Inbox.html")
        {
            getUserMessages();
            getPicturePath();
        }
    }
}

function err(e)
{
    alert(e);
    window.location = "Login.html";
}

function logOut()
{
    document.cookie = "session=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    document.location = "Login.html";
}

