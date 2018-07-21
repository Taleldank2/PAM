using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Coach
/// </summary>
/// 

public class Coach : User
{
    //Fields
    private string startDate;

    //Ctors
    public Coach()
    {

    }

    public Coach(string startDate)
    {
        this.StartDate = startDate;
    }

    //Props
    public string StartDate
    {
        get
        {
            return startDate;
        }

        set
        {
            startDate = value;
        }
    }

}

