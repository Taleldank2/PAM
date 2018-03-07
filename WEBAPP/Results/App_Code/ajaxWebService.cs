using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
// REMEMBER TO ADD THIS NAMESPACE
using System.Web.Script.Serialization;
using System.Web.Script.Services;

/// <summary>
/// Summary description for ajaxWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService] // REMEMBER TO UNCOMMENT THIS LINE


public class ajaxWebService : System.Web.Services.WebService
{

    public ajaxWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

   
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    public string getResultByID(string UserId)
    {

        int UserId = Convert.ToInt32(UserId);
        Results r = new Results();
        List<Results> ls = r.getResultsByID(resultId);

        JavaScriptSerializer js = new JavaScriptSerializer();
        // serialize to string
        string jsonStringCategory = js.Serialize(ls);
        return jsonStringCategory;
    }

}
