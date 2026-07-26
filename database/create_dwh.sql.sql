USE master;
GO

IF DB_ID('DWH_Telekom') IS NOT NULL
BEGIN
    DROP DATABASE DWH_Telekom;
END
GO

CREATE DATABASE DWH_Telekom;
GO

USE DWH_Telekom;
GO