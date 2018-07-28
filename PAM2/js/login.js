

//-----------------------------------------------------------------------
//                              Remember me function
//-----------------------------------------------------------------------
$(document).ready(function () {

    if (localStorage["UserID"]) {
        window.location = "index.html";
    }


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

    ajaxLogin(request);
}


//-----------------------------------------------------------------------
//                              Login AJAX
//------------------------------------------------------------------------
function ajaxLogin(request) {
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
    //results = $.parseJSON(results.d);
    localStorage["UserID"] = JSON.parse(results.d).UserId;
    window.location = "index.html";
}

function errorCB(e) {
    alert("The exception message is: " + e.responseText);
}
