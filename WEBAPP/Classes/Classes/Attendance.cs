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
        private string remark;

        //Ctors
        public Attendance()
        {

        }
        public Attendance(int eventNumber, int athleteNumber, bool present, string remark)
        {
            this.eventNumber = eventNumber;
            this.athleteNumber = athleteNumber;
            this.present = present;
            this.remark = remark;
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

        public string Remark
        {
            get
            {
                return remark;
            }

            set
            {
                remark = value;
            }
        }

    }
}
