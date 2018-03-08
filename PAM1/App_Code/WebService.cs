using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
// REMEMBER TO ADD THIS NAMESPACE
using System.Web.Script.Serialization;
using System.Web.Script.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    string con="PamDBconnectionString";

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    [WebMethod]
    public string Login(string phoneNumber, string password)
    {
        DBServices db = new DBServices();

        try
        {
            db = db.ReadFromDataBase(con, "Users", "PhoneNumber", phoneNumber);
        }
        catch (Exception)
        {
            return "EROR 1";
            throw;
        }

        User user = new User();

        try
        {
            user.Password = db.dt.Rows[0][6].ToString();
            user.PhoneNumber = db.dt.Rows[0][4].ToString();
            if (user.PhoneNumber == phoneNumber && user.Password == password)
                return "ברוך הבא!";
            else if (user.PhoneNumber == phoneNumber && user.Password != password)
                return "סיסמא שגויה";
            else
                return "EROR 2";
        }
        catch (Exception)
        {
            return "EROR 3";
            throw;
        }
        
    }

}
