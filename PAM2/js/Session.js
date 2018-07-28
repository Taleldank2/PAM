
//----------------------------------------------------------------------------------------
//Session handling if the user is trying to navigate to pages before logging to the system
//----------------------------------------------------------------------------------------
$(document).ready(function () {

    if (localStorage["UserID"] == null) {
        alert("move back to login page");
        window.location = "Login.html";
    }

    else {
        // Load Data to html on every page when session is verified
        if (window.location.pathname == "/android_asset/www/index.html" || window.location.pathname == "/index.html" || window.location.pathname == "/bgroup57/test1/tar1/index.html" || window.location.pathname == "/") {
            getCoachLastResults();
            getPicturePath();
            getCoachLastMessages();
        }
        else if (window.location.pathname == "/android_asset/www/Results.html" || window.location.pathname == "/Results.html" || window.location.pathname == "/bgroup57/test1/tar1/Results.html") {
            getCoachResults();
            getPicturePath();
        }
        else if (window.location.pathname == "/android_asset/www/Profile.html" || window.location.pathname == "/Profile.html" || window.location.pathname == "/bgroup57/test1/tar1/Profile.html") {
            getUserDetails();
            getPicturePath();
        }
        else if (window.location.pathname == "/android_asset/www/Calendar.html" || window.location.pathname == "/Calendar.html" || window.location.pathname == "/bgroup57/test1/tar1/Calendar.html") {
            //getUserEvents() ---> jquery.fullcalendar.js is calling this function on page load
            getPicturePath();
            getCoachCalTeams();
            //getCoachTeams();
        }
        else if (window.location.pathname == "/android_asset/www/Inbox.html" || window.location.pathname == "/Inbox.html" || window.location.pathname == "/bgroup57/test1/tar1/Inbox.html") {
            getCoachMessages();
            getMessagesCount();
            getPicturePath();
        }
        else if (window.location.pathname == "/android_asset/www/Attendance.html" || window.location.pathname ==  "/Attendance.html" || window.location.pathname == "/bgroup57/test1/tar1/Attendance.html") {
            getEventsList();
            getPicturePath();
        }
    }
});

//function checkUserExists(session) {
//    request = {
//        userSession: session,
//    };
//    var dataString = JSON.stringify(request);
//    $.ajax({
//        url: ASMXURL+ 'checkUserSession',
//        data: dataString,
//        type: 'POST',
//        async: false,
//        dataType: 'json',
//        contentType: 'application/json; charset = utf-8',
//        success: checkSession,
//        error: err
//    }) 
//}

function err(e)
{
    alert(e);
    window.location = "Login.html";
}

function logOut()
{
    localStorage.removeItem("UserID");
    document.location = "Login.html";
}

