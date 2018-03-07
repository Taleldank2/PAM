using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Athlete : User
    {
        //Fields
        private double height, weight, rank;
        private int teamNumber;

        //Ctors
        public Athlete()
        {

        }

        public Athlete(int teamNumber, double height, double weight, double rank)
        {
            this.teamNumber = teamNumber;
            this.height = height;
            this.weight = weight;
            this.rank = rank;
        }

        //Props
        public double Height
        {
            get
            {
                return height;
            }

            set
            {
                height = value;
            }
        }

        public double Rank
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

        public double Weight
        {
            get
            {
                return weight;
            }

            set
            {
                weight = value;
            }
        }
       

    }
}
