using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for User
/// </summary>
/// 

public class User
{
    //Fields
    private string firstName, lastName, phoneNumber, birthDate, email, password, picture, city;
    private int userType, userId;

    //Ctros
    public User()
    {

    }

    public User(int userType, string firstName, string lastName, string phoneNumber, string birthDate, string email, string password, string picture, string city)
    {
        this.UserType = userType;
        this.FirstName = firstName;
        this.LastName = lastName;
        this.PhoneNumber = phoneNumber;
        this.BirthDate = birthDate;
        this.Email = email;
        this.Password = password;
        this.Picture = picture;
        this.City = city;
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
    public string PhoneNumber
    {
        get { return phoneNumber; }
        set { phoneNumber = value; }
    }
    public string BirthDate
    {
        get
        {
            return birthDate;
        }

        set
        {
            birthDate = value;
        }
    }
    public string Email
    {
        get
        {
            return email;
        }

        set
        {
            email = value;
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
    public string Picture
    {
        get
        {
            return picture;
        }

        set
        {
            picture = value;
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
    public int UserType
    {
        get
        {
            return userType;
        }

        set
        {
            userType = value;
        }
    }
    public int UserId
    {
        get
        {
            return userId;
        }

        set
        {
            userId = value;
        }
    }

}

