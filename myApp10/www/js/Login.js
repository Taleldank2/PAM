

//-----------------------------------------------------------------------
//                       Remember me function
//-----------------------------------------------------------------------
$(document).ready(function () {

    if (localStorage["UserID"]) {
        window.location = "index.html"
    }

    if (localStorage["UserNumber"]) {
        $('#PhoneNumber').val(localStorage.UserNumber);
        localStorage.removeItem("UserNumber");
    }

    else if (localStorage.isChecked && localStorage.isChecked != '') {
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
        }
        else {
            localStorage.removeItem("username");
            localStorage.removeItem("pass");
            localStorage.removeItem("isChecked");
            //localStorage.username = '';
            //localStorage.pass = '';
            //localStorage.isChecked = '';
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

    ajaxLogin(request);
}

//-----------------------------------------------------------------------
//                              Login AJAX
//------------------------------------------------------------------------
function ajaxLogin(request) {
    //Serialize the object to JSON string
    var dataString = JSON.stringify(request);

    $.ajax({
        url: ASMXURL + 'Login',
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
    localStorage["UserID"] = JSON.parse(results.d).UserId;
    window.location = "index.html";
}

function errorCB(e) {
    alert("The exception message is: " + e.responseText);
}


//function checkUserExists(session) {
//    request = {
//        userSession: session,
//    };
//    var dataString = JSON.stringify(request);
//    $.ajax({
//        url: ASMXURL + 'checkUserSession',
//        data: dataString,
//        type: 'POST',
//        async: false,
//        dataType: 'json',
//        contentType: 'application/json; charset = utf-8',
//        success: checkSession,
//        error: checkSessionError
//    })
//}

//function checkSession(results) {
//    response = results.d;
//    if (response == "true") {
//        window.location = "index.html";
//    }
//}

//function checkSessionError(a, b, c) {
//    console.log(a);
//    console.log(b);
//    console.log(c);
//    alert('checkSessionError');
//}


