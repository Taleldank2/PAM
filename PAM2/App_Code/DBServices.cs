﻿using System;
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
        try
        {
            SqlConnection con = new SqlConnection(connectionString);

            con.Open();

            return con;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //---------------------------------------------------------------------------------
    // Create the SqlCommand
    //---------------------------------------------------------------------------------
    private SqlCommand CreateCommand(string CommandSTR, SqlConnection con)
    {
        try
        {
            SqlCommand cmd = new SqlCommand(); // create the command object

            cmd.Connection = con;              // assign the connection to the command object

            cmd.CommandText = CommandSTR;      // can be Select, Insert, Update, Delete 

            cmd.CommandTimeout = 10;           // Time to wait for the execution' The default is 30 seconds

            cmd.CommandType = System.Data.CommandType.Text; // the type of the command, can also be stored procedure

            return cmd;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
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
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
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
        try
        {
            string query = "SELECT * FROM Users" +
                        " WHERE PhoneNumber ='" + userID + "'";

            DataTable user = queryDb(query);

            return user;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public DataTable getUserType(string userID)
    {
        try
        {
            string query = "SELECT * FROM Users" +
                " WHERE UserID ='" + userID + "'";

            DataTable user = queryDb(query);

            return user;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

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
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
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

    public bool registerAthlete(string userId, string userTeam, string athleteWeight, string athleteHeight)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            string command = "INSERT INTO [dbo].[Athletes] " +
                             "([AthleteID], [TeamID], [Highet], [Weight], [AppScore]) " +
                             " VALUES({0},'{1}','{2}','{3}','{4}')";

            string formattedCommand = String.Format(command, userId, userTeam, athleteWeight, athleteHeight, 0);

            SqlCommand insert = new SqlCommand(formattedCommand, con);

            return Convert.ToBoolean(insert.ExecuteNonQuery());
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
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
        try
        {
            string dirPath = Path.Combine(HttpRuntime.AppDomainAppPath, picPath.Replace("/", "\\"));

            File.WriteAllText(dirPath, userPicBase64);
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }

    public string getPicturePath(string userID)
    {
        try
        {
            string query = "SELECT Picture FROM [dbo].[Users] WHERE UserID =" + userID;

            DataTable userTable = queryDb(query);

            string picturePath = userTable.Rows[0][0].ToString();

            return picturePath;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }

    public DataTable getTeamsNames()
    {
        try
        {
            string query = "Select * from Teams";

            DataTable Teams = queryDb(query);

            return Teams;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }


    //--------------------------------------------------------------------
    // Profile Page 
    //--------------------------------------------------------------------

    public DataTable getDetails(string userID)
    {
        try
        {
            string query = "Select top 1 * from Users" +
                " Join Athletes ON Users.UserID = Athletes.AthleteID" +
                " where AthleteID = " + userID;

            DataTable UserDetails = queryDb(query);

            return UserDetails;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }

    //--------------------------------------------------------------------
    //Function for update profile athlete
    //--------------------------------------------------------------------
    public bool updateDetails(string userId, string phoneNumber, string userMail, string userPassword, string city, string athleteWeight, string athleteHeight)
    {
        SqlConnection con = null;

        try
        {
            con = connect();
            int countUpdatesUser = 0, countUpdatesAthlete = 0;
            bool updatedUser = true, updatedAthlete = true;


            string commandUser = "UPDATE [dbo].[Users] SET ";
            if (phoneNumber != null && phoneNumber != "")
            {
                commandUser += " [PhoneNumber] =" + phoneNumber;
                countUpdatesUser++;
            }
            if (userMail != null && userMail != "")
            {
                if (countUpdatesUser != 0)
                    commandUser += ",";
                commandUser += " [Email] =" + userMail;
                countUpdatesUser++;
            }
            if (userPassword != null && userPassword != "")
            {
                if (countUpdatesUser != 0)
                    commandUser += ",";
                commandUser += " [Password] =" + userPassword;
                countUpdatesUser++;
            }
            if (city != null && city != "")
            {
                if (countUpdatesUser != 0)
                    commandUser += ",";
                commandUser += " [City] =" + city;
                countUpdatesUser++;
            }
            commandUser += " WHERE [UserID]=" + userId;


            string commandAthlete = "UPDATE [dbo].[Athletes] SET ";
            if (athleteHeight != null && athleteHeight != "")
            {
                commandAthlete += " [Highet] =" + athleteHeight;
                countUpdatesAthlete++;
            }
            if (athleteWeight != null && athleteWeight != "")
            {
                if (countUpdatesAthlete != 0)
                    commandAthlete += ",";
                commandAthlete += " [Weight] =" + athleteWeight;
                countUpdatesAthlete++;
            }
            commandAthlete += " WHERE [AthleteID]=" + userId;


            if (countUpdatesUser > 0)
            {
                string formattedCommandUser = String.Format(commandUser);
                SqlCommand updateUser = new SqlCommand(formattedCommandUser, con);
                updatedUser = Convert.ToBoolean(updateUser.ExecuteNonQuery());
            }

            if (countUpdatesAthlete > 0)
            {
                string formattedCommandAthlete = String.Format(commandAthlete);
                SqlCommand updateAthlete = new SqlCommand(formattedCommandAthlete, con);
                updatedAthlete = Convert.ToBoolean(updateAthlete.ExecuteNonQuery());
            }

            return updatedAthlete && updatedUser;

        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
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
    // Dashboard Page 
    //--------------------------------------------------------------------
    public DataTable getUserLastEvent(string userID)
    {
        try
        {
            string query = "Select TOP 1 * from events e"
    + " join dbo.TeamsEvents t on t.EventID = e.EventID"
    + " join dbo.Athletes a on t.TeamID = a.TeamID"
    + " WHERE a.AthleteID =" + userID +
    " ORDER BY E_Date DESC";

            DataTable UserEvent = queryDb(query);

            return UserEvent;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public string getMessagesCount(string userID)
    {
        try
        {
            string query = "SELECT count(*) as messagescount FROM [dbo].[Messages] m " +
               "JOIN dbo.TeamsMessages t on m.MessageID = t.MessageID " +
               "join dbo.Athletes a on t.TeamID = a.TeamID " +
               "WHERE AthleteID = " + userID;

            DataTable messagesTable = queryDb(query);

            string messagesCount = messagesTable.Rows[0][0].ToString();

            return messagesCount;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public string getUserScore(string userID)
    {
        try
        {
            string query = "select AppScore	from athletes where AthleteID = " + userID;

            DataTable scoreTable = queryDb(query);

            string userScore = scoreTable.Rows[0][0].ToString();

            return userScore;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }

    public string getUserName(string userID)
    {
        try
        {
            string query = "Select Users.FirstName from Users" +
                " Join Athletes ON Users.UserID = Athletes.AthleteID" +
                " where AthleteID = " + userID;

            DataTable userNames = queryDb(query);

            string userName = userNames.Rows[0][0].ToString();

            return userName;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }
    }


    //Coach Dashboard results
    public DataTable getCoachLastResults(string coachID)
    {
        try
        {
            string query = "SELECT TOP (5) " +
            " *, Users.FirstName,Users.LastName,Users.UserID "+
            " from results join athletes "+
            " on Athletes.AthleteID = Results.AthleteID join Users "+
            " on Users.UserID = Athletes.AthleteID join teams "+
            " on teams.TeamID = Athletes.TeamID join Coaches "+
            " on Coaches.CoachId = teams.HeadCoachID "+
            " where Coaches.coachID ="+ coachID +
            " ORDER BY dbo.Results.rDate DESC ";

            DataTable CoachLastResults = queryDb(query);

            return CoachLastResults;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }


    //--------------------------------------------------------------------
    // Results Page
    //--------------------------------------------------------------------
    public DataTable getUserResults(string userID)
    {
        try
        {
            string query = "select * from results " +
               "WHERE AthleteID = " + userID + " " +
               "ORDER BY rDate DESC";


            DataTable userResults = queryDb(query);

            return userResults;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //--------------------------------------------------------------------
    // Events Page
    //--------------------------------------------------------------------
    public DataTable getUserEvents(string userID)
    {
        try
        {
            string query = "Select * from events e"
            + " join dbo.TeamsEvents t on t.EventID = e.EventID"
            + " join dbo.Athletes a on t.TeamID = a.TeamID"
            + " WHERE a.AthleteID =" + userID +
            " ORDER BY E_Date DESC";

            DataTable UserEvent = queryDb(query);

            return UserEvent;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public DataTable getCoachEvents(string userID)
    {
        try
        {
            string query = "Select * from events e"
    + " join dbo.TeamsEvents t on t.EventID = e.EventID"
    + " join dbo.Teams te on t.TeamID = te.TeamID"
    + " join dbo.Coaches c on te.HeadCoachID = c.CoachID"
    + " WHERE c.CoachID =" + userID +
    " ORDER BY E_Date DESC";

            DataTable CoachEvent = queryDb(query);

            return CoachEvent;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText("..\\../log.txt"))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    //--------------------------------------------------------------------
    // Messages page
    //--------------------------------------------------------------------

    public DataTable getUserMessages(string userID)
    {
        try
        {
            string query = "SELECT * FROM [dbo].[Messages] m " +
               "JOIN dbo.TeamsMessages t on m.MessageID = t.MessageID " +
               "join dbo.Athletes a on t.TeamID = a.TeamID " +
               "join Users u on m.CreatorID = u.UserID " +
               "WHERE AthleteID = " + userID;

            DataTable messagesTable = queryDb(query);

            return messagesTable;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
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