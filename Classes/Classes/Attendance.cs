using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Attendance
    {

        //Fields
        private int eventNumber, athleteNumber;
        private bool present;
        private string note;

        //Ctors
        public Attendance()
        {

        }
        public Attendance(int eventNumber, int athleteNumber, bool present, string note)
        {
            this.EventNumber = eventNumber;
            this.AthleteNumber = athleteNumber;
            this.Present = present;
            this.Note = note;
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

        public int EventNumber
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
}
