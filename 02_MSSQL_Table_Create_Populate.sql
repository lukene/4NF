USE [4_Normal_Form]
GO


CREATE TABLE [dbo].[rawdata]
	(
	[rawdata_ID]						[bigint]		IDENTITY(1,1) NOT FOR REPLICATION	NOT NULL,
	[rawdata_Year]						[int]			NULL,
	[rawdata_Series]					[nvarchar](3)	NULL,
	[rawdata_Country_Name]				[nvarchar](30)	NULL,
	[rawdata_State_Province_Name]		[nvarchar](30)	NULL,
	[rawdata_City_Name]					[nvarchar](30)	NULL,
	[rawdata_Team_Name]					[nvarchar](80)	NULL,
	[rawdata_Team_Info]					[nvarchar](200)	NULL,
	[rawdata_Jersey_Name]				[nvarchar](30)	NULL,
	[rawdata_Jersey_Number]				[nvarchar](30)	NULL,
	[rawdata_Player_Name]				[nvarchar](100)	NULL,
	[rawdata_Player_Position]			[nvarchar](100)	NULL,
	[rawdata_Comments]					[nvarchar](300)	NULL,
	[rawdata_deleted]					[nvarchar](1)	NOT NULL,
	[rawdata_DateCreate]				[datetime]		NOT NULL,
	[rawdata_DateModify]				[datetime]		NOT NULL,
	CONSTRAINT [PK_rawdata_rawdata_ID] PRIMARY KEY NONCLUSTERED 
		(
		[rawdata_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

ALTER TABLE [dbo].[rawdata] ADD  CONSTRAINT [Def_rawdata_rawdata_deleted]  DEFAULT ('N') FOR [rawdata_deleted]
GO

ALTER TABLE [dbo].[rawdata] ADD  CONSTRAINT [DF_rawdata_DateCreate]  DEFAULT (GETDATE()) FOR [rawdata_DateCreate]
GO
ALTER TABLE [dbo].[rawdata] ADD  CONSTRAINT [DF_rawdata_DateModify]  DEFAULT (GETDATE()) FOR [rawdata_DateModify]
GO
CREATE TRIGGER trg_LastMod_rawdata ON [dbo].[rawdata] AFTER UPDATE AS
       UPDATE [dbo].[rawdata] SET rawdata_DateModify = GETDATE() WHERE rawdata_ID IN (SELECT DISTINCT rawdata_ID FROM INSERTED);
GO




USE [4_Normal_Form]
GO

INSERT INTO [dbo].[rawdata]	(rawdata_Year,rawdata_Series,rawdata_Country_Name,rawdata_State_Province_Name,rawdata_City_Name,rawdata_Team_Name,rawdata_Team_Info,rawdata_Jersey_Name,rawdata_Jersey_Number,rawdata_Player_Name,rawdata_Player_Position,rawdata_Comments)
VALUES
		 (1987	,'4-2'		,'USA'		,'California'			,'Los Angeles'		,'Lakers'					,'https://www.nba.com/lakers/;Total Championships 17'			,'Green'		,'45'				,'A.C. Green'			,'Power Forward'					,NULL						)
		,(1988	,'4-3'		,'USA'		,'California'			,'Los Angeles'		,'Lakers'					,'https://www.nba.com/lakers/;Total Championships 17'			,'Green'		,'45'				,'A.C. Green'			,'Power Forward'					,NULL						)
		,(1991	,'4-1'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'12 one time 1990-02-14'	)
		,(1992	,'4-2'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'12 one time 1990-02-14'	)
		,(1993	,'4-2'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'12 one time 1990-02-14'	)
		,(1996	,'4-2'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'45-55%;23-45%'			)
		,(1997	,'4-2'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'12 one time 1990-02-14'	)
		,(1998	,'4-2'		,'USA'		,'Illinois'				,'Chicago'			,'Bulls'					,'https://www.nba.com/bulls/;Total Championships 6'				,'Jordan'		,'23,12,45'			,'Michael Jordan'		,'Shooting Guard'					,'12 one time 1990-02-14'	)
		,(2000	,'4-2'		,'USA'		,'California'			,'Los Angeles'		,'Lakers'					,'https://www.nba.com/lakers/;Total Championships 17'			,'Green'		,'45'				,'A.C. Green'			,'Power Forward'					,NULL						)
		,(2003	,'4-2'		,'USA'		,'Texas'				,'San Antonio'		,'Spurs'					,'https://www.nba.com/spurs/;Total Championships 5'				,'Parker'		,'9'				,'Tony Parker'			,'Point Guard'						,NULL						)
		,(2012	,'4-1'		,'USA'		,'Florida'				,'Miami'			,'Heat'						,'https://www.nba.com/heat/;Total Championships 3'				,'James'		,'23'				,'Lebron James'			,'Small Forward;Power Forward'		,NULL						)
		,(2013	,'4-3'		,'USA'		,'Florida'				,'Miami'			,'Heat'						,'https://www.nba.com/heat/;Total Championships 3'				,'James'		,'23'				,'Lebron James'			,'Small Forward;Power Forward'		,NULL						)
		,(2014	,'4-1'		,'USA'		,'Texas'				,'San Antonio'		,'Spurs'					,'https://www.nba.com/spurs/;Total Championships 5'				,'Parker'		,'9'				,'Tony Parker'			,'Point Guard'						,NULL						)
		,(2014	,'4-1'		,'USA'		,'Texas'				,'San Antonio'		,'Spurs'					,'https://www.nba.com/spurs/;Total Championships 5'				,'Leonard'		,'2'				,'Kawhi Leonard'		,'Small Forward'					,NULL						)
		,(2014	,'4-1'		,'USA'		,'Texas'				,'San Antonio'		,'Spurs'					,'https://www.nba.com/spurs/;Total Championships 5'				,'Green'		,'14'				,'Danny Green'			,'Shooting Guard;Small Forward'		,NULL						)
		,(2015	,'4-2'		,'USA'		,'California'			,'San Francisco'	,'Golden State Warriors'	,'https://www.nba.com/warriors/;Total Championships 6'			,'Curry'		,'30'				,'Stephen Curry'		,'Point Guard'						,NULL						)
		,(2016	,'4-3'		,'USA'		,'Ohio'					,'Cleveland'		,'Cavaliers'				,'https://www.nba.com/cavaliers/;Total Championships 1'			,'James'		,'23'				,'Lebron James'			,'Small Forward;Power Forward'		,NULL						)
		,(2019	,'4-2'		,'Canada'	,'Ontario'				,'Toronto'			,'Raptors'					,'https://www.nba.com/raptors/;Total Championships 1'			,'Leonard'		,'2'				,'Kawhi Leonard'		,'Small Forward'					,NULL						)
		,(2019	,'4-2'		,'Canada'	,'Ontario'				,'Toronto'			,'Raptors'					,'https://www.nba.com/raptors/;Total Championships 1'			,'Green'		,'14'				,'Danny Green'			,'Shooting Guard;Small Forward'		,NULL						)
		,(2020	,'4-2'		,'USA'		,'California'			,'Los Angeles'		,'Lakers'					,'https://www.nba.com/lakers/;Total Championships 17'			,'James'		,'23'				,'Lebron James'			,'Small Forward;Power Forward'		,NULL						)
		,(2020	,'4-2'		,'USA'		,'California'			,'Los Angeles'		,'Lakers'					,'https://www.nba.com/lakers/;Total Championships 17'			,'Green'		,'14'				,'Danny Green'			,'Shooting Guard;Small Forward'		,NULL						);
		--Year	Series		Country		State Province			City Name			Team Name					Team Info														Jersey Name		Jersey Number		Player Name				Player position						Comments
GO








