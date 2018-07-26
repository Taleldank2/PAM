document.getElementById("myForm").onsubmit = register;


//function getUserId() {
//    userIdNum = localStorage["UserID"];
//    request = {
//        userId: userIdNum
//    };
//    return request;
//}

function getMoreDetails() {
    getTeamsNames();
    AthleteDetails();
    if (localStorage["UserDetails"] == "true") {
        $('#phonenumber').val(localStorage.UserNumber);
        $('#userteam').attr(localStorage.UserTeam);
        $('#name').val(localStorage.UserName);
        $('#lastname').val(localStorage.UserLastName);
        $('#mail').val(localStorage.UserMail);
        $('#city').val(localStorage.UserCity);
        $('#birthday').val(localStorage.UserDate);
        $('#AthleteWeight').val(localStorage.UserWeight);
        $('#AthleteHeight').val(localStorage.UserHeight);
        $('#picture').val(localStorage.UserPic);

    }
}

function AthleteDetails() {
    str = "<div class='form-group'><div class='input-group'>" +
"<div class='input-group-prepend'><span class='input-group-text'>" +
"<i class='mdi mdi-weight-kilogram'></i></span></div>" +
"<input id='AthleteWeight' class='form-control' type='text' required='' placeholder='משקל'></div></div>";

    str += "<div class='form-group'><div class='input-group'>" +
    "<div class='input-group-prepend'><span class='input-group-text'>" +
    "<i class='mdi mdi-ruler'></i></span></div>" +
    "<input id='AthleteHeight' class='form-control' type='text' required='' placeholder='גובה במטרים (לדוגמא: 1.68)'></div></div>";

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
    alert("שמות הקבוצה לא יובאו");
}

function register() {
    try {
        if (localStorage["UserDetails"] != "true") {
            localStorage["UserDetails"] = "true";
            localStorage["UserNumber"] = $('#phonenumber').val();
            localStorage["UserTeam"] = $('#userteam').val();
            localStorage["UserName"] = $('#name').val();
            localStorage["UserLastName"] = $('#lastname').val();
            localStorage["UserMail"] = $('#mail').val();
            localStorage["UserCity"] = $('#city').val();
            localStorage["UserDate"] = $('#birthday').val();
            localStorage["UserWeight"] = $('#AthleteWeight').val();
            localStorage["UserHeight"] = $('#AthleteHeight').val();
            localStorage["UserPic"] = $('#picture')[0].files[0];
        }

        isChecked = document.getElementById("checkbox-signup").checked;
        if (isChecked == false) {
            alert("תחילה יש לאשר את תנאי השימוש");
            return;
        }

        if (($('#phonenumber').val()).length != 10) {
            alert("יש להכניס מספר נייד בעל עשר ספרות ללא רווחים וסימנים");
            localStorage.removeItem("UserNumber");
            return;
        }

        userPassword = $('#pass').val();
        userConfirmPassword = $('#passConfirm').val();
        if (userPassword != userConfirmPassword) {
            alert("אימות סיסמא נכשל!")
            return;
        }

        if (isNaN(parseInt($('#AthleteWeight').val())) ){
            alert("יש להכניס משקל עצמי כמספר עגול");
            localStorage.removeItem("UserWeight");
            return;
        }
        if (parseInt($('#AthleteWeight').val()) < 35 || parseInt($('#AthleteWeight').val()) > 150) {
            alert("יש להכניס את המשקל האמיתי :)");
            localStorage.removeItem("UserWeight");
            return;
        }

        if (parseInt($('#AthleteHeight').val()) != 1 ) {
            alert("יש להכניס גובה במטרים, למשל: 1.72");
            localStorage.removeItem("UserHeight");
            return;
        }

        file = $('#picture')[0].files[0];
        if (file == null) {
            localStorage.removeItem("UserPic");
            alert("לא תברח/י מזה ! יש להכניס תמונה");
            return;
        }
        var reader = new FileReader();

        reader.onload = function (e) {
            registerNewUser(e.target.result)
        };

        reader.readAsDataURL(file);
    }
    catch (e) {
        alert("תהליך נכשל !\n יש לפנות למנהל מעכת");
    }

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
    userBirthday = $('#birthday').val();
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
        "userBirthday": userBirthday,
        "userTeam": userTeam,
        "athleteWeight": athleteWeight,
        "athleteHeight": athleteHeight

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
        success: registerCompleted,
        error: errorCB
    })

    //userID = getUserId();

    //requestAthlete = {
    //    "userId": userID,
    //    "userTeam": userTeam,
    //    "athleteWeight": athleteWeight,
    //    "athleteHeight": athleteHeight
    //};

    //var dataStringAthlete = JSON.stringify(requestAthlete);


    //$.ajax({
    //    url: ASMXURL + 'registerAthlete',
    //    data: dataString,
    //    type: 'POST',
    //    async: false,
    //    dataType: 'json',
    //    contentType: 'application/json; charset = utf-8',
    //    success: registerCompleted,
    //    error: errorCB
    //})

    localStorage.removeItem("UserDetails");
    localStorage.removeItem("UserNumber");
    localStorage.removeItem("UserTeam");
    localStorage.removeItem("UserName");
    localStorage.removeItem("UserLastName");
    localStorage.removeItem("UserMail");
    localStorage.removeItem("UserCity");
    localStorage.removeItem("UserDate");
    localStorage.removeItem("UserWeight");
    localStorage.removeItem("UserHeight");
    localStorage.removeItem("UserPic");
}

function registerCompleted(result) {
    alert("ההרשמה בוצעה בהצלחה :)");
    window.location = "Login.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}
