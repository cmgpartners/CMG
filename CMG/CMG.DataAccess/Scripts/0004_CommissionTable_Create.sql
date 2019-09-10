IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.Commission') AND TYPE = N'U')
BEGIN
	CREATE TABLE Commission
	(
		Id INT NOT NULL IDENTITY(1,1),
		CommissionType CHAR, -- Create ENUMS C#
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
		FOREIGN KEY (PolicyId) REFERENCES [dbo].[Policy](Keynumo)
	)
END

/*
-- Didn't add following columns
FROM MARTY  to SPLIT 5 columns
YRMO
INSURED
KEYNUMP
REV_LOCN
REV_DATE
_DEL
AGENT6	
SPLIT6	
KATE

*/

select * from PEO_POL
where KEYNUMO = '3330' --'5706'
--where HNAME LIKE '%Adout, Yossi%'

select * FROM POLICYS
where POLICYNUM = '8962618-3'

SELECT * FROM COMBO
WHERE FIELDNAME = 'COMPANY'