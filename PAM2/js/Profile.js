﻿document.getElementById("editBTN").onclick = profile;

function profile() {

    document.getElementById("confirmBTN").style.visibility = "visible";
    document.getElementById("editBTN").style.visibility = "hidden";

    str = "<input id='phonenumber' class='form-control' type='text' placeholder='מספר נייד' style='margin-bottom:5px'>";
    str += "<input id='mail' class='form-control' type='email' placeholder='אימייל' style='margin-bottom:5px'>";
    str += "<input id='city' class='form-control' type='text' placeholder='מגורים' style='margin-bottom:5px'>";
    str += "<input id='AthleteWeight' class='form-control' type='text' placeholder='משקל' style='margin-bottom:5px'>";
    str += "<input id='AthleteHeight' class='form-control' type='text' placeholder='גובה' style='margin-bottom:5px'>";
    str += "<input id='pass' class='form-control' type='password' placeholder='סיסמא' style='margin-bottom:5px'>";
    $('#profileDetails').html(str);
}


document.getElementById("confirmBTN").onclick = confirm;

function confirm() {

    userPhoneNumber = $('#phonenumber').val();
    userMail = $('#mail').val();
    userPassword = $('#pass').val();
    userCity = $('#city').val();
    athleteWeight = $('#AthleteWeight').val();
    athleteHeight = $('#AthleteHeight').val();

    request = {
        "phoneNumber": userPhoneNumber,
        "userMail": userMail,
        "userPassword": userPassword,
        "city": userCity,
        "athleteWeight": athleteWeight,
        "athleteHeight": athleteHeight
    };

    var dataString = JSON.stringify(request);

    alert(dataString);

    $.ajax({
        url: 'WebService.asmx/update',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: confirmCompleted,
        error: errorCB
    })
}

function confirmCompleted(result) {
    alert("שינויים נשמרו בהצלחה !")
    window.location = "Profile.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}