document.getElementById("myForm").onsubmit = register;

//----------------------------------------------------------------------------------------
//                                      local - false if app mode
//                                              true if web mode
//----------------------------------------------------------------------------------------
var local = true;
var ASMXURL = 'WebService.asmx/';
if (!local) {
    ASMXURL = 'http://proj.ruppin.ac.il/bgroup57/test1/tar1/WebService.asmx/';
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
    file = $('#picture')[0].files[0];

    var reader = new FileReader();

    reader.onload = function (e) {
        registerNewUser(e.target.result)
    };

    reader.readAsDataURL(file);
}

function registerNewUser(pictureBase64) {

    userType = $('#usertype').val();
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
        "userTeam": userTeam,
        "userName": userName,
        "userLastName": userLastName,
        "phoneNumber": userPhoneNumber,
        "userMail": userMail,
        "userPassword": userPassword,
        "userPicBase64": userPicture,
        "city": userCity,
        "userBirthday": userBirthday,
        "athleteWeight": athleteWeight,
        "athleteHeight": athleteHeight
    };

    var dataString = JSON.stringify(request);

    alert(dataString);

    $.ajax({
        url: ASMXURL + 'register',
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

function AthleteDetails(index) {
    if (index == 2) {
        getTeamsNames();
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
    else {
        str = "";
        $('#AthleteFileds').html(str);
        $('#TeamsNamesDDL').html(str);
    }

}