-- 4th Normal Form
-- no multi value

USE [4_Normal_Form]
GO

-- 3NF_GEO is correct
-- Create the same as 4NF_GEO

CREATE TABLE [dbo].[4NF_GEO]
	(
	[GEO_ID]						[nvarchar](3)	NOT NULL,
	[GEO_Country_Name]				[nvarchar](30)	NULL,
	[GEO_State_Province_Name]		[nvarchar](30)	NULL,
	CONSTRAINT [PK_4NF_GEO_GEO_ID] PRIMARY KEY NONCLUSTERED 
		(
		[GEO_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

INSERT INTO [dbo].[4NF_GEO]
		(
		GEO_ID
			,GEO_Country_Name
				,GEO_State_Province_Name
		)
SELECT	GEO_ID
			,GEO_Country_Name
				,GEO_State_Province_Name
FROM	[dbo].[3NF_GEO]


-- 3NF_Teams is correct
-- Create the same as 4NF_Teams
CREATE TABLE [dbo].[4NF_Teams]
	(
	[Teams_ID]							[nvarchar](111)	NOT NULL,
	[Teams_GEO_ID]						[nvarchar](3)	NULL,
	[Teams_City_Name]					[nvarchar](30)	NULL,
	[Teams_Team_Name]					[nvarchar](80)	NULL,
	[Teams_Team_Info_URL]				[nvarchar](200)	NULL,
	[Teams_Team_Info_Championships]		[nvarchar](200)	NULL,
	CONSTRAINT [PK_4NF_Teams_Teams_ID] PRIMARY KEY NONCLUSTERED 
		(
		[Teams_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

INSERT INTO [dbo].[4NF_Teams]
		(
		Teams_ID
			,Teams_GEO_ID
				,Teams_City_Name
					,Teams_Team_Name
						,Teams_Team_Info_URL
							,Teams_Team_Info_Championships
		)
SELECT	Teams_ID
			,Teams_GEO_ID
				,Teams_City_Name
					,Teams_Team_Name
						,Teams_Team_Info_URL
							,Teams_Team_Info_Championships
FROM	[dbo].[3NF_Teams]


-- 3NF_Team_Year is correct
-- Create the same as 4NF_Team_Year
CREATE TABLE [dbo].[4NF_Team_Year]
	(
	[TY_Year]							[int]			NOT NULL,
	[TY_Teams_ID]						[nvarchar](111)	NOT NULL,
	[TY_Series]							[nvarchar](3)	NULL,
	CONSTRAINT [PK_4NF_Team_Year_TY_Year_Teams] PRIMARY KEY NONCLUSTERED 
		(
		[TY_Year],[TY_Teams_ID]
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

INSERT INTO [dbo].[4NF_Team_Year]
		(
		TY_Year
			,TY_Teams_ID
				,TY_Series
		)
SELECT	TY_Year
			,TY_Teams_ID
				,TY_Series
FROM	[dbo].[3NF_Team_Year]


-- Players must go back to the begining
CREATE TABLE [dbo].[4NF_Players]
	(
	[Players_ID]						[nvarchar](100)	NOT NULL,
	[Players_Player_Name]				[nvarchar](100)	NULL,
	-- [Players_Jersey_Name]				[nvarchar](30)	NULL,
	CONSTRAINT [PK_4NF_Players_Players_ID] PRIMARY KEY NONCLUSTERED 
		(
		[Players_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO
INSERT INTO [dbo].[4NF_Players]
		(
		Players_ID
			,Players_Player_Name
				-- ,Players_Jersey_Name
		)
SELECT	DISTINCT
		REPLACE(Players_Player_Name,' ','.') AS Players_ID
			,Players_Player_Name
					-- ,Players_Jersey_Name
FROM	[dbo].[1NF_Players]





CREATE TABLE [dbo].[4NF_Players_Position]
	(
	[Players_ID]						[nvarchar](100)	NOT NULL,
	[Players_Player_Position]			[nvarchar](100)	NOT NULL,
	CONSTRAINT [PK_4NF_Players_Position_Players_ID_Position] PRIMARY KEY NONCLUSTERED 
		(
		[Players_ID],Players_Player_Position ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_4NF_Players_Position_Players_ID ON [dbo].[4NF_Players_Position](Players_ID)
GO

INSERT INTO [dbo].[4NF_Players_Position]
		(
		Players_ID
			,Players_Player_Position
		)
SELECT	DISTINCT
		Players1.Players_ID
			,Players2.Players_Player_Position
FROM
		(
		SELECT	Players_ID,Players_Player_Name
		FROM	[dbo].[4NF_Players]
		) AS Players1
	INNER JOIN
		(
		SELECT	Players_Player_Name,Players_Player_Position
		FROM	[dbo].[1NF_Players]
		) AS Players2
	ON	Players1.Players_Player_Name = Players2.Players_Player_Name









CREATE TABLE [dbo].[4NF_PlayersJersey]
	(
	[PlayersJersey_ID]							[nvarchar](111)	NOT NULL,
	[PlayersJersey_Players_ID]					[nvarchar](100)	NULL,
	[PlayersJersey_Year]						[int]			NULL,
	[PlayersJersey_Players_Jersey_Percentage]	[nvarchar](3)	NULL,
	[PlayersJersey_Players_Jersey_Number]		[nvarchar](30)	NULL,
	[PlayersJersey_Players_Jersey_Name]			[nvarchar](30)	NULL,
	CONSTRAINT [PK_4NF_PlayersJersey_PlayersJersey_ID] PRIMARY KEY NONCLUSTERED 
		(
		[PlayersJersey_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX IX_4NF_PlayersJersey_PlayersJersey_Players_ID ON [dbo].[4NF_PlayersJersey](PlayersJersey_Players_ID)
GO

INSERT INTO [dbo].[4NF_PlayersJersey]
		(
		PlayersJersey_ID
			,PlayersJersey_Players_ID
				,PlayersJersey_Year
					,PlayersJersey_Players_Jersey_Percentage
						,PlayersJersey_Players_Jersey_Number
							,PlayersJersey_Players_Jersey_Name
		)
SELECT	CONCAT('',Players.Players_ID,'.',rawdata.rawdata_Jersey_Number,'.',ISNULL(rawdata.rawdata_Year,'') ) AS PlayersJersey_ID
			,Players.Players_ID
				,rawdata.rawdata_Year
					,rawdata.rawdata_Percentage
						,rawdata.rawdata_Jersey_Number
							,rawdata.rawdata_Jersey_Name
FROM
		(
		SELECT	Players_ID,Players_Player_Name
		FROM	[dbo].[4NF_Players]
		) AS Players
	INNER JOIN
		(
		SELECT	DISTINCT *
		FROM
				(
				SELECT	CASE WHEN rawdata4.rawdata_Year IS NULL THEN NULL ELSE rawdata3.rawdata_Year END AS rawdata_Year
						,rawdata3.rawdata_Jersey_Name
						,rawdata3.rawdata_Player_Name
						,CASE
							WHEN rawdata4.rawdata_Year IS NULL THEN rawdata3.rawdata_Jersey_Number
							ELSE rawdata4.rawdata_Jersey_Number
						END AS rawdata_Jersey_Number
						,CASE
							WHEN rawdata4.rawdata_Year IS NULL THEN 100
							ELSE rawdata4.rawdata_Percentage_5
						END AS rawdata_Percentage
				FROM
						(
						SELECT	rawdata_Year,rawdata_Jersey_Name,rawdata_Player_Name
								,CASE rawdata_Jersey_Number_2
									WHEN 0 THEN rawdata_Jersey_Number
									ELSE SUBSTRING(rawdata_Jersey_Number,1,rawdata_Jersey_Number_2-1)
								END AS rawdata_Jersey_Number
						FROM
								(
								SELECT	rawdata_Year,rawdata_Jersey_Name,rawdata_Player_Name,rawdata_Jersey_Number
										,LEN(rawdata_Jersey_Number) AS rawdata_Jersey_Number_1
										,CHARINDEX(',',rawdata_Jersey_Number) AS rawdata_Jersey_Number_2
								FROM	[dbo].[rawdata]
								) AS rawdata
						) AS rawdata3
					LEFT OUTER JOIN
						(
						SELECT	rawdata1.rawdata_Jersey_Number,rawdata2.*
						FROM
								(
								SELECT	rawdata_Player_Name,value AS rawdata_Jersey_Number
								FROM
										(
										SELECT DISTINCT rawdata_Player_Name,rawdata_Jersey_Number
										FROM	[dbo].[rawdata]  
										) AS rawdata
									CROSS APPLY
										STRING_SPLIT(rawdata_Jersey_Number, ',')
								) AS rawdata1
							LEFT OUTER JOIN
								(
								SELECT	rawdata_Year,rawdata_Player_Name,rawdata_Percentage
										,SUBSTRING(rawdata_Percentage, 1, rawdata_Percentage_2-1) AS rawdata_Percentage_4
										,SUBSTRING(rawdata_Percentage, rawdata_Percentage_2+1, rawdata_Percentage_3-rawdata_Percentage_2-1) AS rawdata_Percentage_5
								FROM
										(
										SELECT	*
												,LEN(rawdata_Percentage) AS rawdata_Percentage_1
												,CHARINDEX('-',rawdata_Percentage) AS rawdata_Percentage_2
												,CHARINDEX('%',rawdata_Percentage) AS rawdata_Percentage_3
										FROM
												(
												SELECT	rawdata_Year,rawdata_Player_Name,value AS rawdata_Percentage
												FROM
														(
														SELECT	rawdata_Year,rawdata_Player_Name,rawdata_Comments
														FROM	[dbo].[rawdata]
														WHERE	ISNULL(CHARINDEX(';',rawdata_Comments),0) NOT IN (0)
														) AS rawdata
													CROSS APPLY
														STRING_SPLIT(rawdata_Comments, ';')
												) AS rawdata
										) AS rawdata
								) AS rawdata2
							ON	rawdata1.rawdata_Player_Name = rawdata2.rawdata_Player_Name
							AND	rawdata1.rawdata_Jersey_Number = rawdata2.rawdata_Percentage_4
						) AS rawdata4
					ON	rawdata3.rawdata_Player_Name = rawdata4.rawdata_Player_Name
					AND	rawdata3.rawdata_Year = rawdata4.rawdata_Year
				) AS rawdata
		) AS rawdata
	ON	Players.Players_Player_Name = rawdata.rawdata_Player_Name
