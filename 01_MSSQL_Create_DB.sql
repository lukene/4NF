USE [master]
GO

CREATE DATABASE [4_Normal_Form] CONTAINMENT = NONE
ON  PRIMARY 
	(
	NAME = N'4_Normal_Form_Data', FILENAME = N'D:\MSSQL\Data\4_Normal_Form_Data.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB
	)
	LOG ON 
	(
	NAME = N'4_Normal_Form_log', FILENAME = N'D:\MSSQL\Logs\4_Normal_Form_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB
	)
GO

ALTER DATABASE [4_Normal_Form] SET RECOVERY SIMPLE WITH NO_WAIT
GO

USE [4_Normal_Form]
GO
ALTER AUTHORIZATION ON DATABASE::[4_Normal_Form] TO [sa]
GO