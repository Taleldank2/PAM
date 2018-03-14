//-----------------------------------------------------------------------
//                              Login
//-----------------------------------------------------------------------------
// Login
//-----------------------------------------------------------------------------//-----------------------------------------------------------------------
function Login() {

    PhoneNumber = document.getElementById("PhoneNumber").value;
    Password = document.getElementById("Password").value;

    request = {
        phoneNumber: PhoneNumber,
        password: Password
    };

    ajaxLogin(request, successCB, errorCB);

}


function successCB(results) {
    //this is the callBackFunc
    alert("" + results.d);
    window.location = "Main.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}


function ajaxLogin(request, successCB, errorCB) {

    // serialize the object to JSON string
    var dataString = JSON.stringify(request);

    $.ajax({
        url: 'WebService.asmx/Login',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: successCB,
        error: errorCB
    }) // end of ajax call
}

$(document).ready(function () {
    
    cookie = document.cookie

    arr = cookie.split("=")

    if (arr.length==3)
    {
        if (arr[0] == "session")
        {
            session = arr[2]

            checkUserExists(session)
        }
    }

});

function checkUserExists(session)
{
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
        success: checkSession
    }) // end of ajax call

}

function checkSession(results) {
    //this is the callBackFunc
    response = results.d

    if (response == "true") {
        window.location = "Main.html";
    }
}


