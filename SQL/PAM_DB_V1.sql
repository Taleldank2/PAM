CREATE TABLE [Events] (
	EventID integer NOT NULL,
	TeamID integer NOT NULL,
	EventType integer NOT NULL,
	Title text NOT NULL,
	Body text NOT NULL,
	Date date NOT NULL,
	StartTime time NOT NULL,
	EndTime time NOT NULL,
	IsRecursive boolean NOT NULL,
	Location text NOT NULL,
	Note text NOT NULL,
	CreationTime timestamp NOT NULL,
  CONSTRAINT [PK_EVENTS] PRIMARY KEY CLUSTERED
  (
  [EventID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Attendances] (
	AttendanceID integer NOT NULL,
	AthleteID integer NOT NULL,
	IsAttend boolean NOT NULL,
	Note text NOT NULL,
  CONSTRAINT [PK_ATTENDANCES] PRIMARY KEY CLUSTERED
  (
  [AttendanceID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Athletes] (
	AthleteID integer NOT NULL,
	TeamID integer NOT NULL,
	Highet float NOT NULL,
	Weight float NOT NULL,
	AppScore integer NOT NULL,
  CONSTRAINT [PK_ATHLETES] PRIMARY KEY CLUSTERED
  (
  [AthleteID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Users] (
	UserID integer NOT NULL,
	UserType integer NOT NULL,
	FirstName varchar NOT NULL,
	LastName varchar NOT NULL,
	PhoneNumber varchar NOT NULL,
	Email varchar NOT NULL,
	Password varchar NOT NULL,
	Picture varchar NOT NULL,
	City varchar NOT NULL,
	BirthDate date NOT NULL,
  CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED
  (
  [UserID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Coaches] (
	CoachID integer NOT NULL,
	StartDate date NOT NULL,
  CONSTRAINT [PK_COACHES] PRIMARY KEY CLUSTERED
  (
  [CoachID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Teams] (
	TeamID integer NOT NULL,
	TeamName varchar NOT NULL,
	HeadCoachID integer NOT NULL,
  CONSTRAINT [PK_TEAMS] PRIMARY KEY CLUSTERED
  (
  [TeamID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Messages] (
	MessageID integer NOT NULL,
	TeamID integer NOT NULL,
	CreatorID integer NOT NULL,
	Title varchar NOT NULL,
	Body varchar NOT NULL,
	Date date NOT NULL,
	Time timestamp NOT NULL,
  CONSTRAINT [PK_MESSAGES] PRIMARY KEY CLUSTERED
  (
  [MessageID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Results] (
	ResultID integer NOT NULL,
	AthleteID integer NOT NULL,
	ResultType integer NOT NULL,
	Distance float NOT NULL,
	Time time NOT NULL,
	Date date NOT NULL,
	Note varchar NOT NULL,
  CONSTRAINT [PK_RESULTS] PRIMARY KEY CLUSTERED
  (
  [ResultID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Games] (
	Game_id integer NOT NULL,
	GoTransportTime time NOT NULL,
	BackTransportTime time NOT NULL,
	TransportLocation varchar NOT NULL,
	OpponentName varchar NOT NULL,
	OpponentGoals integer NOT NULL,
	TivonScore integer NOT NULL,
	IsHome boolean NOT NULL,
  CONSTRAINT [PK_GAMES] PRIMARY KEY CLUSTERED
  (
  [Game_id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [UserTypes] (
	UserType integer NOT NULL,
	Description string NOT NULL,
  CONSTRAINT [PK_USERTYPES] PRIMARY KEY CLUSTERED
  (
  [UserType] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [ResultTypes] (
	ResultType integer NOT NULL,
	Description string NOT NULL,
  CONSTRAINT [PK_RESULTTYPES] PRIMARY KEY CLUSTERED
  (
  [ResultType] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [EventTypes] (
	EventType integer NOT NULL,
	Description string NOT NULL,
  CONSTRAINT [PK_EVENTTYPES] PRIMARY KEY CLUSTERED
  (
  [EventType] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [EventRates] (
	EventID integer NOT NULL,
	AthleteID integer NOT NULL,
	Rate integer NOT NULL,
  CONSTRAINT [PK_EVENTRATES] PRIMARY KEY CLUSTERED
  (
  [EventID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [Events] WITH CHECK ADD CONSTRAINT [Events_fk0] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
ON UPDATE CASCADE
GO
ALTER TABLE [Events] CHECK CONSTRAINT [Events_fk0]
GO
ALTER TABLE [Events] WITH CHECK ADD CONSTRAINT [Events_fk1] FOREIGN KEY ([EventType]) REFERENCES [EventTypes]([EventType])
ON UPDATE CASCADE
GO
ALTER TABLE [Events] CHECK CONSTRAINT [Events_fk1]
GO

ALTER TABLE [Attendances] WITH CHECK ADD CONSTRAINT [Attendances_fk0] FOREIGN KEY ([AttendanceID]) REFERENCES [Events]([EventID])
ON UPDATE CASCADE
GO
ALTER TABLE [Attendances] CHECK CONSTRAINT [Attendances_fk0]
GO
ALTER TABLE [Attendances] WITH CHECK ADD CONSTRAINT [Attendances_fk1] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
ON UPDATE CASCADE
GO
ALTER TABLE [Attendances] CHECK CONSTRAINT [Attendances_fk1]
GO

ALTER TABLE [Athletes] WITH CHECK ADD CONSTRAINT [Athletes_fk0] FOREIGN KEY ([AthleteID]) REFERENCES [Users]([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [Athletes] CHECK CONSTRAINT [Athletes_fk0]
GO
ALTER TABLE [Athletes] WITH CHECK ADD CONSTRAINT [Athletes_fk1] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
ON UPDATE CASCADE
GO
ALTER TABLE [Athletes] CHECK CONSTRAINT [Athletes_fk1]
GO

ALTER TABLE [Users] WITH CHECK ADD CONSTRAINT [Users_fk0] FOREIGN KEY ([UserType]) REFERENCES [UserTypes]([UserType])
ON UPDATE CASCADE
GO
ALTER TABLE [Users] CHECK CONSTRAINT [Users_fk0]
GO

ALTER TABLE [Coaches] WITH CHECK ADD CONSTRAINT [Coaches_fk0] FOREIGN KEY ([CoachID]) REFERENCES [Users]([UserID])
ON UPDATE CASCADE
GO
ALTER TABLE [Coaches] CHECK CONSTRAINT [Coaches_fk0]
GO

ALTER TABLE [Teams] WITH CHECK ADD CONSTRAINT [Teams_fk0] FOREIGN KEY ([HeadCoachID]) REFERENCES [Coaches]([CoachID])
ON UPDATE CASCADE
GO
ALTER TABLE [Teams] CHECK CONSTRAINT [Teams_fk0]
GO

ALTER TABLE [Messages] WITH CHECK ADD CONSTRAINT [Messages_fk0] FOREIGN KEY ([TeamID]) REFERENCES [Teams]([TeamID])
ON UPDATE CASCADE
GO
ALTER TABLE [Messages] CHECK CONSTRAINT [Messages_fk0]
GO
ALTER TABLE [Messages] WITH CHECK ADD CONSTRAINT [Messages_fk1] FOREIGN KEY ([CreatorID]) REFERENCES [Coaches]([CoachID])
ON UPDATE CASCADE
GO
ALTER TABLE [Messages] CHECK CONSTRAINT [Messages_fk1]
GO

ALTER TABLE [Results] WITH CHECK ADD CONSTRAINT [Results_fk0] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
ON UPDATE CASCADE
GO
ALTER TABLE [Results] CHECK CONSTRAINT [Results_fk0]
GO
ALTER TABLE [Results] WITH CHECK ADD CONSTRAINT [Results_fk1] FOREIGN KEY ([ResultType]) REFERENCES [ResultTypes]([ResultType])
ON UPDATE CASCADE
GO
ALTER TABLE [Results] CHECK CONSTRAINT [Results_fk1]
GO

ALTER TABLE [Games] WITH CHECK ADD CONSTRAINT [Games_fk0] FOREIGN KEY ([Game_id]) REFERENCES [Events]([EventID])
ON UPDATE CASCADE
GO
ALTER TABLE [Games] CHECK CONSTRAINT [Games_fk0]
GO




ALTER TABLE [EventRates] WITH CHECK ADD CONSTRAINT [EventRates_fk0] FOREIGN KEY ([EventID]) REFERENCES [Events]([EventID])
ON UPDATE CASCADE
GO
ALTER TABLE [EventRates] CHECK CONSTRAINT [EventRates_fk0]
GO
ALTER TABLE [EventRates] WITH CHECK ADD CONSTRAINT [EventRates_fk1] FOREIGN KEY ([AthleteID]) REFERENCES [Athletes]([AthleteID])
ON UPDATE CASCADE
GO
ALTER TABLE [EventRates] CHECK CONSTRAINT [EventRates_fk1]
GO

