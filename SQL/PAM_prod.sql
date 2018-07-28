USE bgroup57_prod
go

------------------------------------------------------------------------------
------------------------------CREATE DATA BASE--------------------------------
------------------------------------------------------------------------------
--CREATE DATABASE PAM_prod;
go

------------------------------------------------------------------------------
--------------------------------CREATE TABELS---------------------------------
------------------------------------------------------------------------------
CREATE TABLE [Events] (
	EventID int IDENTITY(1,1),	
	EventType int NOT NULL,
	Title nvarchar(30),
	E_Body ntext,
	E_Date date,
	StartTime time,
	EndTime time,
	IsRecursive bit,
	Location ntext,
	Note ntext,
	CreationTime datetime,
	CONSTRAINT PK_EVENTS PRIMARY KEY (EventID)
)
GO

CREATE TABLE [Attendances] (
	EventID int,
	AthleteID int,
	IsAttend bit NOT NULL,
	Note ntext,
	CONSTRAINT PK_ATTENDANCES PRIMARY KEY (EventID,AthleteID)	
)
GO


CREATE TABLE [Athletes] (
	AthleteID int,
	TeamID int NOT NULL,
	Highet float,
	Weight float,
	AppScore int,
	CONSTRAINT PK_ATHLETES PRIMARY KEY (AthleteID)
)
GO

CREATE TABLE [Users] (
	UserID int IDENTITY(1,1),
	UserType int NOT NULL,
	FirstName nvarchar(30) NOT NULL,
	LastName nvarchar(30)NOT NULL,
	PhoneNumber nvarchar(30)NOT NULL,
	Email nvarchar(40) NOT NULL,
	Password nvarchar(9) NOT NULL,
	Picture nvarchar(200),
	City nvarchar(30),
	BirthDate date,
	CONSTRAINT PK_USERS PRIMARY KEY (UserID)  
)
GO

CREATE TABLE [Coaches] (
	CoachID int,
	StartDate date,
	CONSTRAINT PK_COACHES PRIMARY KEY (CoachID)	
)
GO

CREATE TABLE [Teams] (
	TeamID int IDENTITY(1,1),
	TeamName nvarchar(30) NOT NULL,
	HeadCoachID int NOT NULL,
	CONSTRAINT [PK_TEAMS] PRIMARY KEY (TeamID)
)
GO

CREATE TABLE [Messages] (
	MessageID int IDENTITY(1,1),	
	CreatorID int NOT NULL,
	Title nvarchar(30),
	mBody ntext,
	mDate date,
	mTime time,
  CONSTRAINT [PK_MESSAGES] PRIMARY KEY (MessageID)
)
GO

CREATE TABLE [Results] (
	ResultID int IDENTITY(1,1),
	AthleteID int NOT NULL,
	ResultType int NOT NULL,
	Distance float,
	rTime time,
	rDate date,
	Note ntext,
  CONSTRAINT [PK_RESULTS] PRIMARY KEY (ResultID)
)
GO

CREATE TABLE [Games] (
	GameId int,
	GoTransportTime time,
	BackTransportTime time,
	TransportLocation ntext,
	OpponentName nvarchar(30),
	OpponentGoals int,
	TivonScore int,
	IsHome bit,
    CONSTRAINT [PK_GAMES] PRIMARY KEY (GameId)
)
GO

CREATE TABLE [UserTypes] (
	UserType int,
	Description nvarchar(30) NOT NULL,
  CONSTRAINT [PK_USERTYPES] PRIMARY KEY (UserType)  
)
GO

CREATE TABLE [ResultTypes] (
	ResultType int,
	Description nvarchar(30) NOT NULL,
	CONSTRAINT [PK_RESULTTYPES] PRIMARY KEY (ResultType) 
)
GO


CREATE TABLE [EventTypes] (
	EventType int,
	Description nvarchar(30) NOT NULL,
	CONSTRAINT [PK_EVENTTYPES] PRIMARY KEY (EventType) 
)
GO

CREATE TABLE [EventRates] (
	EventID int,
	AthleteID int,
	Rate int,
	CONSTRAINT [PK_EVENTRATES] PRIMARY KEY (EventID,AthleteID)  
)
GO

CREATE TABLE [TeamsEvents] (
	EventID int,
	TeamID int,	
	CONSTRAINT [PK_TEAMEVENTS] PRIMARY KEY (EventID,TeamID) 
)
GO

CREATE TABLE [TeamsMessages] (
	MessageID int,
	TeamID int,	
	CONSTRAINT [PK_TEAMMESSAGES] PRIMARY KEY (MessageID,TeamID) 
)
GO

CREATE TABLE [UsersReg] (
	UserID int not null,
	RegID nvarchar(1000) not null,
	CONSTRAINT PK_COACHES PRIMARY KEY (UserID, RegID)	
)
GO


-----------------------------------------------------------------------------------------
--------------------------------FORIGEN KEYS---------------------------------------------
-----------------------------------------------------------------------------------------

ALTER TABLE [Events]  ADD CONSTRAINT [Events_fk0] FOREIGN KEY ([EventType]) REFERENCES [EventTypes]([EventType])
GO

ALTER TABLE [Attendances] ADD CONSTRAINT [Attendances_fk0] FOREIGN KEY ([EventID]) REFERENCES [Events]([EventID])
GO

ALTER TABLE [Attendances]  ADD CONSTRAINT [Attendances_fk1] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
GO

ALTER TABLE [Athletes]  ADD CONSTRAINT [Athletes_fk0] FOREIGN KEY ([AthleteID]) REFERENCES [Users]([UserID])
GO

ALTER TABLE [Athletes]  ADD CONSTRAINT [Athletes_fk1] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
GO

ALTER TABLE [Users]  ADD CONSTRAINT [Users_fk0] FOREIGN KEY ([UserType]) REFERENCES [UserTypes]([UserType])
GO

ALTER TABLE [Coaches]  ADD CONSTRAINT [Coaches_fk0] FOREIGN KEY ([CoachID]) REFERENCES [Users]([UserID])
GO

ALTER TABLE [Teams]  ADD CONSTRAINT [Teams_fk0] FOREIGN KEY ([HeadCoachID]) REFERENCES [Coaches]([CoachID])
GO

ALTER TABLE [Messages]  ADD CONSTRAINT [Messages_fk0] FOREIGN KEY ([CreatorID]) REFERENCES [Coaches]([CoachID])
GO

ALTER TABLE [Results]  ADD CONSTRAINT [Results_fk0] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
GO

ALTER TABLE [Results]  ADD CONSTRAINT [Results_fk1] FOREIGN KEY ([ResultType]) REFERENCES [ResultTypes]([ResultType])
GO

ALTER TABLE [Games]  ADD CONSTRAINT [Games_fk0] FOREIGN KEY ([GameId]) REFERENCES [Events]([EventID])
GO

ALTER TABLE [EventRates]  ADD CONSTRAINT [EventRates_fk0] FOREIGN KEY ([EventID]) REFERENCES [Events]([EventID])
GO

ALTER TABLE [EventRates]  ADD CONSTRAINT [EventRates_fk1] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
GO

ALTER TABLE [TeamsMessages]  ADD CONSTRAINT [TeamMessages_fk0] FOREIGN KEY ([MessageID]) REFERENCES [Messages]([MessageID])
GO

ALTER TABLE [TeamsMessages]  ADD CONSTRAINT [TeamMessages_fk1] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
GO

ALTER TABLE [TeamsEvents]  ADD CONSTRAINT [TeamEvents_fk0] FOREIGN KEY ([EventID]) REFERENCES [Events]([EventID])
GO

ALTER TABLE [TeamsEvents]  ADD CONSTRAINT [TeamEvents_fk1] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
GO

ALTER TABLE [UsersReg]  ADD CONSTRAINT [UsersReg_fk0] FOREIGN KEY ([UserID]) REFERENCES [Users]([UserID])
GO

-----------------------------------------------------------------------------------------
--------------------------------INSERT DATA INTO TABELS----------------------------------
-----------------------------------------------------------------------------------------

--------------------------------------------------
----------INSERT DATA DICTIONARY TABLES-----------
--------------------------------------------------

--------------------------------------------------
----------INSERT DATA RESULT TYPES----------------
--------------------------------------------------

INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(1, '�����')
	GO

	INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(2, '����')
	GO
	
	INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(3, '���')
	GO


--------------------------------------------------
------------INSERT DATA EVENT TYPES---------------
--------------------------------------------------

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(1,'�����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(2,'����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(3,'����')
GO

--------------------------------------------------
----------INSERT DATA USER TYPES------------------
--------------------------------------------------

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(1,'�������')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(2,'����')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(3,'���� �����')
GO

--------------------------------------------------
------------END OF DICTIONARY TABLES--------------
--------------------------------------------------

--------------------------------------------------
----------INSERT DATA PRIMARY TABLES--------------
--------------------------------------------------

--------------------------------------------------
----------INSERT DATA USER------------------------
--------------------------------------------------

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (3,'��','������','0523488825','talkaf1@gmail.com','825','images/profiles/profileempty.html','����',Convert(date,'14-04-1991',105))--SYS ADMIN
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (3,'��','����','0505999470','taleldan188@gmail.com','470','images/profiles/profileempty.html','�����',Convert(date,'20-02-1991',105))--SYS ADMIN
GO
	
INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (2,'����','������','0528539214','idankaftori@gmail.com','214','images/profiles/profileempty.html','�����',Convert(date,'12-02-1985',105))--COACH
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (2,'�����','�����','0504758325','lior.klain@gmail.com','325','images/profiles/profileempty.html','����� ��� �����',Convert(date,'18-10-1981',105))--COACH
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (2,'����','�����','0505999925','shaul.el@gmail.com','925','images/profiles/profileempty.html','����� ���',Convert(date,'19-12-1959',105))--COACH
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','���','0522549591','guycohen123@gmail.com','591','images/profiles/0522549591.html','�����',Convert(date,'19-12-2004',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'�����','����','0523553795','itamar1307@gmail.com','795','images/profiles/0523553795.html','����',Convert(date,'10-02-2002',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','����','0586636591','tom.kaplan@gmail.com','591','images/profiles/0586636591.html','����',Convert(date,'15-02-2003',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'����','�������','0504082324','korihash@gmail.com','324','images/profiles/0504082324.html','�����',Convert(date,'24-09-2002',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','�� ����','0546239300','guybenayun@gmail.com','300','images/profiles/0546239300.html','��� ���',Convert(date,'30-07-2005',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','������','0542847590','bennyb@gmail.com','590','images/profiles/0542847590.html','�����',Convert(date,'20-01-2004',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','��','0523956352','nirhen@gmail.com','352','images/profiles/0523956352.html','�����',Convert(date,'20-01-2002',105))--ATHLETE
GO

INSERT INTO USERS(
	UserType,
	FirstName,
	LastName,
	PhoneNumber,
	Email,
	Password,
	Picture,
	City,
	BirthDate
)
VALUES (1,'���','����','0544848396','guyeldan@gmail.com','396','images/profiles/0544848396.html','�����',Convert(date,'20-08-2003',105))--ATHLETE
GO


