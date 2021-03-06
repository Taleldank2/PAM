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
            string query = "SELECT Picture FROM [dbo].[Users] WHERE UserID=" + userID;

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
                " where UserID = " + userID;

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
    public bool updateDetails(string userId, string phoneNumber, string userMail, string userPassword, string city)
    {
        SqlConnection con = null;

        try
        {
            con = connect();
            int countUpdatesUser = 0;
            bool updatedUser = true;


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


            if (countUpdatesUser > 0)
            {
                string formattedCommandUser = String.Format(commandUser);
                SqlCommand updateUser = new SqlCommand(formattedCommandUser, con);
                updatedUser = Convert.ToBoolean(updateUser.ExecuteNonQuery());
            }

            return updatedUser;

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
    // Dashboard Page 
    //--------------------------------------------------------------------

    //public DataTable getUserLastEvent(string userID)
    //{
    //    try
    //    {
    //        string query = "Select TOP 1 * from events e"
    //+ " join dbo.TeamsEvents t on t.EventID = e.EventID"
    //+ " join dbo.Athletes a on t.TeamID = a.TeamID"
    //+ " WHERE a.AthleteID =" + userID +
    //" ORDER BY E_Date DESC";

    //        DataTable UserEvent = queryDb(query);

    //        return UserEvent;
    //    }
    //    catch (Exception ex)
    //    {
    //        using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
    //        {
    //            Log(ex.Message, w);
    //        }
    //        throw ex;
    //    }

    //}


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

    //--------------------------------------------------------------------
    // Results Page
    //--------------------------------------------------------------------
    public DataTable getCoachResults(string coachID)
    {
        try
        {
            string query = "SELECT " +
            " *, Users.FirstName,Users.LastName,Users.UserID " +
            " from results join athletes " +
            " on Athletes.AthleteID = Results.AthleteID join Users " +
            " on Users.UserID = Athletes.AthleteID join teams " +
            " on teams.TeamID = Athletes.TeamID join Coaches " +
            " on Coaches.CoachId = teams.HeadCoachID " +
            " where Coaches.coachID =" + coachID +
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
    // Events Page
    //--------------------------------------------------------------------

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
            using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public bool addEvent(string teamId, string eventName, string eventDate, string eventDescription, string eventType, string startTime,
        string endTime, string location)
    {
        SqlConnection con = null;

        int eventTypeNum = 0;

        switch (eventType)
        {
            case "אימון":
                eventTypeNum = 1;
                break;

            case "משחק":
                eventTypeNum = 2;
                break;

            case "מפגש":
                eventTypeNum = 3;
                break;
        }

        try
        {
            con = connect();

            //CreationTime change to STRING in db!!!!

            string command = "INSERT INTO [dbo].[Events] " +
                             "([EventType], [Title], [E_Body], [E_Date],[StartTime],[EndTime],[IsRecursive],[Location],[Note],[CreationTime])" +
                             " VALUES({0},'{1}','{2}','{3}','{4}','{5}',{6},'{7}',{8},{9}); SELECT CAST(scope_identity() AS int)";

            //string[] DateStringArray = eventDate.Split('-');

            //string parsedDate = DateStringArray[2] + "-" + DateStringArray[1] + "-" + DateStringArray[0];
            //string datet = DateTime.Now.ToString("yyyy-mm-dd hh:mi:ss");


            string formattedCommand = String.Format(command, eventTypeNum, eventName, eventDescription, eventDate, startTime, endTime, "null", location, "null", "null");

            int eventId = insertEvent(formattedCommand, true);

            int TeamId = int.Parse(teamId);

            insertTeamEvent(eventId, TeamId);

            return true;

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

    public int insertEvent(string command, bool isCreate)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            SqlCommand cmd = new SqlCommand(command, con);

            int newID = -1;

            if (isCreate)
            {
                newID = (int)cmd.ExecuteScalar();
            }
            else
            {
                newID = (int)cmd.ExecuteNonQuery();
            }

            if (con.State == System.Data.ConnectionState.Open) con.Close();

            return newID;
        }
        catch (Exception ex)
        {
            //using (StreamWriter w = File.AppendText(HttpContext.Current.Server.MapPath("~/log.txt")))
            //{
            //    Log(ex.Message, w);
            //}
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

    public bool insertTeamEvent(int eventId, int teamId)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            string command = " INSERT INTO"
                + " TeamsEvents(EventId, TeamId)"
                + "  VALUES(" + eventId + ", " + teamId + ") ";

            string formattedCommand = String.Format(command, eventId, teamId);

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


    //--------------------------------------------------------------------
    // Messages page
    //--------------------------------------------------------------------

    public DataTable getCoachMessages(string coachID)
    {
        try
        {
            string query = " SELECT m.*, t.TeamName " +
                " FROM dbo.Messages m JOIN dbo.TeamsMessages tm on m.MessageID = tm.MessageID  " +
                " JOIN dbo.Teams t on t.TeamID = tm.TeamID " +
                " WHERE m.CreatorID=" + coachID + " ORDER BY mDate DESC, mTime DESC";

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

    public string getMessagesCount(string coachID)
    {
        try
        {
            string query = "SELECT count(*) as messagesCount " +
                " FROM dbo.Messages CROSS JOIN dbo.Teams " +
                " WHERE dbo.Messages.CreatorID=" + coachID;

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


    //--------------------------------------------------------------------
    // Dashboard page
    //--------------------------------------------------------------------

    public DataTable getCoachLastResults(string coachID)
    {
        try
        {
            string query = "SELECT TOP (3) " +
            " *, Users.FirstName,Users.LastName,Users.UserID " +
            " from results join athletes " +
            " on Athletes.AthleteID = Results.AthleteID join Users " +
            " on Users.UserID = Athletes.AthleteID join teams " +
            " on teams.TeamID = Athletes.TeamID join Coaches " +
            " on Coaches.CoachId = teams.HeadCoachID " +
            " where Coaches.coachID =" + coachID +
            " ORDER BY dbo.Results.rDate DESC ";

            DataTable CoachLastResults = queryDb(query);

            return CoachLastResults;
        }
        catch (Exception ex)
        {
            using (StreamWriter w = File.AppendText("log.txt"))
            {
                Log(ex.Message, w);
            }
            throw ex;
        }

    }

    public DataTable getCoachLastMessages(string coachID)
    {
        try
        {
            string query = " SELECT TOP(3) m.*, t.TeamName " +
                " FROM dbo.Messages m  JOIN  dbo.TeamsMessages tm on m.MessageID = tm.MessageID " +
                " JOIN dbo.Teams t on t.TeamID = tm.TeamID " +
                " WHERE m.CreatorID=" + coachID + " ORDER BY mDate DESC, mTime DESC";

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

    public DataTable getCoachTeams(string coachID)
    {
        try
        {
            string query = "select TeamID, TeamName from dbo.teams where HeadCoachID = " + coachID;

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

    public List<string> getUserRegsFromTeams(List<String> teamIds)
    {
        String query = "SELECT RegID from UsersReg u join dbo.Athletes a on u.UserID = a.AthleteID WHERE TeamID IN({0})";
        String teamStr = "";

        foreach (String teamId in teamIds)
        {
            teamStr += teamId;
            teamStr += ",";
        }

        DataTable dt = queryDb(String.Format(query, teamStr.Substring(0, teamStr.Length - 1)));

        List<String> regIds = new List<String>();

        foreach (DataRow row in dt.Rows)
        {
            regIds.Add(row[0].ToString());
        }

        return regIds;
    }

    public void createNewMessage(string title, string message, List<string> teamIds, string coachId)
    {
        String date = DateTime.Now.ToString("yyyy-MM-dd");
        String hours = DateTime.Now.ToString().Split(' ')[1];

        String insertQuery = "INSERT INTO dbo.Messages (CreatorID, Title, mBody, mDate, mTime) VALUES({0}, '{1}', '{2}', '{3}', '{4}'); SELECT CAST(scope_identity() AS int)";

        int messageId = insertMessage(String.Format(insertQuery, coachId, title, message, date, hours), true);

        String insertQuery2 = "INSERT INTO dbo.TeamsMessages VALUES({0}, {1})";

        foreach (String teamId in teamIds)
        {
            insertMessage(String.Format(insertQuery2, messageId, teamId), false);
        }
    }

    public int insertMessage(string command, bool isCreate)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            SqlCommand cmd = new SqlCommand(command, con);

            int newID = -1;

            if (isCreate)
            {
                newID = (int)cmd.ExecuteScalar();
            }
            else
            {
                newID = (int)cmd.ExecuteNonQuery();
            }

            if (con.State == System.Data.ConnectionState.Open) con.Close();

            return newID;
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
    // Attendance
    //--------------------------------------------------------------------

    public DataTable getTodayEvents(string coachId)
    {
        try
        {
            string query = "Select * from events e"
             + " join dbo.TeamsEvents t on t.EventID = e.EventID"
             + " join dbo.Teams te on t.TeamID = te.TeamID"
             + " join dbo.Coaches c on te.HeadCoachID = c.CoachID"
             + " WHERE c.CoachID =" + coachId
             + " AND E_Date=Convert(date,getdate(),105)"
             + " ORDER BY E_Date DESC ";

            DataTable todayEvent = queryDb(query);

            return todayEvent;
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

    public DataTable getEventMembers(string eventID)
    {
        try
        {

            string query = "select * from Users u"
            + " join Athletes a on u.UserID = a.AthleteID"
            + " join Teams t on a.TeamID = t.TeamID"
            + " join TeamsEvents te on te.TeamID = t.TeamID"
            + " join Events e on e.EventID = te.EventID"
            + " where e.EventID = " + eventID;

            DataTable usersTable = queryDb(query);

            return usersTable;
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

    public string insertAttendance(List<Attendance> attendanceArr)
    {


        SqlConnection con = null;
        int response = 0;
        con = connect();

        try
        {
            foreach (Attendance row in attendanceArr)
            {
                string UserId = row.athleteId;
                string Attend = row.present;
                string EventId = row.eventId;
                string note = "null";

                string query = " INSERT INTO[dbo].[Attendances]"
                + " ([EventID],[AthleteID],[IsAttend],[Note]) VALUES "
                 + " (" + EventId + "," + UserId + "," + Attend + "," + note + ")";

                SqlCommand insert = new SqlCommand(String.Format(query), con);

                response += insert.ExecuteNonQuery();
            }
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

        return (response.ToString());
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