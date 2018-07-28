using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Event
/// </summary>
/// 

public class Event
{

    //Fields
    private int teamId, eventType, eventId;
    private string title, body, eventDate, startTime, endTime, location, note, creationTime;
    private bool isRecursive;

    //Ctors
    public Event()
    {

    }
    public Event(int teamId, int eventType, string title, string body, string eventDate, string startTime, string endTime, string location, bool isRecursive, string note)
    {
        this.TeamId = teamId;
        this.EventType = eventType;
        this.Title = title;
        this.Body = body;
        this.EventDate = eventDate;
        this.StartTime = startTime;
        this.EndTime = endTime;
        this.Location = location;
        this.Note = note;
        this.IsRecursive = isRecursive;
    }

    //Props
    public string Body
    {
        get
        {
            return body;
        }

        set
        {
            body = value;
        }
    }

    public string EndTime
    {
        get
        {
            return endTime;
        }

        set
        {
            endTime = value;
        }
    }

    public string EventDate
    {
        get
        {
            return eventDate;
        }

        set
        {
            eventDate = value;
        }
    }

    public int EventType
    {
        get
        {
            return eventType;
        }

        set
        {
            eventType = value;
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

    public string Location
    {
        get
        {
            return location;
        }

        set
        {
            location = value;
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

    public string StartTime
    {
        get
        {
            return startTime;
        }

        set
        {
            startTime = value;
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

    public string Title
    {
        get
        {
            return title;
        }

        set
        {
            title = value;
        }
    }

    public bool IsRecursive
    {
        get
        {
            return isRecursive;
        }

        set
        {
            isRecursive = value;
        }
    }

    public string CreationTime
    {
        get
        {
            return creationTime;
        }

        set
        {
            creationTime = value;
        }
    }
}

