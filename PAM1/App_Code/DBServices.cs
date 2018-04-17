using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Text;
using System.IO;

/// <summary>
/// Summary description for DBServices
/// </summary>
public class DBServices
{
    private string connectionString;

    public DBServices(string connection)
    {
        connectionString = connection;
    }

    //--------------------------------------------------------------------------------------------------
    // This method creates a connection to the database according to the connectionString name in the web.config 
    //--------------------------------------------------------------------------------------------------
    private SqlConnection connect()
    {
        SqlConnection con = new SqlConnection(connectionString);

        con.Open();

        return con;
    }


    //---------------------------------------------------------------------------------
    // Create the SqlCommand
    //---------------------------------------------------------------------------------
    private SqlCommand CreateCommand(string CommandSTR, SqlConnection con)
    {

        SqlCommand cmd = new SqlCommand(); // create the command object

        cmd.Connection = con;              // assign the connection to the command object

        cmd.CommandText = CommandSTR;      // can be Select, Insert, Update, Delete 

        cmd.CommandTimeout = 10;           // Time to wait for the execution' The default is 30 seconds

        cmd.CommandType = System.Data.CommandType.Text; // the type of the command, can also be stored procedure

        return cmd;
    }


    //--------------------------------------------------------------------
    // This function is used to SELECT tabels from the DB
    //--------------------------------------------------------------------
    private DataTable queryDb(string query)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            SqlDataAdapter da = new SqlDataAdapter(query, con); 

            DataSet ds = new DataSet();  
            da.Fill(ds);   

            DataTable dt = ds.Tables[0];

            return dt;
        }
        catch (Exception ex)
        {
            // write to log
            throw ex;
        }
        finally
        {
            if (con != null)
            {
                con.Close();
            }
        }
    }

    //--------------------------------------------------------------------
    //Function for Login module
    //--------------------------------------------------------------------
    public DataTable getUser(string userID)
    {
            
        string query = "SELECT * FROM Users" +
                        " WHERE  PhoneNumber ='" + userID + "'";

        DataTable user = queryDb(query);

        return user;
    }

    //--------------------------------------------------------------------
    // Register
    //--------------------------------------------------------------------

    public bool registerUser(string userType, string userName, string userLastName, string phoneNumber,
                           string userMail, string userPassword, string userPicBase64, string city,
                           string userBirthday)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            string picPath = "images/profiles/" + phoneNumber + ".html";

            savePicture(picPath, userPicBase64);

            string command = "INSERT INTO[dbo].[Users] " +
                             "([UserType], [FirstName], [LastName], [PhoneNumber], [Email]," +
                             " [Password],[Picture],[City],[BirthDate]) " +
                             " VALUES({0},'{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}')";


            string[] birthDayArray = userBirthday.Split('/');

            string parsedBirthDay = birthDayArray[2] + "-" + birthDayArray[1] + "-" + birthDayArray[0];


            string formattedCommand = String.Format(command, userType, userName, userLastName,
                phoneNumber, userMail, userPassword, picPath, city, parsedBirthDay);

            SqlCommand insert = new SqlCommand(formattedCommand, con);

            return Convert.ToBoolean(insert.ExecuteNonQuery());
        }
        catch (Exception ex)
        {
            // write to log
            throw ex;
        }
        finally
        {
            if (con != null)
            {
                con.Close();
            }
        }
    }

    public bool registerAthlete(string userId, string athleteWeight, string athleteHeight)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            string command = "INSERT INTO[dbo].[Athletes] " +
                             "([AthleteID], [TeamID], [Highet], [Weight], [AppScore]) " +
                             " VALUES({0},'{1}','{2}','{3}','{4}')";

            string formattedCommand = String.Format(command, userId, athleteWeight, athleteHeight, 0);

            SqlCommand insert = new SqlCommand(formattedCommand, con);

            return Convert.ToBoolean(insert.ExecuteNonQuery());
        }
        catch (Exception ex)
        {
            // write to log
            throw ex;
        }
        finally
        {
            if (con != null)
            {
                con.Close();
            }
        }
    }
    

    public void savePicture(string picPath, string userPicBase64)
    {
        string dirPath = Path.Combine(HttpRuntime.AppDomainAppPath, picPath.Replace("/", "\\"));

        File.WriteAllText(dirPath, userPicBase64);
    }

    public string getPicturePath(string userID)
    {
        string query = "SELECT Picture FROM [dbo].[Users] WHERE UserID =" + userID;

        DataTable userTable = queryDb(query);

        string picturePath = userTable.Rows[0][0].ToString();

        return picturePath;
    }

    public DataTable getTeamsNames()
    {

        string query = "Select * from Teams";

        DataTable Teams = queryDb(query);

        return Teams;
    }


    //--------------------------------------------------------------------
    // Profile Page 
    //--------------------------------------------------------------------


    public DataTable getDetails(string userID)
    {

        string query = "Select top 1 * from Users" +
                        " Join Athletes ON Users.UserID = Athletes.AthleteID" +
                        " where AthleteID = " + userID;

        DataTable UserEvent = queryDb(query);

        return UserEvent;
    }


    //--------------------------------------------------------------------
    // Main Page 
    //--------------------------------------------------------------------
    public DataTable getUserLastEvent(string userID)
    {
       
        string query = "Select TOP 1 * from events e"
            + " join dbo.TeamsEvents t on t.EventID = e.EventID"
            + " join dbo.Athletes a on t.TeamID = a.TeamID"
            + " WHERE a.AthleteID =" + userID +
            " ORDER BY E_Date DESC";

        DataTable UserEvent = queryDb(query);

        return UserEvent;
    }
    
    public string getMessagesCount(string userID)
    {

        string query = "SELECT count(*) as messagescount FROM [dbo].[Messages] m " +
                       "JOIN dbo.TeamsMessages t on m.MessageID = t.MessageID " +
                       "join dbo.Athletes a on t.TeamID = a.TeamID " +
                       "WHERE AthleteID = " + userID;
        
        DataTable messagesTable = queryDb(query);

        string messagesCount = messagesTable.Rows[0][0].ToString();

        return messagesCount;
    }
    
    public string getUserScore(string userID)
    {

        string query = "select AppScore	from athletes where AthleteID = " + userID;

        DataTable scoreTable = queryDb(query);

        string userScore = scoreTable.Rows[0][0].ToString();

        return userScore;
    }

    public string getUserName(string userID)
    {

        string query = "Select Users.FirstName from Users"+
                        " Join Athletes ON Users.UserID = Athletes.AthleteID"+
                        " where AthleteID = " + userID;

        DataTable userNames = queryDb(query);

        string userName = userNames.Rows[0][0].ToString();

        return userName;
    }

    public DataTable getUserLastResult(string userID)
    {

        string query = "select top 1 * from results " +
                        "join ResultTypes on results.ResultType = ResultTypes.ResultType "+
                       "WHERE AthleteID = " + userID + " " +
                       "ORDER BY rDate DESC";


        DataTable userLastResult = queryDb(query);

        return userLastResult;
    }


    //--------------------------------------------------------------------
    // Results Page
    //--------------------------------------------------------------------
    public DataTable getUserResults(string userID)
    {
        string query = "select * from results " +
                       "WHERE AthleteID = " + userID + " " +
                       "ORDER BY rDate DESC";


        DataTable userResults = queryDb(query);

        return userResults;
    }

    //--------------------------------------------------------------------
    // Events Page
    //--------------------------------------------------------------------
    public DataTable getUserEvents(string userID)
    {
        string query = "Select * from events e"
            + " join dbo.TeamsEvents t on t.EventID = e.EventID"
            + " join dbo.Athletes a on t.TeamID = a.TeamID"
            + " WHERE a.AthleteID =" + userID +
            " ORDER BY E_Date DESC";

        DataTable UserEvent = queryDb(query);

        return UserEvent;
    }

    public DataTable getCoachEvents(string userID)
    {
        string query = "Select * from events e"
            + " join dbo.TeamsEvents t on t.EventID = e.EventID"
            + " join dbo.Teams te on t.TeamID = te.TeamID"
            + " join dbo.Coaches a on t.TeamID = a.TeamID"
            + " WHERE a.CoachID =" + userID +
            " ORDER BY E_Date DESC";

        DataTable CoachEvent = queryDb(query);

        return CoachEvent;
    }

    //--------------------------------------------------------------------
    // Messages page
    //--------------------------------------------------------------------

    public DataTable getUserMessages(string userID)
    {
        string query = "SELECT * FROM [dbo].[Messages] m " +
                       "JOIN dbo.TeamsMessages t on m.MessageID = t.MessageID " +
                       "join dbo.Athletes a on t.TeamID = a.TeamID " +
                       "join Users u on m.CreatorID = u.UserID "+
                       "WHERE AthleteID = " + userID;

        DataTable messagesTable = queryDb(query);

        return messagesTable;
    }


}