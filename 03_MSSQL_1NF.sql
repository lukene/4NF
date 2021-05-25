-- 1st Normal Form
-- Split Arrays
-- Split Mixed types


USE [4_Normal_Form]
GO

CREATE TABLE [dbo].[1NF_Teams]
	(
	[Teams_Country_Name]				[nvarchar](30)	NULL,
	[Teams_State_Province_Name]			[nvarchar](30)	NULL,
	[Teams_City_Name]					[nvarchar](30)	NULL,
	[Teams_Team_Name]					[nvarchar](80)	NULL,
	[Teams_Team_Info_URL]				[nvarchar](200)	NULL,
	[Teams_Team_Info_Championships]		[nvarchar](200)	NULL,
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[1NF_Teams]
		(
		Teams_Country_Name
			,Teams_State_Province_Name
				,Teams_City_Name
					,Teams_Team_Name
						,Teams_Team_Info_URL
							,Teams_Team_Info_Championships
		)
SELECT	rawdata_Country_Name
			,rawdata_State_Province_Name
				,rawdata_City_Name
					,rawdata_Team_Name
						,rawdata_Team_Info_3
							,rawdata_Team_Info_4
FROM
		(
		SELECT	*
				,SUBSTRING(rawdata_Team_Info, 1, rawdata_Team_Info_2-1)	AS rawdata_Team_Info_3
				,REPLACE	(
							SUBSTRING(rawdata_Team_Info, rawdata_Team_Info_2+1, rawdata_Team_Info_1-rawdata_Team_Info_2)
							,'Total Championships '
							,'') AS rawdata_Team_Info_4
		FROM
				(
				SELECT	DISTINCT rawdata_Country_Name
						,rawdata_State_Province_Name
						,rawdata_City_Name
						,rawdata_Team_Name
						,rawdata_Team_Info
						,LEN(rawdata_Team_Info) AS rawdata_Team_Info_1
						,CHARINDEX(';',rawdata_Team_Info) AS rawdata_Team_Info_2
				FROM	[dbo].[rawdata]
				) AS rawdata
		) AS rawdata


/*
	Players Jersey WRONG
		Jersey Name		Jersey Number
		Green			45
		Jordan			12
		Jordan			23
		Jordan			45
		Parker			9
		James			23
		Leonard			2
		Green			14

	Players Position WRONG
		Jersey Name		Player Position
		Green			Power Forward
		Jordan			Shooting Guard
		Parker			Point Guard
		James			Small Forward
		James			Power Forward
		Leonard			Small Forward
		Green			Shooting Guard
		Green			Small Forward
*/


USE [4_Normal_Form]
GO

CREATE TABLE [dbo].[1NF_Players]
	(
	[Players_Jersey_Number]				[nvarchar](30)	NULL,
	[Players_Player_Name]				[nvarchar](100)	NULL,
	[Players_Jersey_Name]				[nvarchar](30)	NULL,
	[Players_Player_Position]			[nvarchar](100)	NULL,
	) ON [PRIMARY]
GO


INSERT INTO [dbo].[1NF_Players]
		(
		Players_Jersey_Number
			,Players_Player_Name
				,Players_Jersey_Name
					,Players_Player_Position
		)
SELECT	rawdata_Jersey_Number
			,rawdata_Player_Name
				,rawdata_Jersey_Name
					,rawdata_Position
FROM
		(
		SELECT	rawdata_Player_Name,rawdata_Jersey_Name,rawdata_Position,value AS rawdata_Jersey_Number
		FROM
				(
				SELECT DISTINCT rawdata_Player_Name,rawdata_Jersey_Name,rawdata_Jersey_Number,value AS rawdata_Position
				FROM	[dbo].[rawdata]  
					CROSS APPLY
						STRING_SPLIT(rawdata_Player_Position, ';')
				) AS rawdata
			CROSS APPLY
				STRING_SPLIT(rawdata_Jersey_Number, ',')
		) AS rawdata


/*
	Players
		Jersey Number		Player Name				Jersey Name		Player position
		45					A.C. Green				Green			Power Forward
		14					Danny Green				Green			Shooting Guard
		14					Danny Green				Green			Small Forward
		2					Kawhi Leonard			Leonard			Small Forward
		23					Lebron James			James			Small Forward
		23					Lebron James			James			Power Forward
		23					Michael Jordan			Jordan			Shooting Guard
		12					Michael Jordan			Jordan			Shooting Guard
		45					Michael Jordan			Jordan			Shooting Guard
		30					Stephen Curry			Curry			Point Guard
		9					Tony Parker				Parker			Point Guard
*/

