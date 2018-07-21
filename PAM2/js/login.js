//----------------------------------------------------------------------------------------
//                                      local - false if app mode
//                                              true if web mode
//----------------------------------------------------------------------------------------
var local = true;
var ASMXURL = 'WebService.asmx/';
if (!local) {
    ASMXURL = 'http://proj.ruppin.ac.il/bgroup57/test1/tar1/WebService.asmx/';
}

//-----------------------------------------------------------------------
//                              Remember me function
//-----------------------------------------------------------------------
$(document).ready(function () {

    if (localStorage.isChecked && localStorage.isChecked != '') {
        $('#checkbox-signup').attr('checked', 'checked');
        $('#PhoneNumber').val(localStorage.username);
        $('#Password').val(localStorage.pass);
    }
    else {
        $('#checkbox-signup').removeAttr('checked');
        $('#PhoneNumber').val('');
        $('#Password').val('');
    }

    $('#checkbox-signup').click(function () {

        if ($('#checkbox-signup').is(':checked')) {
            // save username and password
            localStorage.username = $('#PhoneNumber').val();
            localStorage.pass = $('#Password').val();
            localStorage.isChecked = $('#checkbox-signup').val();
        } else {
            localStorage.username = '';
            localStorage.pass = '';
            localStorage.isChecked = '';
        }
    });
});
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
        url: ASMXURL+ 'Login',
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
    results = $.parseJSON(results.d);
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
        url: ASMXURL+ 'checkUserSession',         
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