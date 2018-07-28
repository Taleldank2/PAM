using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Message
/// </summary>
/// 

public class Message
{
    //Fileds
    private int messageId, creatorId, teamId;
    private string title, body, messageDate, messageTime;

    //Ctors
    public Message()
    {

    }
    public Message(int creatorId, int teamId, string title, string body, string messageDate, string messageTime)
    {
        this.CreatorId = creatorId;
        this.TeamId = teamId;
        this.Title = title;
        this.Body = body;
        this.MessageDate = messageDate;
        this.MessageTime = messageTime;
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

    public int CreatorId
    {
        get
        {
            return creatorId;
        }

        set
        {
            creatorId = value;
        }
    }

    public string MessageDate
    {
        get
        {
            return messageDate;
        }

        set
        {
            messageDate = value;
        }
    }

    public string MessageTime
    {
        get
        {
            return messageTime;
        }

        set
        {
            messageTime = value;
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
}
