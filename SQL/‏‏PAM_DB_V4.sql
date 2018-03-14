USE bgroup57_test2
go

-------------------------------------------------------------------------
--------------------------------PAM DB-----------------------------------
-------------------------------------------------------------------------
/*
SELECT * 
FROM sys.foreign_keys

ALTER TABLE TeamsMessages
DROP CONSTRAINT TeamMessages_fk0

ALTER TABLE TeamsMessages
DROP CONSTRAINT TeamMessages_fk1

ALTER TABLE TeamsEvents
DROP CONSTRAINT TeamEvents_fk0

ALTER TABLE TeamsEvents
DROP CONSTRAINT TeamEvents_fk1

ALTER TABLE Users
DROP CONSTRAINT Users_fk0

ALTER TABLE Coaches
DROP CONSTRAINT Coaches_fk0

ALTER TABLE Teams
DROP CONSTRAINT Teams_fk0

ALTER TABLE Messages
DROP CONSTRAINT Messages_fk0

ALTER TABLE Events
DROP CONSTRAINT Events_fk0
*/


/*
drop table Attendances
drop table UserTypes
drop table EventRates
drop table Games
drop table Messages
drop table Results
drop table ResultTypes
drop table Athletes
drop table Coaches
drop table Teams
drop table Users
drop table Events
drop table EventTypes
drop table TeamsEvents
drop table TeamsMessages
GO
*/


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
	CreationTime timestamp,
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
	mTime timestamp,
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
	Game_id int,
	GoTransportTime time,
	BackTransportTime time,
	TransportLocation ntext,
	OpponentName nvarchar(30),
	OpponentGoals int,
	TivonScore int,
	IsHome bit,
    CONSTRAINT [PK_GAMES] PRIMARY KEY (Game_id)
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

ALTER TABLE [Games]  ADD CONSTRAINT [Games_fk0] FOREIGN KEY ([Game_id]) REFERENCES [Events]([EventID])
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

-----------------------------------------------------------------------------------------
--------------------------------INSERT DATA INTO TABELS----------------------------------
-----------------------------------------------------------------------------------------


--------------------------------------------------
----------INSERT DATA EVENT TYPES-----------------
--------------------------------------------------


INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(1,'אימון כללי')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(2,'אימון ריצה')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(3,'אימון שחייה')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(4,'אימון כוח')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(5,'משחק')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(6,'שיחה')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(7,'צפייה במשחק')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(8,'ארוחה')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(9,'אחר')
GO


--------------------------------------------------
----------INSERT DATA EVENTS----------------------
--------------------------------------------------


INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (1,'אימון רגיל','תרגול דיוק מסירות ומהירות תנועה','12-4-2017','18:00','19:30',0,'בריכה','להגיע 10 דקות לפני תחילת האימון ולעשות חימום יבש',NULL)
GO
	
INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (1,'הכנה לפני משחק','נתרגל מצבי משחק והכנה טקטית','14-4-2017','18:00','19:00',1,'בריכה','לא לאחר!',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (1,'דגש על עבודת רגל רגל','נעבוד על הרבה רגל רגל','19-4-2017','18:00','19:00',0,'בריכה','להגיע לפני לעשות חימום יבש וריצה קלה!',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (5,'משחק נגד אס"א תל-אביב','חצי גמר גביע','16-4-2017','19:00','20:00',1,'אס"א תל-אביב','לנוח כמו שצריך',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (6,'שיחה הכנה לפני המשחק',NULL,'15-4-2017','20:00','21:00',1,'בית הספורטאי','להביא מאכל ושתיה',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (8,'ארוחה לכבוד האליפות!',NULL,'28-4-2017','19:00','21:00',1,'רחוב קק"ל 20','להגיע רעבים ;)',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (2,'אימון ריצה עם שאול',NULL,'19-4-2017','18:30','19:15',0,'חנייה','ביגוד ריצה',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (3,'אימון שחייה','3 קילוטר בסהכ','19-4-2017','19:30','20:30',0,'בריכה',NULL,NULL)
GO


INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (4,'אימון כוח עם שאול','פלג גוף תחתון','21-4-2017','18:00','18:30',0,'חדר כושר','להביא מגבת קטנה',NULL)
GO

INSERT INTO EVENTS(		
	EventType,
	Title,
	E_Body,
	E_Date,
	StartTime,
	EndTime,
	IsRecursive,
	Location,
	Note,
	CreationTime
	)
VALUES (9,'טקטיקה במים','תרגול אחד יותר אחד פחות','21-4-2017','19:00','20:00',0,'בריכה',NULL,NULL)
GO

--------------------------------------------------
----------INSERT DATA USER TYPES------------------
--------------------------------------------------


INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(1,'ספורטאי')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(2,'מאמן')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(3,'מנהל מערכת')
GO

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
VALUES (3,'טל','כפתורי','0523488825','talkaf1@gmail.com','12345',NULL,'תמרת','14-04-1991')--SYS ADMIN
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
VALUES (3,'טל','אלדן','0505999470','taleldan188@gmail.com','12345',NULL,'רעננה','20-02-1991')--SYS ADMIN
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
VALUES (2,'עידן','כפתורי','0528539214','idankaftori@gmail.com','IDAN',NULL,'טבעון','12-02-1985')--COACH
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
VALUES (2,'ליאור','קליין','05059998744','lior.klain@gmail.com','A123456a',NULL,'קיבוץ רמת יוחנן','18-10-1981')--COACH
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
VALUES (2,'שאול','אלקנה','0505999925','shaul.el@gmail.com','A123456a',NULL,'אלוני אבא','19-12-1959')--COACH
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
VALUES (1,'גיא','כהן','0522549591','guycohen123@gmail.com','123',NULL,'טבעון','19-12-2004')--ATHLETE
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
VALUES (1,'איתמר','קנוף','0523553795','itamar1307@gmail.com','1307',NULL,'תמרת','10-02-2002')--ATHLETE
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
VALUES (1,'תום','קפלן','0586636591','tom.kaplan@gmail.com','591',NULL,'תמרת','15-02-2003')--ATHLETE
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
VALUES (1,'קורי','חשמונאי','0504082324','korihash@gmail.com','2324',NULL,'טבעון','24-09-2002')--ATHLETE
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
VALUES (1,'איתמר','קנוף','0523553795','itamar1307@gmail.com','1307',NULL,'תמרת','10-02-2002')--ATHLETE
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
VALUES (1,'גיא','בן חיון','0546239300','guybenayun@gmail.com','300',NULL,'רמת ישי','30-07-2005')--ATHLETE
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
VALUES (1,'בני','בונפלד','0542847590','bennyb@gmail.com','590',NULL,'טבעון','20-01-2004')--ATHLETE
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
VALUES (1,'ניר','חן','0523956352','nirhen@gmail.com','352',NULL,'טבעון','20-01-2002')--ATHLETE
GO

--------------------------------------------------
----------INSERT DATA COACH-----------------------
--------------------------------------------------


INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(3,'01-02-2014')
GO

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(4,'01-04-2012')
GO

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(5,'01-01-2001')
GO


--------------------------------------------------
----------INSERT DATA TEAMS-----------------------
--------------------------------------------------


INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('בנות 16',3)
GO
	
INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('בנים 16 א',4)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('בנים 18',4)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('בנות 18',3)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('בנים 16 ב',3)
GO

--------------------------------------------------
----------INSERT DATA ATHLETES--------------------
--------------------------------------------------

INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(6,5,1.62,70,205)
	GO

	INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(7,4,1.68,66,140)
	GO

	INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(8,3,1.78,82,168)
	GO

	INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(9,3,1.80,84,230)
	GO

	INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(10,2,1.63,60,190)
	GO

--------------------------------------------------
----------INSERT DATA RESULT TYPES----------------
--------------------------------------------------

INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(1, 'שחייה')
	GO

	INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(2, 'ריצה')
	GO
	
	INSERT INTO ResultTypes	(
	ResultType, Description)
	VALUES	(3, 'אחר')
	GO

--------------------------------------------------
----------INSERT DATA RESULTS---------------------
--------------------------------------------------

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (7,1,200,'00:02:33','18-04-2017',NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (7,1,200,'00:02:31','22-05-2017','סוף אימון')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (8,1,200,'00:02:47','22-05-2017','סוף אימון')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (9,1,200,'00:02:44','22-05-2017','סוף אימון')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,200,'00:02:39','22-05-2017','סוף אימון')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,200,'00:02:49','22-05-2017','סוף אימון')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (12,1,200,'00:02:53','22-05-2017','סוף אימון')
GO



--------------------------------------------------
---------------END OF INSERT DATA-----------------
--------------------------------------------------
