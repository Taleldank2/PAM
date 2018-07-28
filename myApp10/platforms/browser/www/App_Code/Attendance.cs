using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Attendance
/// </summary>
/// 

public class Attendance
{

    //Fields
    private int eventId, athleteId;
    private bool present;
    private string note;

    //Ctors
    public Attendance()
    {

    }
    public Attendance(int eventId, int athleteId, bool present, string note)
    {
        this.EventId = eventId;
        this.AthleteId = athleteId;
        this.Present = present;
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

    public int EventId
    {
        get
        {
            return eventId;
        }

        set
        {
            eventId = value;
        }
    }

    public bool Present
    {
        get
        {
            return present;
        }

        set
        {
            present = value;
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

}
