using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Result
    {

        //Fields
        private int athleteNumber, kindResult;
        private double distance;
        private string timeResult, dateResult, rank;

        //Ctors
        public Result()
        {

        }
        public Result(int athleteNumber, int kindResult, double distance, string timeResult, string dateResult, string rank)
        {
            this.athleteNumber = athleteNumber;
            this.kindResult = kindResult;
            this.distance = distance;
            this.timeResult = timeResult;
            this.dateResult = dateResult;
            this.rank = rank;
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

        public string DateResult
        {
            get
            {
                return dateResult;
            }

            set
            {
                dateResult = value;
            }
        }

        public double Distance
        {
            get
            {
                return distance;
            }

            set
            {
                distance = value;
            }
        }

        public int KindResult
        {
            get
            {
                return kindResult;
            }

            set
            {
                kindResult = value;
            }
        }

        public string Rank
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

        public string TimeResult
        {
            get
            {
                return timeResult;
            }

            set
            {
                timeResult = value;
            }
        }
    }
}
