IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.Commission') AND TYPE = N'U')
BEGIN
	CREATE TABLE Commission
	(
		Id INT NOT NULL IDENTITY(1,1),
		CommissionType CHAR, -- Create ENUMS C#
		YearMonth INT,
		PayDate DATETIME,
		PolicyId INT,
		Premium DECIMAL,
		RenewalType VARCHAR(5), -- Create ENUMS C#
		Total DECIMAL,
		IsDeleted BIT,
		CreatedDate DATETIME,
		CreatedBy VARCHAR(50),
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		FOREIGN KEY (PolicyId) REFERENCES [dbo].[Policys](Keynumo)
	)
END