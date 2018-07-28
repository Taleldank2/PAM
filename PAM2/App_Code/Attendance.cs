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
    private string EventId, AthleteId;
    private string Present;
    private string Note;

    //Ctors
    public Attendance()
    {

    }

    //public Attendance(int eventId, int athleteId, bool present, string note)
    //{
    //    this.EventId = eventId;
    //    this.AthleteId = athleteId;
    //    this.Present = present;
    //    this.Note = note;
    //}

    //Props

    public string athleteId
    {
        get
        {
            return AthleteId;
        }

        set
        {
            AthleteId = value;
        }
    }

    public string eventId
    {
        get
        {
            return EventId;
        }

        set
        {
            EventId = value;
        }
    }
    
    public string present
    {
        get
        {
            return Present;
        }

        set
        {
            Present = value;
        }
    }

    public string note
    {
        get
        {
            return Note;
        }

        set
        {
            Note = value;
        }
    }

}
