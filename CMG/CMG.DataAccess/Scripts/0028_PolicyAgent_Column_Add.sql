IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'Salesforce_Id'
          AND Object_ID = Object_ID(N'DBO.PolicyAgent'))
BEGIN
	ALTER TABLE PolicyAgent ADD Salesforce_Id CHAR(18) NULL
END

GO