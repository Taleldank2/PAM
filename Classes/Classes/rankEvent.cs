using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class RankEvent
    {

        //Fields
        private int teamNumber, athleteNumber, rank;

        //Ctors
        public RankEvent()
        {

        }
        public RankEvent(int teamNumber, int athleteNumber, int rank)
        {

        }

        //Props
        public int AthleteNumber
        {
            get
            {
                return athleteNumber;
            }

            set
            {
                athleteNumber = value;
            }
        }

        public int Rank
        {
            get
            {
                return rank;
            }

            set
            {
                rank = value;
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
