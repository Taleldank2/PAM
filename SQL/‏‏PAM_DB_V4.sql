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
VALUES(1,'����� ����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(2,'����� ����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(3,'����� �����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(4,'����� ���')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(5,'����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(6,'����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(7,'����� �����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(8,'�����')
GO

INSERT INTO EventTypes(
	EventType,
	Description
	)
VALUES(9,'���')
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
VALUES (1,'����� ����','����� ���� ������ ������� �����','12-4-2017','18:00','19:30',0,'�����','����� 10 ���� ���� ����� ������ ������ ����� ���',NULL)
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
VALUES (1,'���� ���� ����','����� ���� ���� ����� �����','14-4-2017','18:00','19:00',1,'�����','�� ����!',NULL)
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
VALUES (1,'��� �� ����� ��� ���','����� �� ���� ��� ���','19-4-2017','18:00','19:00',0,'�����','����� ���� ����� ����� ��� ����� ���!',NULL)
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
VALUES (5,'���� ��� ��"� ��-����','��� ��� ����','16-4-2017','19:00','20:00',1,'��"� ��-����','���� ��� �����',NULL)
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
VALUES (6,'���� ���� ���� �����',NULL,'15-4-2017','20:00','21:00',1,'��� ��������','����� ���� �����',NULL)
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
VALUES (8,'����� ����� �������!',NULL,'28-4-2017','19:00','21:00',1,'���� ��"� 20','����� ����� ;)',NULL)
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
VALUES (2,'����� ���� �� ����',NULL,'19-4-2017','18:30','19:15',0,'�����','����� ����',NULL)
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
VALUES (3,'����� �����','3 ������ ����','19-4-2017','19:30','20:30',0,'�����',NULL,NULL)
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
VALUES (4,'����� ��� �� ����','��� ��� �����','21-4-2017','18:00','18:30',0,'��� ����','����� ���� ����',NULL)
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
VALUES (9,'������ ����','����� ��� ���� ��� ����','21-4-2017','19:00','20:00',0,'�����',NULL,NULL)
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
VALUES (3,'��','������','0523488825','talkaf1@gmail.com','12345',NULL,'����','14-04-1991')--SYS ADMIN
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
VALUES (3,'��','����','0505999470','taleldan188@gmail.com','12345',NULL,'�����','20-02-1991')--SYS ADMIN
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
VALUES (2,'����','������','0528539214','idankaftori@gmail.com','IDAN',NULL,'�����','12-02-1985')--COACH
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
VALUES (2,'�����','�����','05059998744','lior.klain@gmail.com','A123456a',NULL,'����� ��� �����','18-10-1981')--COACH
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
VALUES (2,'����','�����','0505999925','shaul.el@gmail.com','A123456a',NULL,'����� ���','19-12-1959')--COACH
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
VALUES (1,'���','���','0522549591','guycohen123@gmail.com','123',NULL,'�����','19-12-2004')--ATHLETE
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
VALUES (1,'�����','����','0523553795','itamar1307@gmail.com','1307',NULL,'����','10-02-2002')--ATHLETE
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
VALUES (1,'���','����','0586636591','tom.kaplan@gmail.com','591',NULL,'����','15-02-2003')--ATHLETE
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
VALUES (1,'����','�������','0504082324','korihash@gmail.com','2324',NULL,'�����','24-09-2002')--ATHLETE
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
VALUES (1,'�����','����','0523553795','itamar1307@gmail.com','1307',NULL,'����','10-02-2002')--ATHLETE
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
VALUES (1,'���','�� ����','0546239300','guybenayun@gmail.com','300',NULL,'��� ���','30-07-2005')--ATHLETE
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
VALUES (1,'���','������','0542847590','bennyb@gmail.com','590',NULL,'�����','20-01-2004')--ATHLETE
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
VALUES (1,'���','��','0523956352','nirhen@gmail.com','352',NULL,'�����','20-01-2002')--ATHLETE
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
VALUES ('���� 16',3)
GO
	
INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('���� 16 �',4)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('���� 18',4)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('���� 18',3)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('���� 16 �',3)
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
VALUES (7,1,200,'00:02:31','22-05-2017','��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (8,1,200,'00:02:47','22-05-2017','��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (9,1,200,'00:02:44','22-05-2017','��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,200,'00:02:39','22-05-2017','��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,200,'00:02:49','22-05-2017','��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (12,1,200,'00:02:53','22-05-2017','��� �����')
GO



--------------------------------------------------
---------------END OF INSERT DATA-----------------
--------------------------------------------------
