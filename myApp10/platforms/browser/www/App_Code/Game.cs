using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Game
/// </summary>
/// 

public class Game : Event
{

    //fields
    private int opponentGoals, tivonGoals;
    private string goTransportTime, transportLocation, backTransportTime, opponent;
    private bool isHome;

    //Ctors
    public Game()
    {

    }
    public Game(int opponentGoals, int tivonGoals, string goTransportTime, string transportLocation, string backTransportTime, string opponent, bool isHome)
    {
        this.OpponentGoals = opponentGoals;
        this.TivonGoals = tivonGoals;
        this.GoTransportTime = goTransportTime;
        this.TransportLocation = transportLocation;
        this.BackTransportTime = backTransportTime;
        this.Opponent = opponent;
        this.IsHome = isHome;
    }

    //Props

    public int OpponentGoals
    {
        get
        {
            return opponentGoals;
        }

        set
        {
            opponentGoals = value;
        }
    }

    public int TivonGoals
    {
        get
        {
            return tivonGoals;
        }

        set
        {
            tivonGoals = value;
        }
    }

    public string GoTransportTime
    {
        get
        {
            return goTransportTime;
        }

        set
        {
            goTransportTime = value;
        }
    }

    public string TransportLocation
    {
        get
        {
            return transportLocation;
        }

        set
        {
            transportLocation = value;
        }
    }

    public string BackTransportTime
    {
        get
        {
            return backTransportTime;
        }

        set
        {
            backTransportTime = value;
        }
    }

    public string Opponent
    {
        get
        {
            return opponent;
        }

        set
        {
            opponent = value;
        }
    }

    public bool IsHome
    {
        get
        {
            return isHome;
        }

        set
        {
            isHome = value;
        }
    }
}

