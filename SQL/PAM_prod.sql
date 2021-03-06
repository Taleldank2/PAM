USE bgroup57_prod
go

------------------------------------------------------------------------------
------------------------------CREATE DATA BASE--------------------------------
------------------------------------------------------------------------------
--CREATE DATABASE PAM_prod;
go

-------------------------------------------------------------------------
----------------------DROP&DELETE PAM DATA BASE--------------------------
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

--DROP TABLES
/*
drop table Athletes
drop table Events
drop table EventRates
drop table Games
drop table Messages
drop table Results
drop table Attendances
drop table TeamsEvents
drop table TeamsMessages

drop table Coaches
drop table Users
drop table Teams

drop table EventTypes
drop table ResultTypes
drop table UserTypes
GO
*/

/*
RESET ALL IDENTITY ID'S

DBCC CHECKIDENT ('[Events]', RESEED, 0);
DBCC CHECKIDENT ('[Users]', RESEED, 0);
DBCC CHECKIDENT ('[Teams]', RESEED, 0);
DBCC CHECKIDENT ('[Messages]', RESEED, 0);
DBCC CHECKIDENT ('[Results]', RESEED, 0);
GO
*/


--DROP DATA FROM TABLES
/*
DELETE FROM Attendances
DELETE FROM UserTypes
DELETE FROM EventRates
DELETE FROM Games
DELETE FROM Messages
DELETE FROM Results
DELETE FROM ResultTypes
DELETE FROM Athletes
DELETE FROM Coaches
DELETE FROM Teams
DELETE FROM Users
DELETE FROM Events
DELETE FROM EventTypes
DELETE FROM TeamsEvents
DELETE FROM TeamsMessages
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
	CONSTRAINT PK_COACHES1 PRIMARY KEY (UserID, RegID)	
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


--------------------------------------------------
----------INSERT DATA COACH-----------------------
--------------------------------------------------

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(3,CONVERT(date,'01-02-2014',105))
GO

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(4,CONVERT(date,'01-04-2012',105))
GO

INSERT INTO COACHES(
CoachID,
StartDate)
VALUES(5,CONVERT(date,'01-01-2001',105))
GO

--------------------------------------------------
----------INSERT DATA TEAMS-----------------------
--------------------------------------------------

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('��� 16',3)
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
VALUES ('����� 15',3)
GO

INSERT INTO TEAMS(	
	TeamName,
	HeadCoachID
	)
VALUES ('������',3)
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
	VALUES	(10,3,1.63,60,190)
	GO

INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(11,3,1.67,96,180)
	GO

INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(12,2,1.53,65,300)
	GO

INSERT INTO ATHLETES	(
	AthleteID, TeamId, Highet, Weight, AppScore)
	VALUES	(13,2,1.83,80,134)
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
VALUES (1,'����� ����','����� ���� ������ ������� �����',CONVERT(date,'12-4-2018',105),'18:00','19:30',1,'�����','����� 10 ���� ���� ����� ������ ������ ����� ���',NULL)
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
VALUES (1,'���� ���� ����','����� ���� ���� ����� �����',CONVERT(date,'14-4-2018',105),'18:00','19:00',0,'�����','�� ����!',NULL)
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
VALUES (1,'����� ��� ��� ����� (����)','����� �� ���� ��� ���',CONVERT(date,'19-4-2018',105),'18:00','19:00',1,'�����','����� ���� ����� ����� ��� ����� ���!',NULL)
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
VALUES (2,'���� ��� ��"� ��-����','��� ��� ����',CONVERT(date,'16-4-2018',105),'19:00','20:00',0,'��"� ��-����','���� ��� �����',NULL)
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
VALUES (3,'���� ���� ���� �����',NULL,CONVERT(date,'15-4-2018',105),'20:00','21:00',0,'��� ��������','����� ���� �����',NULL)
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
VALUES (3,'����� ����� �������!',NULL,CONVERT(date,'28-4-2018',105),'19:00','21:00',0,'���� ��"� 20','����� ����� ;)',NULL)
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
VALUES (1,'����� ���� �� ����',NULL,CONVERT(date,'19-4-2018',105),'18:30','19:15',1,'�����','����� ����',NULL)
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
VALUES (1,'����� �����','3 ������ ����',CONVERT(date,'19-4-2018',105),'19:30','20:30',1,'�����',NULL,NULL)
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
VALUES (1,'����� ��� �� ����','��� ��� �����',CONVERT(date,'21-4-2018',105),'18:00','18:30',1,'��� ����','����� ���� ����',NULL)
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
VALUES (1,'������ ����','����� ��� ���� ��� ����',CONVERT(date,'21-4-2018',105),'19:00','20:00',0,'�����',NULL,NULL)
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
VALUES (2,'������ �����','������� �����',CONVERT(date,'28-4-2018',105),'09:00','14:30',0,'�����','���� �� ������ �����',NULL)
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
VALUES (1,'����� ����','����� ��� ��� ����� ����',CONVERT(date,'21-5-2018',105),'18:00','19:00',0,'�����','����� ���� ������ �����',NULL)
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
VALUES (1,'����� ����','����� ����� ���� ���� ����/����',CONVERT(date,'23-5-2018',105),'18:00','19:00',0,'�����','����� ���� ������ �����',NULL)
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
VALUES (1,'����� ����','����� ����',CONVERT(date,'20-5-2018',105),'06:30','07:30',0,'�����','',NULL)
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
VALUES (1,'����� ����','���� ����',CONVERT(date,'23-5-2018',105),'17:00','18:00',0,'���� �����','���� �����',NULL)
GO


--sunday event16 age 16
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
VALUES (1,'����� ����','���� ����',CONVERT(date,'30-7-2018',105),'08:00','11:00',0,'���� �����','���� �����',NULL)
GO

--sunday event17 age 15 and adult
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
VALUES (1,'����� �����','���� ������',CONVERT(date,'30-7-2018',105),'18:00','21:00',0,'�����','����� ���',NULL)
GO

--sunday event18 age 15
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
VALUES (1,'�������','����� �����',CONVERT(date,'31-7-2018',105),'13:00','15:00',0,'�����','�� ����',NULL)
GO

--sunday event19 age 14 
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
VALUES (1,'�������','����� �����',CONVERT(date,'31-7-2018',105),'17:00','19:30',0,'�����','�� ����',NULL)
GO

--sunday event20 age 16
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
VALUES (1,'�������','����� �����',CONVERT(date,'31-7-2018',105),'18:00','21:00',0,'�����','�� ����',NULL)
GO


--sunday event21 age 15
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
VALUES (1,'���� �����','��� ���',CONVERT(date,'01-8-2018',105),'16:45:00','19:30',0,'��� ����','���� ����',NULL)
GO

--sunday event22 age 16
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
VALUES (1,'���� �����','��� ���',CONVERT(date,'01-8-2018',105),'18:00:00','21:00',0,'��� ����','���� ����',NULL)
GO


--sunday event23 age 14
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
VALUES (1,'���','������� ������ ���',CONVERT(date,'02-8-2018',105),'18:00:00','21:00',0,'�����','����� ����',NULL)
GO

--sunday event24 age adult
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
VALUES (1,'���','������� ������ ���',CONVERT(date,'02-8-2018',105),'19:45:00','22:15',0,'�����','����� ����',NULL)
GO

--sunday event25 age adult
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'03-8-2018',105),'12:30:00','15:00',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event26 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'03-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO


--sunday event27 age 16
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'03-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

----------------------------------
--sunday event16 age 16
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
VALUES (1,'����� ����','���� ����',CONVERT(date,'5-8-2018',105),'08:00','11:00',0,'���� �����','���� �����',NULL)
GO

--sunday event17 age 15 and adult
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
VALUES (1,'����� �����','���� ������',CONVERT(date,'5-8-2018',105),'18:00','21:00',0,'�����','����� ���',NULL)
GO

--sunday event18 age 15
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
VALUES (1,'�������','����� �����',CONVERT(date,'6-8-2018',105),'13:00','15:00',0,'�����','�� ����',NULL)
GO

--sunday event19 age 14 
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
VALUES (1,'�������','����� �����',CONVERT(date,'6-8-2018',105),'17:00','19:30',0,'�����','�� ����',NULL)
GO

--sunday event20 age 16
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
VALUES (1,'�������','����� �����',CONVERT(date,'6-8-2018',105),'18:00','21:00',0,'�����','�� ����',NULL)
GO


--sunday event21 age 15
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
VALUES (1,'���� �����','��� ���',CONVERT(date,'7-8-2018',105),'16:45:00','19:30',0,'��� ����','���� ����',NULL)
GO

--sunday event22 age 16
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
VALUES (1,'���� �����','��� ���',CONVERT(date,'7-8-2018',105),'18:00:00','21:00',0,'��� ����','���� ����',NULL)
GO

--sunday event23 age 14
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
VALUES (1,'���','������� ������ ���',CONVERT(date,'8-8-2018',105),'18:00:00','21:00',0,'�����','����� ����',NULL)
GO

--sunday event24 age adult
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
VALUES (1,'���','������� ������ ���',CONVERT(date,'02-8-2018',105),'19:45:00','22:15',0,'�����','����� ����',NULL)
GO

--sunday event25 age adult
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'09-8-2018',105),'12:30:00','15:00',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event26 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'09-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO


--sunday event27 age 16
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'09-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

----------------------------------
--sunday event40 age 16
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
VALUES (2,'����� ����','���� ����',CONVERT(date,'12-8-2018',105),'08:00','11:00',0,'���� �����','���� �����',NULL)
GO

--sunday event17 age 15 and adult
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
VALUES (2,'����� �����','���� ������',CONVERT(date,'12-8-2018',105),'18:00','21:00',0,'�����','����� ���',NULL)
GO

--sunday event18 age 15
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
VALUES (1,'�������','����� �����',CONVERT(date,'13-8-2018',105),'13:00','15:00',0,'�����','�� ����',NULL)
GO

--sunday event19 age 14 
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
VALUES (1,'�������','����� �����',CONVERT(date,'13-8-2018',105),'17:00','19:30',0,'�����','�� ����',NULL)
GO

--sunday event20 age 16
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
VALUES (1,'�������','����� �����',CONVERT(date,'13-8-2018',105),'18:00','21:00',0,'�����','�� ����',NULL)
GO


--sunday event21 age 15
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
VALUES (3,'���� �����','��� ���',CONVERT(date,'14-8-2018',105),'16:45:00','19:30',0,'��� ����','���� ����',NULL)
GO

--sunday event22 age 16
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
VALUES (2,'���� �����','��� ���',CONVERT(date,'14-8-2018',105),'18:00:00','21:00',0,'��� ����','���� ����',NULL)
GO

--sunday event23 age 14
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
VALUES (3,'���','������� ������ ���',CONVERT(date,'15-8-2018',105),'18:00:00','21:00',0,'�����','����� ����',NULL)
GO

--sunday event24 age adult
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
VALUES (3,'���','������� ������ ���',CONVERT(date,'15-8-2018',105),'19:45:00','22:15',0,'�����','����� ����',NULL)
GO

--sunday event25 age adult
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'16-8-2018',105),'12:30:00','15:00',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event26 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'16-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO


--sunday event27 age 16
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'16-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event52 age 14 
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
VALUES (1,'�������','����� �����',CONVERT(date,'19-8-2018',105),'17:00','19:30',0,'�����','�� ����',NULL)
GO

--sunday event53 age 14
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
VALUES (3,'���','������� ������ ���',CONVERT(date,'21-8-2018',105),'18:00:00','21:00',0,'�����','����� ����',NULL)
GO

--sunday event54 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'23-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event55 age 14 
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
VALUES (2,'����','���� 5',CONVERT(date,'19-8-2018',105),'17:00','19:30',0,'���� ������','�� ����',NULL)
GO

--sunday event56 age 14 
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
VALUES (2,'����','���� 5',CONVERT(date,'26-8-2018',105),'17:00','19:30',0,'���� ������','�� ����',NULL)
GO

--sunday event57 age 14
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
VALUES (3,'���','������� ������ ���',CONVERT(date,'28-8-2018',105),'18:00:00','21:00',0,'�����','����� ����',NULL)
GO

--sunday event58 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'30-8-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event59 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'29-7-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO

--sunday event60 age 14
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
VALUES (1,'�����','����� 5 �� ����',CONVERT(date,'26-7-2018',105),'16:45:00','19:30',0,'�����','����� ����� ��� ����',NULL)
GO
--sunday event61 age 14
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
VALUES (1,'�����','������',CONVERT(date,'23-7-2018',105),'16:45:00','19:30',0,'�����','',NULL)
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
VALUES (7,1,200,'00:02:33',CONVERT(date,'18-04-2017',105),NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (7,1,200,'00:02:31',CONVERT(date,'22-05-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (8,1,200,'00:02:47',CONVERT(date,'22-05-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (9,1,200,'00:02:44',CONVERT(date,'22-05-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,200,'00:02:39',CONVERT(date,'22-05-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,200,'00:02:30',CONVERT(date,'18-08-2017',105),NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,400,'00:05:16',CONVERT(date,'13-10-2017',105),NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,2,2000,'00:07:55',CONVERT(date,'10-11-2017',105),NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (10,1,200,'00:02:25',CONVERT(date,'05-11-2017',105),NULL)
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,200,'00:02:49',CONVERT(date,'22-05-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,200,'00:02:41',CONVERT(date,'02-07-2017',105),'��� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,200,'00:02:37',CONVERT(date,'15-11-2017',105),'�����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,1,400,'00:05:30',CONVERT(date,'15-11-2017',105),'�����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,2,2000,'00:07:37',CONVERT(date,'05-11-2017',105),'�����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (11,2,1000,'00:03:50',CONVERT(date,'15-11-2017',105),'��� ����� �����')
GO

INSERT INTO RESULTS(
	AthleteID,
	ResultType,
	Distance,
	rTime,
	rDate,
	Note
	)
VALUES (12,1,200,'00:02:53',CONVERT(date,'22-05-2017',105),'��� �����')
GO

--------------------------------------------------
-------------INSERT DATA MESSAGES-----------------
--------------------------------------------------
INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '����� �����!', '������ ���� ����, ����� ������ ���',CONVERT (date ,'13-04-2017',105),'13:45:00')
	GO

INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(4, '��� ����� ����', '����� ���� ����� ���� ���� ���� 20:00',CONVERT (date ,'11-05-2017',105),'13:45:00')
	GO

INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '���� �����!', '����� ���� ����� ������ ���� ��� ����',CONVERT (date ,'16-04-2017',105),'16:45:00')
	GO

INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(5, '���� ������', '����� ����� ����� �����',CONVERT (date ,'13-04-2017',105),'13:23:00')
	GO

INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(4, '���� ������ ������', '����� ��� ��� ���� ����� �� ��� ���� ����',CONVERT (date ,'22-03-2017',105),'16:00:00')
	GO

	INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '����� 20 �� �����', '����� ������',CONVERT (date ,'22-07-2018',105),'16:00:00')
	GO

INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '����� ������', '���� ����� �����',CONVERT (date ,'29-07-2017',105),'20:00:00')
	GO

	INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '�� ��� �� ���� �� ������', '������ �� ����',CONVERT (date ,'19-07-2017',105),'20:00:00')
	GO

		INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(3, '����� �����', '�������� - ����, �� ����� ����� �����',CONVERT (date ,'05-07-2018',105),'20:00:00')
	GO

	
		INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(4, '��� ���� �����', '�� ����� ������',CONVERT (date ,'16-07-2018',105),'20:00:00')
	GO


		INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(4, '���� ������� ������', '��� ������� ���� 17:00',CONVERT (date ,'11-07-2018',105),'20:00:00')
	GO


		INSERT INTO dbo.Messages	(
	CreatorId, Title, mBody, mDate, mTime)
	VALUES	(4, '�� ����� ������', '��� �� ��� ���� !',CONVERT (date ,'29-07-2018',105),'20:00:00')
	GO



--------------------------------------------------
-------------INSERT DATA GAMES--------------------
--------------------------------------------------

INSERT INTO Games	(
	GameId, GoTransportTime, BackTransportTime, TransportLocation, OpponentName,OpponentGoals,TivonScore,IsHome)
	VALUES	(4, '16:30:00', '21:45:00','����� ���� ����','��"� �� -����',6,3,0)
	GO

	--------------------------------------------------
-------------INSERT DATA ATTENDANCE---------------
--------------------------------------------------

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 6, 1,'')
	GO

	INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 7, 0,'����')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 8, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 9, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 10, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(1, 11, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(2, 6, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(2, 7, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(2, 8, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(2, 9, 1,'')
	GO

INSERT INTO Attendances	(
	EventId, AthleteId,IsAttend, Note)
	VALUES	(2, 10, 0,'�����')
	GO

	
--------------------------------------------------
------------END OF REGULAR TABLES-----------------
--------------------------------------------------


--------------------------------------------------
----------INSERT DATA CONNECTION TABLES-----------
--------------------------------------------------

--------------------------------------------------
----------INSERT DATA EVENTS RATES----------------
--------------------------------------------------
--we dont usr this table!!

--INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 6, 6)
--	GO

--INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 7, 8)
--	GO

--INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 8, 5)
--	GO

--INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 9, 2)
--	GO
--	INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 10, 9)
--	GO
--	INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 11, 8)
--	GO
--	INSERT INTO EventRates	(
--	EventId, AthleteId,Rate)
--	VALUES	(4, 12, 7)
--	GO

--------------------------------------------------
----------INSERT DATA TEAM EVENTS-----------------
--------------------------------------------------

INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(1, 1)
	GO

INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(4, 1)
	GO


INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(11, 4)
	GO


INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(2, 2)
	GO

	--my new connection 1

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(16, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(17, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(17, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(18, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(19, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(20, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(21, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(21, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(22, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(23, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(24, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(25, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(26, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(27, 1)
	GO

		--my new connection 2

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(28, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(29, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(29, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(30, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(31, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(32, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(33, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(33, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(34, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(35, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(36, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(37, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(38, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(39, 1)
	GO

		--my new connection 3

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(40, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(41, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(41, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(42, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(43, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(44, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(45, 4)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(46, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(47, 1)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(48, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(49, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(50, 5)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(51, 3)
	GO

	INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(51, 1)
	GO

		INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(46, 3)
	GO

		INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(52, 3)
	GO

			INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(53, 3)
	GO

			INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(54, 3)
	GO

				INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(55, 3)
	GO

				INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(56, 3)
	GO
				INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(57, 3)
	GO

				INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(58, 3)
	GO

					INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(59, 3)
	GO

					INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(60, 3)
	GO

						INSERT INTO TeamsEvents	(
	EventId, TeamId)
	VALUES	(61, 3)
	GO

--------------------------------------------------
----------INSERT DATA TEAM MESSAGES---------------
--------------------------------------------------

INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(1, 1)
	GO

INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(1, 2)
	GO

INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(2, 4)
	GO

INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(2, 2)
	GO

	INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(1, 3)
	GO

		INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(2, 3)
	GO

			INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(6, 3)
	GO

			INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(7, 3)
	GO

			INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(8, 3)
	GO

			INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(9, 3)
	GO

				INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(10, 3)
	GO

				INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(11, 3)
	GO

				INSERT INTO TeamsMessages	(
	MessageId, TeamId)
	VALUES	(12, 3)
	GO
--------------------------------------------------
---------------END OF CONNECTION TABLES-----------
--------------------------------------------------

--------------------------------------------------
---------------END OF INSERT DATA-----------------
--------------------------------------------------

