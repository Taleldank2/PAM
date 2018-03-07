using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class Message
    {
        //Fileds
        private int createNumber, teamNumber;
        private string title, body, messageDate, messageTime;

        //Ctors
        public Message()
        {

        }
        public Message(int createNumber, int teamNumber, string title, string body, string messageDate, string messageTime)
        {
            this.createNumber = createNumber;
            this.teamNumber = teamNumber;
            this.title = title;
            this.body = body;
            this.messageDate = messageDate;
            this.messageTime = messageTime;
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

        public int CreateNumber
        {
            get
            {
                return createNumber;
            }

            set
            {
                createNumber = value;
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
    }
}
