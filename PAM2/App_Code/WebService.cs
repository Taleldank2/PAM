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
using System.IO;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    static Dictionary<string, string> usersSessions = new Dictionary<string, string>();
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
                        //Crete GUID number
                        string userGuid = Guid.NewGuid().ToString();

                        //get the user id
                        string userId = dt.Rows[0][0].ToString();

                        // Search inside userSession dictionary table if user is there 
                        if (usersSessions.Keys.Contains(userId))
                        {
                            usersSessions[userId] = userGuid;
                        }
                        else
                        {
                            //if user is not there, add him to the dictionary
                            usersSessions.Add(userId, userGuid);
                        }

                        //Give the user cookie named "session" and give it the value of the user guid for example:
                        //"session=4564564-5646-456-4564"
                        HttpCookie cookie = new HttpCookie("session");
                        cookie["session"] = userGuid;

                        cookie.Expires = DateTime.Now.AddHours(1);

                        Context.Response.Cookies.Add(cookie);

                        // serialize to string
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        string jsonString = "";
                        if (Convert.ToInt32(myUser.UserType) == 1)
                            jsonString = js.Serialize("ברוך הבא " + myUser.FirstName);
                        else
                            jsonString = js.Serialize(2);
                        return jsonString;

                    }
                    catch (Exception ex)
                    {

                        using (StreamWriter w = File.AppendText("log.txt"))
                        { Log(ex.Message, w); }

                        // serialize to string
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        string jsonString = js.Serialize("Session table error (Go to WebService class to debug!): " + ex.Message);
                        return jsonString;
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
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            { Log(ex.Message, w); }

            // serialize to string
            JavaScriptSerializer js = new JavaScriptSerializer();
            string jsonString = js.Serialize("Unable to read from the database" + ex.Message);
            return jsonString;
        }
    }

    [WebMethod]
    public string checkUserSession(string userSession) //user session is the GUID string that is being send from:
                                                       //checkUserExists ajax call
                                                       //this method is being called on every page load
    {
        string response = "false";

        if (usersSessions.Values.Contains(userSession))
        {
            response = "true";
        }

        return response;
    }

    [WebMethod]
    private string getUserFromSession(string sessionId)//Extract the user id from the session table
    {



        foreach (KeyValuePair<string, string> pair in usersSessions)
        {
            if (pair.Value == sessionId)
            {
                return pair.Key;
            }
        }
        throw new Exception("Invalid session id");

    }

    [WebMethod]
    public string getUser()
    {
        try
        {
            string userSession = Context.Request.Cookies["session"]["session"];

            string userID = getUserFromSession(userSession);

            DataTable details = dbHandler.getUser(userID);

            string response = dataTableToJson(details);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            { Log(ex.Message, w); }
            throw ex;
        }


    }//Get user object from session

    [WebMethod]
    public string getUserType()
    {
        try
        {
            string userSession = Context.Request.Cookies["session"]["session"];

            string userID = getUserFromSession(userSession);

            DataTable details = dbHandler.getUserType(userID);

            string response = dataTableToJson(details);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            { Log(ex.Message, w); }
            throw ex;
        }


    }//Get user object from session

    
    //--------------------------------------------------------------------
    //                           Events page
    //--------------------------------------------------------------------

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
    //                           Dashboard
    //--------------------------------------------------------------------
    [WebMethod]
    public string getCoachLastResults()
    {
        try
        {
            string userSession = Context.Request.Cookies["session"]["session"];

            string coachID = getUserFromSession(userSession);

            DataTable result = dbHandler.getCoachLastResults(coachID);

            string response = dataTableToJson(result);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //--------------------------------------------------------------------
    //                           Results (new)
    //--------------------------------------------------------------------
    [WebMethod]
    public string getCoachResults()
    {
        try
        {
            string userSession = Context.Request.Cookies["session"]["session"];

            string coachID = getUserFromSession(userSession);

            DataTable result = dbHandler.getCoachLastResults(coachID);

            string response = dataTableToJson(result);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //--------------------------------------------------------------------
    //                           Snippets
    //--------------------------------------------------------------------
    private string dataTableToJson(DataTable table)
    {
        try
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
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText("log.txt"))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
        
    }

    //--------------------------------------------------------------------
    // log message (error)
    //--------------------------------------------------------------------
    public static void Log(string logMessage, TextWriter w)
    {
        w.Write("\r\nLog Entry : ");
        w.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(),
            DateTime.Now.ToLongDateString());
        w.WriteLine("  :");
        w.WriteLine("  :{0}", logMessage);
        w.WriteLine("-------------------------------");
    }

}
