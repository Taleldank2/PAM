using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Classes
{
    class User
    {
        //Fields
        private string firstName, lastName, cellPhoneNumber, birthdayDate, emailAdress, password, photo, city;
        private int kindUser,userNumber;

        //Ctros
        public User()
        {
                
        }

        public User(int kindUser, string firstName, string lastName, string cellPhoneNumber, string birthdayDate, string emailAdress, string password, string photo, string city)
        {
            this.kindUser = kindUser;
            this.firstName = firstName;
            this.lastName = lastName;
            this.cellPhoneNumber = cellPhoneNumber;
            this.birthdayDate = birthdayDate;
            this.emailAdress = emailAdress;
            this.password = password;
            this.photo = photo;
            this.city = city;
        }


        //Props

        public string FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }
        
        public string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }

        public string CellPhoneNumber
        {
            get { return cellPhoneNumber; }
            set { cellPhoneNumber = value; }
        }

        public string BirthdayDate
        {
            get
            {
                return birthdayDate;
            }

            set
            {
                birthdayDate = value;
            }
        }

        public string EmailAdress
        {
            get
            {
                return emailAdress;
            }

            set
            {
                emailAdress = value;
            }
        }

        public string Password
        {
            get
            {
                return password;
            }

            set
            {
                password = value;
            }
        }

        public string Photo
        {
            get
            {
                return photo;
            }

            set
            {
                photo = value;
            }
        }

        public string City
        {
            get
            {
                return city;
            }

            set
            {
                city = value;
            }
        }

        public int KindUser
        {
            get
            {
                return kindUser;
            }

            set
            {
                kindUser = value;
            }
        }

        public int UserNumber
        {
            get
            {
                return userNumber;
            }

            set
            {
                userNumber = value;
            }
        }
    }
}
