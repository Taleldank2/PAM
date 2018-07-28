using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Result
/// </summary>
/// 

public class Result
{

    //Fields
    private int athleteId, resultType,resultId;
    private double distance;
    private string resultTime, resultDate, note;

    //Ctors
    public Result()
    {

    }
    public Result(int athleteId, int resultType, double distance, string resultTime, string resultDate, string note)
    {
        this.AthleteId = athleteId;
        this.ResultType = resultType;
        this.Distance = distance;
        this.ResultTime = resultTime;
        this.ResultDate = resultDate;
        this.Note = note;
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

    public string ResultDate
    {
        get
        {
            return resultDate;
        }

        set
        {
            resultDate = value;
        }
    }

    public double Distance
    {
        get
        {
            return distance;
        }

        set
        {
            distance = value;
        }
    }

    public int ResultType
    {
        get
        {
            return resultType;
        }

        set
        {
            resultType = value;
        }
    }

    public string Note
    {
        get
        {
            return note;
        }

        set
        {
            note = value;
        }
    }

    public string ResultTime
    {
        get
        {
            return resultTime;
        }

        set
        {
            resultTime = value;
        }
    }

    public int ResultId
    {
        get
        {
            return resultId;
        }

        set
        {
            resultId = value;
        }
    }
}
