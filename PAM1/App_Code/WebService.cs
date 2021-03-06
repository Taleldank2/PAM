﻿using System;
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
    //                           Profile
    //--------------------------------------------------------------------

    [WebMethod]
    public void update(string UserID, string phoneNumber, string userMail, string userPassword, string city, string athleteWeight, string athleteHeight)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        dbHandler.updateDetails(UserID, phoneNumber, userMail, userPassword, city, athleteWeight, athleteHeight);
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
                    myUser.LastName= dt.Rows[0][3].ToString();
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

    //[WebMethod]
    //public string getUserType(string userID)
    //{
    //    //string userSession = Context.Request.Cookies["session"]["session"];
    //    //string userID = getUserFromSession(userSession);
    //    DataTable details = dbHandler.getUserType(userID);
    //    string response = dataTableToJson(details);
    //    return response;
    //}//Get user object from session

    [WebMethod]
    public string getUser(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userID = getUserFromSession(userSession);

        DataTable details = dbHandler.getUser(userId);

        string response = dataTableToJson(details);

        return response;

    }

    [WebMethod]
    public void addUserReg (string userId,string regId)
    {
        dbHandler.addUserReg(userId, regId);
            
    }


    //--------------------------------------------------------------------
    //                           Register
    //--------------------------------------------------------------------

    [WebMethod]
    public void register(string userType,string userTeam, string userName, string userLastName, string phoneNumber,
                           string userMail, string userPassword, string userPicBase64, string city,
                           string userBirthday, string athleteWeight, string athleteHeight)
    {
        dbHandler.registerUser(userType, userName, userLastName, phoneNumber, userMail, userPassword,
                               userPicBase64, city, userBirthday, userTeam, athleteWeight, athleteHeight);

        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        //dbHandler.registerAthlete(userId, userTeam, athleteWeight, athleteHeight);

    }

    [WebMethod]
    public string getTeamsNames()
    {

        DataTable TeamNames = dbHandler.getTeamsNames();

        string response = dataTableToJson(TeamNames);

        return response;
    }

    [WebMethod]
    public string getPicturePath(string userId)
    {

        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        string picturePath = dbHandler.getPicturePath(userId);

        return picturePath;
    }


    //--------------------------------------------------------------------
    //                           Main Page
    //--------------------------------------------------------------------

    [WebMethod]
    public string getUserNextEvent(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getUserNextEvent(userId);

        string response = dataTableToJson(events);

        return response;
    }

    [WebMethod]
    public string getScore(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        string score = dbHandler.getUserScore(userId);

        return score;
    }

    [WebMethod]
    public string getName(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        string name = dbHandler.getUserName(userId);

        return name;
    }

    [WebMethod]
    public string getLastResult(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable result = dbHandler.getUserLastResult(userId);

        string response = dataTableToJson(result);

        return response;
    }

    [WebMethod]
    public string getMessagesCount(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        string messagesCount = dbHandler.getMessagesCount(userId);

        return messagesCount;
    }


    //--------------------------------------------------------------------
    //                           App Pages
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
    public string getUserResults(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable result = dbHandler.getUserResults(userId);

        string response = dataTableToJson(result);

        return response;
    }

    [WebMethod]
    public string getUserMessages(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable messages = dbHandler.getUserMessages(userId);

        string response = dataTableToJson(messages);

        return response;
    }

    [WebMethod]
    public string getUserEvents(string userId)
    {
        //string userSession = Context.Request.Cookies["session"]["session"];

        //string userId = getUserFromSession(userSession);

        DataTable events = dbHandler.getUserEvents(userId);

        string response = dataTableToJson(events);

        return response;

    }

    //[WebMethod]
    //public string getCoachEvents()
    //{
    //    string userSession = Context.Request.Cookies["session"]["session"];

    //    string userId = getUserFromSession(userSession);

    //    DataTable events = dbHandler.getCoachEvents(userId);

    //    string response = dataTableToJson(events);

    //    return response;

    //}

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

    [WebMethod]
    public void addResult(string UserID, string ResultDate, string ResultType, string ResultDistance, string ResultTimeMin, string ResultTimeSec, string ResultNote)
    {
        dbHandler.insertResult(UserID, ResultDate, ResultType, ResultDistance, ResultTimeMin, ResultTimeSec, ResultNote);

        //add 100 points for any new result insert
        updateScore(UserID, 100);
    }

    [WebMethod]
    public void updateScore(string UserId,int addScore)
    {
        string scoreStr = getScore(UserId);
        int scoreInt = int.Parse(scoreStr);
        scoreInt += addScore;
        dbHandler.updateToScore(UserId, scoreInt);
    }
}






