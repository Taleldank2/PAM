//-----------------------------------------------------------------------
//                              Login JS
//------------------------------------------------------------------------
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
    alert("" + results.d);
    window.location = "index.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
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


//-----------------------------------------------------------------------
//Session handling only if the user try to navigate to Main directly 
//------------------------------------------------------------------------
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
    }) 

}

function checkSession(results) {
    
    response = results.d

    if (response == "true") {
        window.location = "index.html";
    }
}


