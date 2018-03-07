function Login() {

    UserName = document.getElementById("UserName").value;
    Password = document.getElementById("Password").value;

    request = {
        userName: UserName,
        password: Password
    };


   Login(request, successCB, errorCB);

}