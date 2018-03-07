//-----------------------------------------------------------------------
// call an ajax function and pass it the request
//-----------------------------------------------------------------------
function Login(request, successCB, errorCB) {

    // serialize the object to JSON string
    var dataString = JSON.stringify(request);

    $.ajax({ // ajax call starts
        url: 'ajaxWebService.asmx/Login',         // server side web service method
        data: dataString,                          // the parameters sent to the server
        type: 'POST',                              // can be also GET
        dataType: 'json',                          // expecting JSON datatype from the server
        contentType: 'application/json; charset = utf-8',
        success: successCB,                // data.d id the Variable data contains the data we get from serverside
        error: errorCB
    }) // end of ajax call
}