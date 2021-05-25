-- 3rd Normal Form
-- all fields determined only by key in table

USE [4_Normal_Form]
GO

CREATE TABLE [dbo].[3NF_GEO]
	(
	[GEO_ID]						[nvarchar](3)	NOT NULL,
	[GEO_Country_Name]				[nvarchar](30)	NULL,
	[GEO_State_Province_Name]		[nvarchar](30)	NULL,
	CONSTRAINT [PK_3NF_GEO_GEO_ID] PRIMARY KEY NONCLUSTERED 
		(
		[GEO_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

INSERT INTO [dbo].[3NF_GEO]
		(
		GEO_ID
			,GEO_Country_Name
				,GEO_State_Province_Name
		)
SELECT	DISTINCT
		UPPER(LEFT(Teams_State_Province_Name,2)) AS GEO_ID
			,Teams_Country_Name
				,Teams_State_Province_Name
FROM	[dbo].[2NF_Teams]




CREATE TABLE [dbo].[3NF_Teams]
	(
	[Teams_ID]							[nvarchar](111)	NOT NULL,
	[Teams_GEO_ID]						[nvarchar](3)	NULL,
	[Teams_City_Name]					[nvarchar](30)	NULL,
	[Teams_Team_Name]					[nvarchar](80)	NULL,
	[Teams_Team_Info_URL]				[nvarchar](200)	NULL,
	[Teams_Team_Info_Championships]		[nvarchar](200)	NULL,
	CONSTRAINT [PK_3NF_Teams_Teams_ID] PRIMARY KEY NONCLUSTERED 
		(
		[Teams_ID] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[3NF_Teams]
		(
		Teams_ID
			,Teams_GEO_ID
				,Teams_City_Name
					,Teams_Team_Name
						,Teams_Team_Info_URL
							,Teams_Team_Info_Championships
		)
SELECT	DISTINCT
		Teams.Teams_ID
			,GEO.GEO_ID
				,Teams.Teams_City_Name
					,Teams.Teams_Team_Name
						,Teams.Teams_Team_Info_URL
							,Teams.Teams_Team_Info_Championships
FROM
		(
		SELECT	Teams_ID,Teams_City_Name,Teams_Team_Name,Teams_Team_Info_URL,Teams_Team_Info_Championships
				,Teams_Country_Name,Teams_State_Province_Name
		FROM	[dbo].[2NF_Teams]
		) AS Teams
	INNER JOIN
		(
		SELECT	GEO_ID,GEO_Country_Name,GEO_State_Province_Name
		FROM	[dbo].[3NF_GEO]
		) AS GEO
	ON	Teams.Teams_Country_Name = GEO.GEO_Country_Name
	AND	Teams.Teams_State_Province_Name = GEO.GEO_State_Province_Name

/*
	Teams Geo
		State Province FK		City Name		Team Name
		CA						Los Angeles		Lakers
		IL						Chicago			Bulls
		TE						San Antonio		Spurs
		FL						Miami			Heat
		ON						Toronto			Raptors
		CA						San Francisco	Golden State Warriors
		OH						Cleveland		Cavaliers
*/


CREATE TABLE [dbo].[3NF_Team_Year]
	(
	[TY_Year]							[int]			NOT NULL,
	[TY_Teams_ID]						[nvarchar](111)	NOT NULL,
	[TY_Series]							[nvarchar](3)	NULL,
	CONSTRAINT [PK_3NF_Team_Year_TY_Year_Teams] PRIMARY KEY NONCLUSTERED 
		(
		[TY_Year],[TY_Teams_ID]
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[3NF_Team_Year]
		(
		TY_Year
			,TY_Teams_ID
				,TY_Series
		)
SELECT	DISTINCT
		TPY_Year
			,TPY_Teams_ID
				,TPY_Series
FROM	[dbo].[2NF_Team_Player_Year]




