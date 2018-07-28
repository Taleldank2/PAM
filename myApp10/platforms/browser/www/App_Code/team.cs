using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Team
/// </summary>
/// 


public class Team
{
    //Fileds
    private string teamName;
    private int teamId, headCoachId;

    //Ctors

    public Team()
    {

    }

    public Team(string teamName, int headCoachId)
    {
        this.TeamName = teamName;
        this.HeadCoachId = headCoachId;
    }

    public Team(string teamName)
    {
        this.teamName = teamName;
    }

    //Props
    public int HeadCoachId
    {
        get
        {
            return headCoachId;
        }

        set
        {
            headCoachId = value;
        }
    }

    public string TeamName
    {
        get
        {
            return teamName;
        }

        set
        {
            teamName = value;
        }
    }

    public int TeamId
    {
        get
        {
            return teamId;
        }

        set
        {
            teamId = value;
        }
    }
}

