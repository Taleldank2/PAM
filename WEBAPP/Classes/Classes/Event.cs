using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Event
    {

        //Fields
        private int teamNumber, eventKind, eventNumber;
        private string title, body, eventDate, startTime, endTime, loction, remark;
        private bool recurrent;

        //Ctors
        public Event()
        {

        }
        public Event(int teamNumber, int eventKind, string title, string body, string eventDate, string startTime, string endTime, string loction, bool recurrent, string remark)
        {
            this.TeamNumber = teamNumber;
            this.EventKind = eventKind;
            this.Title = title;
            this.Body = body;
            this.EventDate = eventDate;
            this.StartTime = startTime;
            this.EndTime = endTime;
            this.Loction = loction;
            this.Remark = remark;
            this.Recurrent = recurrent;
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

        public int EventKind
        {
            get
            {
                return eventKind;
            }

            set
            {
                eventKind = value;
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

        public string Loction
        {
            get
            {
                return loction;
            }

            set
            {
                loction = value;
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

        public bool Recurrent
        {
            get
            {
                return recurrent;
            }

            set
            {
                recurrent = value;
            }
        }
    }
}
