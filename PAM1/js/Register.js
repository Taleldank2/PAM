document.getElementById("myForm").onsubmit = register;

function register() {
    file = $('#picture')[0].files[0]

    var reader = new FileReader();


    reader.onload = function (e) {
        registerNewUser(e.target.result)
    };

    reader.readAsDataURL(file)
}

function registerNewUser(pictureBase64) {

    userType = $('#usertype').val()
    userName = $('#name').val()
    userLastName = $('#lastname').val()
    userPhoneNumber = $('#phonenumber').val()
    userMail = $('#mail').val()
    userPassword = $('#pass').val()
    userPicture = pictureBase64
    userCity = $('#city').val()
    userBirthday = $('#datepicker').val()
    athleteWeight = $('#AthleteWeight').val()
    athleteHeight = $('#AthleteHeight').val()

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
        "athleteWeight": athleteWeight,
        "athleteHeight": athleteHeight

    };

    var dataString = JSON.stringify(request);


    alert(dataString);


    $.ajax({
         url: 'WebService.asmx/register',
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
    alert("ההרשמה בוצעה בהצלחה :)")
    window.location = "Login.html";
}

function errorCB(e) {
    alert("The exception message is : " + e.responseText);
}

function AthleteDetails(index) {
    if (index == 2) {
        str = "<div class='form-group'><div class='input-group'>" +
    "<div class='input-group-prepend'><span class='input-group-text'>" +
    "<i class='mdi mdi-key'></i></span></div>" +
    "<input id='AthleteWeight' class='form-control' type='text' required='' placeholder='משקל'></div></div>";

        str += "<div class='form-group'><div class='input-group'>" +
        "<div class='input-group-prepend'><span class='input-group-text'>" +
        "<i class='mdi mdi-key'></i></span></div>" +
        "<input id='AthleteHeight' class='form-control' type='text' required='' placeholder='גובה'></div></div>";

        $('#filedsAccount').append(str);
    }
    else {
        str = "";
        $('#filedsAccount').html(str);
    }

}