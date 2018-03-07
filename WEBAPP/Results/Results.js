ResultInfo = new Object();

//When Document is ready
$(document).ready(function () {
    //When Results is clicked take the User id from the current session
    //and put it inside Resultinfo object inside id property
    $(document).on('click', '#Results', function () {
        ResultInfo.id = //get User Id from session
        //GetResults for the spesific User ID
        getResulsByID(ResultInfo, renderResults);
    });
});
    
function renderResults(results) {
    //this is the callBackFunc 
    results = $.parseJSON(results.d);
    str = "";
    for (var i = 0; i < results.length; i++) {
        //Create a Link and set the following attributes: 
            //href= Link to Product Page 
            //class = product 
            //id = i;
        str += '<li><a class="product" href="#product" id="' + (results[i].Id) + '">' +
            '<img src="' + results[i].ImagePath + '"/>' +
            "<h3>" + results[i].Title + "</h3>" +
            "<p> Price: " + results[i].Price + "</p>" +
            "<p> Inventory: " + results[i].Inventory + "</p>" +
            "</a></li>";
    };
    $("#ResultsSHOW").html(str);
    $("#ResultsSHOW").listview("refresh");
}

function getResultsbyID(ResultInfo, renderResults) {

    // serialize the object to JSON string
    var dataString = JSON.stringify(ResultInfo);

    $.ajax({
        url: 'ajaxWebService.asmx/getProductsByCat',
        data: dataString,
        type: 'POST',
        dataType: "json",
        contentType: 'application/json; charset = utf-8',
        success: function (results) {
            renderProducts(results);
        },
        error: function (request, error) {
            alert('Network error has occurred please try again!');
        }
    });
}