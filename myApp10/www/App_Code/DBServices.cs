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
                        " WHERE PhoneNumber ='" + userID + "'";

        DataTable user = queryDb(query);

        return user;
    }

    //public DataTable getUserType(string userID)
    //{

    //    string query = "SELECT * FROM Users" +
    //                    " WHERE UserID ='" + userID + "'";

    //    DataTable user = queryDb(query);

    //    return user;
    //}

    //--------------------------------------------------------------------
    // Register
    //--------------------------------------------------------------------

    public bool registerUser(string userType, string userName, string userLastName, string phoneNumber,
                           string userMail, string userPassword, string userPicBase64, string city,
                           string userBirthday, string userTeam, string athleteWeight, string athleteHeight)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            //android_asset/www/
            string picPath = "images/profiles/" + phoneNumber + ".html";

            savePicture(picPath, userPicBase64);

            string command = " INSERT INTO[dbo].[Users] " +
                             " ([UserType], [FirstName], [LastName], [PhoneNumber], [Email], " +
                             " [Password],[Picture],[City],[BirthDate]) " +
                             " VALUES({0},'{1}','{2}','{3}','{4}','{5}','{6}','{7}',{8}); SELECT CAST(scope_identity() AS int) ";

            string[] birthDayArray = userBirthday.Split('-');

            string parsedBirthDay = "Convert(date,'" + birthDayArray[2] + "-" + birthDayArray[1] + "-" + birthDayArray[0] + "', 105)";


            int userId = insertAthlete(String.Format(command, userType, userName, userLastName,
                phoneNumber, userMail, userPassword, picPath, city, parsedBirthDay), true);

            //SqlCommand insert = new SqlCommand(formattedCommand, con);

            registerAthlete(userId, userTeam, athleteWeight, athleteHeight);

            return true;

            //Convert.ToBoolean(insert.ExecuteNonQuery());

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

    public int insertAthlete(string command, bool isCreate)
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

    public bool registerAthlete(int userId, string userTeam, string athleteWeight, string athleteHeight)
    {
        SqlConnection con = null;

        try
        {
            con = connect();

            string command = "INSERT INTO [dbo].[Athletes] " +
                             "([AthleteID], [TeamID], [Highet], [Weight], [AppScore]) " +
                             " VALUES({0},'{1}','{2}','{3}','{4}')";

            //each register athlete first get 100 points for the registretion
            string formattedCommand = String.Format(command, userId, userTeam, athleteWeight, athleteHeight, 100);

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

    public void addUserReg(string userId, string regId)
    {
        string query = "INSERT INTO dbo.UsersReg (UserID, RegID) VALUES ({0}, '{1}')";

        SqlConnection con = null;

        try
        {
            con = connect();

            SqlCommand insert = new SqlCommand(String.Format(query, userId, regId), con);

            insert.ExecuteNonQuery();
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

        DataTable UserDetails = queryDb(query);

        return UserDetails;
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
    // index Page 
    //--------------------------------------------------------------------
    public DataTable getUserNextEvent(string userID)
    {

        string query = "Select TOP 1 * from events e"
            + " join dbo.TeamsEvents t on t.EventID = e.EventID"
            + " join dbo.Athletes a on t.TeamID = a.TeamID"
            + " WHERE a.AthleteID =" + userID + " AND"
            + " (convert(datetime,(E_Date))+convert(datetime,(StartTime)))>=getdate()"
            + " ORDER BY E_Date ";

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
        try
        {
            string query = "select AppScore	from athletes where AthleteID = " + userID;

            DataTable scoreTable = queryDb(query);

            string userScore = scoreTable.Rows[0][0].ToString();

            return userScore;
        }
        catch (Exception)
        {
            return null;
            throw;
        }

    }

    public bool updateToScore(string userID, int newScore)
    {
        SqlConnection con = null;
        try
        {
            con = connect();

            string command = " UPDATE [dbo].[Athletes] " +
                " SET AppScore =" + newScore +
                " WHERE athleteId=" + userID;


            string formattedCommand = String.Format(command);
            SqlCommand updateScoreCommand = new SqlCommand(formattedCommand, con);

            return (Convert.ToBoolean(updateScoreCommand.ExecuteNonQuery()));
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

    public string getUserName(string userID)
    {

        string query = "Select Users.FirstName from Users" +
                        " Join Athletes ON Users.UserID = Athletes.AthleteID" +
                        " where AthleteID = " + userID;

        DataTable userNames = queryDb(query);

        string userName = userNames.Rows[0][0].ToString();

        return userName;
    }

    public DataTable getUserLastResult(string userID)
    {

        string query = "select top 1 * from results " +
                        "join ResultTypes on results.ResultType = ResultTypes.ResultType " +
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

    public bool insertResult(string UserID, string ResultDate, string ResultType, string ResultDistance, string ResultTimeMin, string ResultTimeSec, string ResultNote)
    {
        SqlConnection con = null;
        try
        {

            string parseResultTimeSec = ResultTimeSec;
            if (int.Parse(ResultTimeSec) < 10)
            {
                parseResultTimeSec = "0" + ResultTimeSec;
            }
            string parseResultTimeMin = ResultTimeMin;
            if (int.Parse(ResultTimeMin) < 10)
            {
                parseResultTimeMin = "0" + ResultTimeMin;
            }

            string[] ResultDateArr = ResultDate.Split('-');
            string parseResultDate = "Convert(date,'" + ResultDateArr[2] + "-" + ResultDateArr[1] + "-" + ResultDateArr[0] + "', 105)";

            con = connect();

            string command = " INSERT INTO [dbo].[Results] " +
                " (AthleteID,ResultType,Distance,rTime,rDate,Note) " +
                " VALUES (" + UserID + "," + ResultType + "," + ResultDistance + ",'00:" + parseResultTimeMin + ":"+ parseResultTimeSec + "'," + parseResultDate + ",'" + ResultNote + "') ";


            string formattedCommand = String.Format(command);
            SqlCommand addNewResultCommand = new SqlCommand(formattedCommand, con);

            return (Convert.ToBoolean(addNewResultCommand.ExecuteNonQuery()));
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

    //--------------------------------------------------------------------
    // Messages page
    //--------------------------------------------------------------------

    public DataTable getUserMessages(string userID)
    {
        string query = "SELECT * FROM [dbo].[Messages] m " +
                       "JOIN dbo.TeamsMessages t on m.MessageID = t.MessageID " +
                       "join dbo.Athletes a on t.TeamID = a.TeamID " +
                       "join Users u on m.CreatorID = u.UserID " +
                       "WHERE AthleteID = " + userID;

        DataTable messagesTable = queryDb(query);

        return messagesTable;
    }


}