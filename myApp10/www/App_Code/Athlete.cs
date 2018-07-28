using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Athlete
/// </summary>
/// 

public class Athlete : User
{
    //Fields
    private double height, weight, appScore;
    private int teamId;

    //Ctors
    public Athlete()
    {

    }

    public Athlete(int teamId, double height, double weight, double appScore)
    {
        this.TeamId = teamId;
        this.Height = height;
        this.Weight = weight;
        this.AppScore = appScore;
    }

    //Props
    public double Height
    {
        get
        {
            return height;
        }

        set
        {
            height = value;
        }
    }

    public double AppScore
    {
        get
        {
            return appScore;
        }

        set
        {
            appScore = value;
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

    public double Weight
    {
        get
        {
            return weight;
        }

        set
        {
            weight = value;
        }
    }

}

