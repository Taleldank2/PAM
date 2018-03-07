using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Team
    {
        //Fileds
        private string teamName;
        private int teamNumber, coachNumber;

        //Ctors

        public Team()
        {

        }

        public Team(string teamName, int coachNumber)
        {
            this.teamName = teamName;
            this.coachNumber = coachNumber;
        }

        public Team(string teamName)
        {
            this.teamName = teamName;
        }

        //Props
        public int CoachNumber
        {
            get
            {
                return coachNumber;
            }

            set
            {
                coachNumber = value;
            }
        }

        public string TeamName
        {
            get
            {
                return teamName;
            }

            set
            {
                teamName = value;
            }
        }

        public int TeamNumber
        {
            get
            {
                return teamNumber;
            }

            set
            {
                teamNumber = value;
            }
        }
    }
}
