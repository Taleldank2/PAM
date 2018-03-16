using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
// REMEMBER TO ADD THIS NAMESPACE
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Runtime.Remoting.Contexts;
using System.Web.Configuration;
using System.Data;


/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{
    static Dictionary<String, String> usersSessions = new Dictionary<string, string>();

    private DBServices dbHandler;


    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 

        string connectionString = WebConfigurationManager.ConnectionStrings["PamDBconnectionString"].ConnectionString;
        dbHandler = new DBServices(connectionString);
    }


    //--------------------------------------------------------------------
    //                           Login
    //--------------------------------------------------------------------

    [WebMethod]
    public string Login(string phoneNumber, string password)
    {

        //Create New User obj
        User myUser = new User();

        try
        {
            //Search User in DataBase
            DataTable dt = dbHandler.getUser(phoneNumber);

            //If user does not exist in database
            if (dt.Rows[0][0] == null)
            {
                // serialize to string
                JavaScriptSerializer js = new JavaScriptSerializer();
                string jsonString = js.Serialize("שם משתמש לא קיים במערכת");
                return jsonString;
            }
            else
            {
                //User Exist in DataBase
                //Check Password                               
                if (dt.Rows[0][6].ToString() == password)
                {
                    //Password is approved
                    myUser.UserType = dt.Rows[0][1].ToString();
                    myUser.Password = dt.Rows[0][6].ToString();
                    myUser.PhoneNumber = dt.Rows[0][4].ToString();

                    try
                    {
                        string userGuid = Guid.NewGuid().ToString();

                        string userId = dt.Rows[0][0].ToString();

                        if (usersSessions.Keys.Contains(userId))
                        {
                            usersSessions[userId] = userGuid;
                        }
                        else
                        {
                            usersSessions.Add(userId, userGuid);
                        }

                        HttpCookie cookie = new HttpCookie("session");
                        cookie["session"] = userGuid;

                        cookie.Expires = DateTime.Now.AddHours(1);

                        Context.Response.Cookies.Add(cookie);

                        // serialize to string
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        string jsonString = js.Serialize("ברוך הבא");
                        return jsonString;

                    }
                    catch (Exception ex)
                    {

                        // serialize to string
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        string jsonString = js.Serialize("Session table error (Go to WebService class to debug!): " + ex.Message);
                        return jsonString;
                        throw;

                    }

                }

                else
                {
                    //Password not approved

                    // serialize to string
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    string jsonString = js.Serialize("סיסמה שגויה");
                    return jsonString;
                }

            }
        }

        catch (Exception ex)
        {
            // serialize to string
            JavaScriptSerializer js = new JavaScriptSerializer();
            string jsonString = js.Serialize("Unable to read from the database" + ex.Message);
            return jsonString;
            throw;
        }

    }

    private string getUserFromSession(string sessionId)
    {
        foreach (KeyValuePair<String, String> pair in usersSessions)
        {
            if (pair.Value == sessionId)
            {
                return pair.Key;
            }
        }

        throw new Exception("Invalid session id");
    }

    [WebMethod]
    public string checkUserSession(string userSession)
    {
        string response = "false";

        if (usersSessions.Values.Contains(userSession))
        {
            response = "true";
        }

        return response;
    }

    //--------------------------------------------------------------------
    //                           Register
    //--------------------------------------------------------------------

    [WebMethod]
    public void register(string userType, string userName, string userLastName, string phoneNumber,
                           string userMail, string userPassword, string userPicBase64, string city,
                           string userBirthday)
    {
        dbHandler.registerUser(userType, userName, userLastName, phoneNumber, userMail, userPassword,
                               userPicBase64, city, userBirthday);
    }

    [WebMethod]
    public string getPicturePath()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        string picturePath = dbHandler.getPicturePath(userId);

        return picturePath;
    }



    //--------------------------------------------------------------------
    //                           Main Page
    //--------------------------------------------------------------------

    [WebMethod]
    public string getUserLastEvent()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getUserLastEvent(userId);

        string response = dataTableToJson(events);

        return response;
    }

    [WebMethod]
    public string getScore()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        string score = dbHandler.getUserScore(userId);

        return score;
    }

    [WebMethod]
    public string getName()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        string name = dbHandler.getUserName(userId);

        return name;
    }

    [WebMethod]
    public string getLastResult()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        DataTable result = dbHandler.getUserLastResult(userId);

        string response = dataTableToJson(result);

        return response;
    }

    [WebMethod]
    public string getMessagesCount()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        string messagesCount = dbHandler.getMessagesCount(userId);

        return messagesCount;
    }


    //--------------------------------------------------------------------
    //                           App Pages
    //--------------------------------------------------------------------

    [WebMethod]
    public string getUserResults()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        DataTable result = dbHandler.getUserResults(userId);

        string response = dataTableToJson(result);

        return response;
    }

    [WebMethod]
    public string getUserMessages()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        DataTable messages = dbHandler.getUserMessages(userId);

        string response = dataTableToJson(messages);

        return response;
    }

    [WebMethod]
    public string getUserEvents()
    {
        string userSession = Context.Request.Cookies["session"]["session"];

        string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getUserEvents(userId);

        string response = dataTableToJson(events);

        return response;
    }

    //--------------------------------------------------------------------
    //                           Snippets
    //--------------------------------------------------------------------

    private string dataTableToJson(DataTable table)
    {
        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> parentRow = new List<Dictionary<string, object>>();
        Dictionary<string, object> childRow;
        foreach (DataRow row in table.Rows)
        {
            childRow = new Dictionary<string, object>();
            foreach (DataColumn col in table.Columns)
            {
                childRow.Add(col.ColumnName, row[col]);
            }
            parentRow.Add(childRow);
        }

        return jsSerializer.Serialize(parentRow);
    }





}






