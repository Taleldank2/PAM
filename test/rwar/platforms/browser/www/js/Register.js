document.getElementById("myForm").onsubmit = register;


function getUserId() {
    userIdNum = localStorage["UserID"];
    request = {
        userId: userIdNum
    };
    return request;
}

function getMoreDetails() {
    getTeamsNames();
    AthleteDetails();
}

function AthleteDetails() {
    str = "<div class='form-group'><div class='input-group'>" +
"<div class='input-group-prepend'><span class='input-group-text'>" +
"<i class='mdi mdi-weight-kilogram'></i></span></div>" +
"<input id='AthleteWeight' class='form-control' type='text' required='' placeholder='משקל'></div></div>";

    str += "<div class='form-group'><div class='input-group'>" +
    "<div class='input-group-prepend'><span class='input-group-text'>" +
    "<i class='mdi mdi-ruler'></i></span></div>" +
    "<input id='AthleteHeight' class='form-control' type='text' required='' placeholder='גובה'></div></div>";

    $('#AthleteFileds').append(str);

}

function getTeamsNames() {

    $.ajax({
        url: ASMXURL + 'getTeamsNames',
        type: 'POST',
        async: true,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: getTeamsNamesCompleted,
        error: getTeamsNamesFailed
    })
}

function getTeamsNamesCompleted(results) {
    results = $.parseJSON(results.d);
    str = "<div class='form-group'><div class='input-group'><div class='input-group-prepend'>" +
                    "<span class='input-group-text'><i class='mdi mdi-swim'></i></span></div>" +
                    "<select id='userteam' class='form-control select2 select2-hidden-accessible' tabindex='-1'" +
                    "aria-hidden='true' ><option value='' disabled selected> בחר קבוצה </option> ";
    for (var i = 0; i < results.length; i++) {
        str += "<option value=" + results[i].TeamID + " >" + results[i].TeamName + "</option>";
    }
    str += "</select></div> </div>";
    $('#TeamsNamesDDL').append(str);
}

function getTeamsNamesFailed() {
    alert("שמות קבוצה לא יובאו");
}

function register() {

    isChecked = document.getElementById("checkbox-signup").checked;
    if (isChecked == false) {
        alert("תחילה יש לאשר את תנאי השימוש");
        return;
    }

    file = $('#picture')[0].files[0];

    var reader = new FileReader();

    reader.onload = function (e) {
        registerNewUser(e.target.result)
    };

    reader.readAsDataURL(file);
}



function registerNewUser(pictureBase64) {

    userType = 1;
    userTeam = $('#userteam').val();
    userName = $('#name').val();
    userLastName = $('#lastname').val();
    userPhoneNumber = $('#phonenumber').val();
    userMail = $('#mail').val();
    userPassword = $('#pass').val();
    userPicture = pictureBase64;
    userCity = $('#city').val();
    userBirthday = $('#datepicker').val();
    athleteWeight = $('#AthleteWeight').val();
    athleteHeight = $('#AthleteHeight').val();

    request = {
        "userType": userType,
        "userName": userName,
        "userLastName": userLastName,
        "phoneNumber": userPhoneNumber,
        "userMail": userMail,
        "userPassword": userPassword,
        "userPicBase64": userPicture,
        "city": userCity,
        "userBirthday": userBirthday
       
    };

    var dataString = JSON.stringify(request);

   

    //alert(dataString);

    $.ajax({
        url: ASMXURL + 'register',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        //success: registerCompleted, ----use after athlere register
        error: errorCB
    })

    userID=getUserId();

    requestAthlete = {
        "userId": userID,
        "userTeam": userTeam,
        "athleteWeight": athleteWeight,
        "athleteHeight": athleteHeight
    };

    var dataStringAthlete = JSON.stringify(requestAthlete);


    $.ajax({
        url: ASMXURL + 'registerAthlete',
        data: dataString,
        type: 'POST',
        async: false,
        dataType: 'json',
        contentType: 'application/json; charset = utf-8',
        success: registerCompleted,
        error: errorCB
    })

}

function registerCompleted(result) {
    alert("ההרשמה בוצעה בהצלחה :)");
    window.location = "Login.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}
