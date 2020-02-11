IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'Salesforce_Id'
          AND Object_ID = Object_ID(N'DBO.Agent'))
BEGIN
	ALTER TABLE [dbo].[Agent] ADD Salesforce_Id CHAR(18) NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'KEYNUMP'
          AND Object_ID = Object_ID(N'DBO.Agent'))
BEGIN
	ALTER TABLE [dbo].[Agent] ADD KEYNUMP INT NULL

	ALTER TABLE [dbo].[Agent] ADD CONSTRAINT [FK_People_Agent] FOREIGN KEY (KEYNUMP) REFERENCES PEOPLE(KEYNUMP)
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'KEYNUMB'
          AND Object_ID = Object_ID(N'DBO.Agent'))
BEGIN
	ALTER TABLE [dbo].[Agent] ADD KEYNUMB INT NULL

	ALTER TABLE [dbo].[Agent] ADD CONSTRAINT [FK_Business_Agent] FOREIGN KEY (KEYNUMB) REFERENCES BUSINESS(KEYNUMB)
END
GO
