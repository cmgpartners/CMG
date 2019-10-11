IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'POLICYNUM'
          AND Object_ID = Object_ID(N'DBO.Commission'))
BEGIN

	ALTER TABLE Commission ADD POLICYNUM VARCHAR(25) 

	ALTER TABLE Commission ADD COMPANY CHAR(10) 

	ALTER TABLE Commission ADD KEYNUMP INT 
END 
GO

-- UPDATE new added columns (POLICYNUM, KEYNUMP, COMPANY)
UPDATE c
SET c.POLICYNUM = p.POLICYNUM,
	c.KEYNUMP = 0,
	c.COMPANY = p.COMPANY
FROM Commission c
INNER JOIN POLICYS p
ON p.KEYNUMO = c.PolicyId

IF EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'POLICYNUM'
          AND Object_ID = Object_ID(N'DBO.Commission'))
BEGIN
	ALTER TABLE Commission ALTER COLUMN POLICYNUM  VARCHAR(25) NOT NULL
	ALTER TABLE Commission ALTER COLUMN COMPANY CHAR(10) NOT NULL
	ALTER TABLE Commission ALTER COLUMN KEYNUMP INT NOT NULL
END