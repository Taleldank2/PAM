document.getElementById("editBTN").onclick = profile;

//----------------------------------------------------------------------------------------
//                                      local - false if app mode
//                                              true if web mode
//----------------------------------------------------------------------------------------
var local = true;
var ASMXURL = 'WebService.asmx/';
if (!local) {
    ASMXURL = 'http://proj.ruppin.ac.il/bgroup57/test1/tar1/WebService.asmx/';
}

function profile() {

    document.getElementById("editBTN").remove();
    document.getElementById("confirmBTN").style.visibility = "visible";
    document.getElementById("cancelBTN").style.visibility = "visible";
    

    str = "<input id='mail' class='form-control' type='email' placeholder='אימייל' style='margin-bottom:5px'>";
    str += "<input id='city' class='form-control' type='text' placeholder='מגורים' style='margin-bottom:5px'>";
    str += "<input id='AthleteWeight' class='form-control' type='text' placeholder='משקל' style='margin-bottom:5px'>";
    str += "<input id='AthleteHeight' class='form-control' type='text' placeholder='גובה' style='margin-bottom:5px'>";
    str += "<input id='phonenumber' class='form-control' type='text' placeholder='מספר נייד' style='margin-bottom:5px'>";
    str += "<input id='pass' class='form-control' type='password' placeholder='סיסמא' style='margin-bottom:5px'>";
    str += "<input id='confirmPass' class='form-control' type='password' placeholder='אימות סיסמא' style='margin-bottom:5px'>";
    $('#profileDetails').html(str);
}

document.getElementById("cancelBTN").onclick = cancel;
document.getElementById("confirmBTN").onclick = confirm;


function cancel() {
    window.location = "Profile.html";
}

function confirm() {
    userPassword = $('#pass').val();
    userConfirmPassword = $('confirmPass').val();
    if (userPassword != userConfirmPassword)
    {
        alert("אימות סיסמא נכשל!")
        window.location = "Profile.html";
    }
    userPhoneNumber = $('#phonenumber').val();
    userMail = $('#mail').val();
   
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
        url: ASMXURL + 'update',
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
    window.location = "Profile.html";
}