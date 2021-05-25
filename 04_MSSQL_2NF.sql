-- 2nd Normal Form
-- All attributes dependant on the key

-- Prepare 2NF_Teams - add PK to 1NF_Teams
-- We need this for Table Fact_Team_Player_Year

USE [4_Normal_Form]
GO

CREATE TABLE [dbo].[2NF_Teams]
	(
	[Teams_ID]							[nvarchar](111)	NOT NULL,
	[Teams_Country_Name]				[nvarchar](30)	NULL,
	[Teams_State_Province_Name]			[nvarchar](30)	NULL,
	[Teams_City_Name]					[nvarchar](30)	NULL,
	[Teams_Team_Name]					[nvarchar](80)	NULL,
	[Teams_Team_Info_URL]				[nvarchar](200)	NULL,
	[Teams_Team_Info_Championships]		[nvarchar](200)	NULL,
	CONSTRAINT [PK_2NF_Teams_Teams_ID] PRIMARY KEY NONCLUSTERED 
		(
		[Teams_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[2NF_Teams]
		(
		Teams_ID
			,Teams_Country_Name
				,Teams_State_Province_Name
					,Teams_City_Name
						,Teams_Team_Name
							,Teams_Team_Info_URL
								,Teams_Team_Info_Championships
		)
SELECT	REPLACE	(
				CONCAT('',Teams_City_Name,'.',Teams_Team_Name)
				,' '
				,'.'
				) AS Teams_ID
			,Teams_Country_Name
				,Teams_State_Province_Name
					,Teams_City_Name
						,Teams_Team_Name
							,Teams_Team_Info_URL
								,Teams_Team_Info_Championships
FROM	[dbo].[1NF_Teams]


CREATE TABLE [dbo].[2NF_Players]
	(
	[Players_ID]						[nvarchar](100)	NOT NULL,
	[Players_Jersey_Number]				[nvarchar](30)	NULL,
	[Players_Player_Name]				[nvarchar](100)	NULL,
	[Players_Jersey_Name]				[nvarchar](30)	NULL,
	[Players_Player_Position]			[nvarchar](100)	NULL,
	CONSTRAINT [PK_2NF_Players_Players_ID] PRIMARY KEY NONCLUSTERED 
		(
		[Players_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[2NF_Players]
		(
		Players_ID
			,Players_Jersey_Number
				,Players_Player_Name
					,Players_Jersey_Name
						,Players_Player_Position
		)
SELECT	DISTINCT
		REPLACE(Players_Player_Name,' ','.') AS Players_ID
			,NULL AS Players_Jersey_Number
				,Players_Player_Name
					,NULL AS Players_Jersey_Name
						,NULL Players_Player_Position
FROM	[dbo].[1NF_Players]


CREATE TABLE [dbo].[2NF_Team_Player_Year]
	(
	[TPY_Year]							[int]			NOT NULL,
	[TPY_Teams_ID]						[nvarchar](111)	NOT NULL,
	[TPY_Players_ID]					[nvarchar](100)	NOT NULL,
	[TPY_Series]						[nvarchar](3)	NULL,
	CONSTRAINT [PK_Team_Player_Year_TPY_Year_Teams_Players] PRIMARY KEY NONCLUSTERED 
		(
		[TPY_Year],[TPY_Teams_ID],[TPY_Players_ID]
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[2NF_Team_Player_Year]
		(
		TPY_Year
			,TPY_Teams_ID
				,TPY_Players_ID
					,TPY_Series
		)
SELECT	rawdata.rawdata_Year
			,Teams.Teams_ID
				,Players.Players_ID
					,rawdata.rawdata_Series
FROM
		(
		SELECT	rawdata_Year,rawdata_Series,rawdata_City_Name,rawdata_Team_Name,rawdata_Player_Name
		FROM	[dbo].[rawdata]
		) AS rawdata
	INNER JOIN
		(
		SELECT	Teams_ID,Teams_City_Name,Teams_Team_Name
		FROM	[dbo].[2NF_Teams]
		) AS Teams
	ON	rawdata.rawdata_City_Name = Teams.Teams_City_Name
	AND	rawdata.rawdata_Team_Name = Teams.Teams_Team_Name
	INNER JOIN
		(
		SELECT	Players_ID,Players_Player_Name
		FROM	[dbo].[2NF_Players]
		) AS Players
	ON	rawdata.rawdata_Player_Name = Players.Players_Player_Name


/*
	Fact_Team_Player_Year
		Year	City Name		Team Name		Player Name			Series
		1987	Los Angeles		Lakers			A.C. Green			4-2
		1988	Los Angeles		Lakers			A.C. Green			4-3
		1991	Chicago			Bulls			Michael Jordan		4-1
		1992	Chicago			Bulls			Michael Jordan		4-2
		1993	Chicago			Bulls			Michael Jordan		4-2
		1996	Chicago			Bulls			Michael Jordan		4-2
		1997	Chicago			Bulls			Michael Jordan		4-2
		1998	Chicago			Bulls			Michael Jordan		4-2
		2000	Los Angeles		Lakers			A.C. Green			4-2
		2003	San Antonio		Spurs			Tony Parker			4-2
		2012	Miami			Heat			Lebron James		4-1
		2013	Miami			Heat			Lebron James		4-3
		2014	San Antonio		Spurs			Tony Parker			4-1
		2014	San Antonio		Spurs			Kawhi Leonard		4-1
		2014	San Antonio		Spurs			Danny Green			4-1
		2019	Toronto			Raptors			Kawhi Leonard		4-3
		2019	Toronto			Raptors			Danny Green			4-2
		2016	Cleveland		Cavaliers		Lebron James		4-2
		2020	Los Angeles		Lakers			Lebron James		4-2
		2020	Los Angeles		Lakers			Danny Green			4-2
*/

