function Login() {

    PhoneNumber = document.getElementById("PhoneNumber").value;
    Password = document.getElementById("Password").value;

    request = {
        phoneNumber: PhoneNumber,
        password: Password
    };

   Login(request, successCB, errorCB);

}


//-----------------------------------------------------------------------------
// A Method for presenting the results
//-----------------------------------------------------------------------------
function successCB(resutls) {
    //this is the callBackFunc
    alert("" + resutls.d);
    window.location = "www.walla.co.il";
    
}

function errorCB(e) {
    alert("I caught the exception : failed in AjaxArrFunc \n The exception message is : " + e.responseText);
}