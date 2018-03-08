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

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(1,'PRACTICE')
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
VALUES (1,'BIG PRACTICE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
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
VALUES (1,'SMALL PRACTICE',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
GO


INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(1,'SYSTEM ADMIN')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(2,'COACH')
GO

INSERT INTO UserTypes (
	UserType,
	Description
	)
VALUES(3,'ATHLETE')
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
VALUES (1,'TAL','KAFTORI','0523488825','KAFTIKAFT1@GMAL.COM','A123456a',NULL,NULL,NULL)--SYS ADMIN
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
VALUES (1,'TAL','ELDAN','0505999470','BRAP@GMAIL.COM','A123456a',NULL,NULL,NULL)--SYS ADMIN
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
VALUES (2,'JESSY','KLIP','050-59998744','BRAP@GMAIL.COM','A123456a',NULL,NULL,NULL)--ATHLETE
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
VALUES (3,'FALKA','WAYWAY','050-59998744','BRAP@GMAIL.COM','A123456a',NULL,NULL,NULL)--COACH
GO

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(6,NULL)
	
	
INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('GIRLS 16',6)
GO
	
INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('BOYS 16',6)
GO

INSERT INTO RESULTS(

	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (7,1,200,'00:01:03',NULL,NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (7,2,200,'00:04:03',NULL,NULL)
GO

