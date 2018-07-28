using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EventRates
/// </summary>
/// 

public class EventRates
{

    //Fields
    private int teamId, athleteId, rate;

    //Ctors
    public EventRates()
    {

    }
    public EventRates(int teamId, int athleteId, int rate)
    {
        this.AthleteId = athleteId;
        this.TeamId = teamId;
        this.Rate = rate;
    }

    //Props
    public int AthleteId
    {
        get
        {
            return athleteId;
        }

        set
        {
            athleteId = value;
        }
    }

    public int Rate
    {
        get
        {
            return rate;
        }

        set
        {
            rate = value;
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

