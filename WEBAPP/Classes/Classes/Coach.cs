using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{

    
    class Coach : User
    {
        //Fields
        private string enterDate;

        //Ctors
        public Coach() 
        {

        }

        public Coach(string enterDate)
        {
            this.enterDate = enterDate;
        }

        //Props
        public string EnterDate
        {
            get
            {
                return enterDate;
            }

            set
            {
                enterDate = value;
            }
        }

    }
}
