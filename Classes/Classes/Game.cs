using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Game : Event
    {

        //fields
        private int eventNumber, rivalGoals, homeGoals;
        private string transTime, transLoction, backTime, rival;
        private bool homePlay;

        //Ctors
        public Game()
        {

        }
        public Game(int eventNumber, int rivalGoals, int homeGoals, string transTime, string transLoction, string backTime, string rival, bool homePlay)
        {
            this.EventNumber1 = eventNumber;
            this.RivalGoals = rivalGoals;
            this.HomeGoals = homeGoals;
            this.TransTime = transTime;
            this.TransLoction = transLoction;
            this.BackTime = backTime;
            this.Rival = rival;
            this.HomePlay = homePlay;
        }

        //Props

        public int EventNumber1
        {
            get
            {
                return eventNumber;
            }

            set
            {
                eventNumber = value;
            }
        }

        public int RivalGoals
        {
            get
            {
                return rivalGoals;
            }

            set
            {
                rivalGoals = value;
            }
        }

        public int HomeGoals
        {
            get
            {
                return homeGoals;
            }

            set
            {
                homeGoals = value;
            }
        }

        public string TransTime
        {
            get
            {
                return transTime;
            }

            set
            {
                transTime = value;
            }
        }

        public string TransLoction
        {
            get
            {
                return transLoction;
            }

            set
            {
                transLoction = value;
            }
        }

        public string BackTime
        {
            get
            {
                return backTime;
            }

            set
            {
                backTime = value;
            }
        }

        public string Rival
        {
            get
            {
                return rival;
            }

            set
            {
                rival = value;
            }
        }

        public bool HomePlay
        {
            get
            {
                return homePlay;
            }

            set
            {
                homePlay = value;
            }
        }

    }
}
