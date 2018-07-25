document.getElementById("myForm").onsubmit = register;


function register() {

    isChecked = document.getElementById("checkbox-signup").checked;
    if (isChecked == false)
    {
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

    userType = 2;
    userTeam = $('#userteam').val();
    userName = $('#name').val();
    userLastName = $('#lastname').val();
    userPhoneNumber = $('#phonenumber').val();
    userMail = $('#mail').val();
    userPassword = $('#pass').val();
    userPicture = pictureBase64;
    userCity = $('#city').val();
    userBirthday = $('#datepicker').val();

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

    alert(dataString);

    $.ajax({
        url: ASMXURL+ 'register',
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