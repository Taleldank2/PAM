//-----------------------------------------------------------------------
//                              Login JS
//-----------------------------------------------------------------------

function Login() {
    PhoneNumber = document.getElementById("PhoneNumber").value;
    Password = document.getElementById("Password").value;
    request = {
        phoneNumber: PhoneNumber,
        password: Password
    };

    ajaxLogin(request, successCB, errorCB);
}



//-----------------------------------------------------------------------
//                              Login AJAX
//------------------------------------------------------------------------
function ajaxLogin(request, successCB, errorCB) {
    //Serialize the object to JSON string
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
    }) 
}

function successCB(results) {
    alert(results.d);
    results = $.parseJSON(results.d);
    alert(results);
    if (results == "2") {
        window.location = "MasterPage.html";
    }
    else
        window.location = "index.html";
}

function errorCB(e) {
    alert("The exception message is: " + e.responseText);
}



//-----------------------------------------------------------------------
//Session handling only if the user try to navigate to Main directly 
//------------------------------------------------------------------------
$(document).ready(function () {
    
    cookie = document.cookie;

    arr = cookie.split("=");

    if (arr.length==3)
    {
        if (arr[0] == "session")
        {
            session = arr[2];
            checkUserExists(session);
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
        success: checkSession,
        error:checkSessionError
    }) 
}

function checkSession(results) {
    response = results.d;
    if (response == "true") {
        window.location = "index.html";
    }
}

function checkSessionError(a,b,c) {
    console.log(a);
    console.log(b);
    console.log(c);
    alert('checkSessionError');
}


