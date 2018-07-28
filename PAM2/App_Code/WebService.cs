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

using PushSharp;
using PushSharp.Core;
using PushSharp.Google;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
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
                    myUser.UserId = dt.Rows[0][0].ToString();
                    myUser.UserType = dt.Rows[0][1].ToString();
                    myUser.FirstName = dt.Rows[0][2].ToString();
                    myUser.LastName = dt.Rows[0][3].ToString();
                    myUser.PhoneNumber = dt.Rows[0][4].ToString();
                    myUser.Email = dt.Rows[0][5].ToString();
                    myUser.Password = dt.Rows[0][6].ToString();
                    myUser.Picture = dt.Rows[0][7].ToString();
                    myUser.City = dt.Rows[0][8].ToString();
                    myUser.BirthDate = dt.Rows[0][9].ToString();

                    try
                    {


                        // serialize to string
                        JavaScriptSerializer js = new JavaScriptSerializer();
                        string jsonString = "";
                        jsonString = js.Serialize(myUser);
                        return jsonString;

                    }
                    catch (Exception ex)
                    {

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
            // serialize to string
            JavaScriptSerializer js = new JavaScriptSerializer();
            string jsonString = js.Serialize("Unable to read from the database" + ex.Message);
            return jsonString;

        }

    }

    //[WebMethod]
    //public string checkUserSession(string userSession) //user session is the GUID string that is being send from:
    //                                                   //checkUserExists ajax call
    //                                                   //this method is being called on every page load
    //{
    //    string response = "false";
    //    if (usersSessions.Values.Contains(userSession))
    //    {
    //        response = "true";
    //    }
    //    return response;
    //}

    //[WebMethod]
    //private string getUserFromSession(string sessionId)//Extract the user id from the session table
    //{
    //    foreach (KeyValuePair<string, string> pair in usersSessions)
    //    {
    //        if (pair.Value == sessionId)
    //        {
    //            return pair.Key;
    //        }
    //    }
    //    throw new Exception("Invalid session id");
    //}

    [WebMethod]
    public string getUser(string userId)
    {
        try
        {
            //string userSession = Context.Request.Cookies["session"]["session"];

            //string userID = getUserFromSession(userSession);

            DataTable details = dbHandler.getUser(userId);

            string response = dataTableToJson(details);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }


    //}//Get user object from session

    //[WebMethod]
    //public string getUserType()
    //{
    //    try
    //    {
    //        string userSession = Context.Request.Cookies["session"]["session"];

    //        string userID = getUserFromSession(userSession);

    //        DataTable details = dbHandler.getUserType(userID);

    //        string response = dataTableToJson(details);

    //        return response;
    //    }
    //    catch (Exception ex)
    //    {
    //        // send to log file
    //        using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
    //        { Log(ex.Message, w); }
    //        throw ex;
    //    }


    //}//Get user object from session


    //--------------------------------------------------------------------
    //                           Events page
    //--------------------------------------------------------------------

    [WebMethod]
    public string getCoachEvents(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getCoachEvents(coachId);

        string response = dataTableToJson(events);

        return response;

    }

    [WebMethod]
    public string addEvent(string eventName, string eventDate, string eventDescription, string eventType, string startTime,
       string endTime, string eventLocation)
    {

        bool answer = false;
        answer = dbHandler.addEvent(eventName, eventDate, eventDescription, eventType, startTime,
        endTime, eventLocation);

        JavaScriptSerializer js = new JavaScriptSerializer();

        string jsonString = js.Serialize("שגיאה בקליטת אירוע");

        if (answer)
        {
            jsonString = js.Serialize("אירוע נקלט בהצלחה");
        }

        return jsonString;

    }

    //--------------------------------------------------------------------
    //                           Dashboard
    //--------------------------------------------------------------------

    [WebMethod]
    public string getCoachLastResults(string coachId)
    {
        try
        {
            //string userSession = Context.Request.Cookies["session"]["session"];

            //string coachID = getUserFromSession(userSession);

            DataTable result = dbHandler.getCoachLastResults(coachId);

            string response = dataTableToJson(result);

            return response;
        }
        catch (Exception ex)
        {
            // send to log file
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    [WebMethod]
    public string getCoachLastMessages(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string coachId = getUserFromSession(userSession);

        DataTable messages = dbHandler.getCoachLastMessages(coachId);

        string response = dataTableToJson(messages);

        return response;
    }


    //--------------------------------------------------------------------
    //                           Results
    //--------------------------------------------------------------------
    [WebMethod]
    public string getCoachResults(string coachId)
    {
        try
        {
            //string userSession = Context.Request.Cookies["session"]["session"];

            //string coachID = getUserFromSession(userSession);

            DataTable result = dbHandler.getCoachResults(coachId);

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
    //                           Messages
    //--------------------------------------------------------------------

    [WebMethod]
    public string getMessagesCount(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        string messagesCount = dbHandler.getMessagesCount(userId);

        return messagesCount;
    }

    [WebMethod]
    public string getCoachMessages(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string coachId = getUserFromSession(userSession);

        DataTable messages = dbHandler.getCoachMessages(coachId);

        string response = dataTableToJson(messages);

        return response;
    }

    [WebMethod]
    public string getCoachTeams(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string coachId = getUserFromSession(userSession);

        DataTable teams = dbHandler.getCoachTeams(coachId);

        string response = dataTableToJson(teams);

        return response;
    }

    //--------------------------------------------------------------------
    //                           Attendeance
    //--------------------------------------------------------------------

    [WebMethod]
    public string getTodayEvents(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getTodayEvents(coachId);

        string response = dataTableToJson(events);

        return response;

    }

    [WebMethod]
    public string getEventMembers(string EventId)
    {

        DataTable EventMembers = dbHandler.getEventMembers(EventId);

        string response = dataTableToJson(EventMembers);

        return response;
    }

    [WebMethod]
    public void insertAttendance(string attendanceArr)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        Attendance[] attendArr = js.Deserialize<Attendance[]>(attendanceArr);

    }


    //--------------------------------------------------------------------
    //                           Send Notifications
    //--------------------------------------------------------------------


    [WebMethod]
    public void createMessage(string coachId, String title, String message, String[] teamIds)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string coachId = getUserFromSession(userSession);

        dbHandler.createNewMessage(title, message, teamIds, coachId);

        List<string> userRegIds = dbHandler.getUserRegsFromTeams(teamIds);

        sendPush("הודעה חדשה מפאם", title, userRegIds);

    }

    [WebMethod]
    public void test2()
    {
        //lt is the list of devices that are registerd to the app
        //need to be detched every time we want to send notification
        List<string> lt = new List<string>();
        //this is an example of 1 reg id of eldan's devices
        lt.Add("d5eaPinp36g:APA91bEP4wYxj7NzHfHWzyEAWfM46s6lX5pDUy-PDZsH9wupS4J_6aGRn4LNoynpdluhTXx5uL9_EScBgiVAhZ2UJDn5KAGTp9QhQO-iTrikKUP6GMhbfHYEeiMmDyYEzoyfp15z-PvX13XYzsCkbqEnTxIS1yOzTQ");
        sendPush("hello", "tal eldan", lt);
    }

    private void sendPush(String title, String message, List<String> usersRegIds)
    {
        // Configuration
        GcmConfiguration config = new GcmConfiguration("206709481331", "AAAAMCDYX3M:APA91bGholyu09oAxHchbU0OjQ9cmmacr_BlzvxKbShRuzNiuscPcfxEsqSzpayb7FIZWqW2Btlg41UAnnwmb0Fdub7iqcvPLigNOzkLwZP65RbsXojEKEKZq6o9sHNNCYzRe4K2sdImrtM3tkTBR6iX0oJZIb8C-g", "com.it");
        // Create a new broker
        GcmServiceBroker gcmBroker = new GcmServiceBroker(config);

        gcmBroker.OnNotificationFailed += GcmBroker_OnNotificationFailed;

        gcmBroker.OnNotificationSucceeded += GcmBroker_OnNotificationSucceeded;

        String msg = "{ \"title\" : \"" + title + "\", \"body\" : \"" + message + " \" }";

        // Start the broker
        gcmBroker.Start();

        foreach (var regId in usersRegIds)
        {
            // Queue a notification to send
            gcmBroker.QueueNotification(new GcmNotification
            {
                RegistrationIds = new List<string> {
                    regId
                },
                Data = JObject.Parse(msg)
            });
        }

        // Start the broker
        gcmBroker.Start();

        // Stop the broker, wait for it to finish   
        // This isn't done after every message, but after you're
        // done with the broker
        gcmBroker.Stop();

    }

    private void GcmBroker_OnNotificationSucceeded(GcmNotification notification)
    {
        string asdf = "sap";
    }

    private void GcmBroker_OnNotificationFailed(GcmNotification notification, AggregateException exception)
    {
        //string asdf = "sap";
    }


    //--------------------------------------------------------------------
    //                           Profile
    //--------------------------------------------------------------------

    [WebMethod]
    public string getUserDetails(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable details = dbHandler.getDetails(userId);

        string response = dataTableToJson(details);

        return response;
    }

    [WebMethod]
    public void update(string userId,string phoneNumber, string userMail, string userPassword, string city, string athleteWeight, string athleteHeight)
    {
        dbHandler.updateDetails(userId, phoneNumber, userMail, userPassword, city);
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
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //--------------------------------------------------------------------
    //                           Picture
    //--------------------------------------------------------------------
    [WebMethod]
    public string getPicturePath(string coachId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string coachId = getUserFromSession(userSession);

        string picturePath = dbHandler.getPicturePath(coachId);

        return picturePath;
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
