IF EXISTS(SELECT 1 FROM sys.columns 
  WHERE Name = N'CommissionType'
  AND Object_ID = Object_ID(N'DBO.Commission'))
BEGIN
	EXEC sp_rename 'dbo.Commission.Id', 'KEYCOMM', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.CommissionType', 'COMMTYPE', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.YearMonth', 'YRMO', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.PayDate', 'PAYDATE', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.Premium', 'PREMIUM', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.RenewalType', 'RENEWALS', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.Total', 'TOTAL', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.PolicyId', 'KEYNUMO', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.ModifiedBy', 'REV_LOCN', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.ModifiedDate', 'REV_DATE', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.CreatedBy', 'CR8_LOCN', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.CreatedDate', 'CR8_DATE', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.IsDeleted', 'DEL_', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.Insured', 'INSURED', 'COLUMN';  
	EXEC sp_rename 'dbo.Commission.Comment', 'COMMENT', 'COLUMN';

	ALTER TABLE Commission ALTER COLUMN COMMTYPE CHAR(1) NOT NULL
	ALTER TABLE Commission ALTER COLUMN YRMO CHAR(6) NOT NULL
	ALTER TABLE Commission ALTER COLUMN PREMIUM NUMERIC(8,0) NOT NULL
	ALTER TABLE Commission ALTER COLUMN RENEWALS CHAR(2) NOT NULL
	ALTER TABLE Commission ALTER COLUMN TOTAL NUMERIC(10,2) NOT NULL
	ALTER TABLE Commission ALTER COLUMN CR8_DATE DATETIME NOT NULL
	ALTER TABLE Commission ALTER COLUMN CR8_LOCN VARCHAR(50) NOT NULL
	ALTER TABLE Commission ALTER COLUMN REV_DATE DATETIME NOT NULL
	ALTER TABLE Commission ALTER COLUMN REV_LOCN VARCHAR(50) NOT NULL
	ALTER TABLE Commission ALTER COLUMN INSURED VARCHAR(50) NOT NULL
	
	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_COMMTYPE]  DEFAULT ('F') FOR [COMMTYPE]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_POLICYNUM]  DEFAULT ('') FOR [POLICYNUM]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_COMPANY]  DEFAULT ('') FOR [COMPANY]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_insured]  DEFAULT ('') FOR [INSURED]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_PREMIUM]  DEFAULT ((0)) FOR [PREMIUM]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_RENEWALS]  DEFAULT ('') FOR [RENEWALS]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_TOTAL]  DEFAULT ((0)) FOR [TOTAL]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_KEYNUMP]  DEFAULT ((0)) FOR [KEYNUMP]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_REV_LOCN]  DEFAULT (suser_sname()) FOR [REV_LOCN]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_REV_DATE]  DEFAULT (getdate()) FOR [REV_DATE]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_CR8_LOCN]  DEFAULT (suser_sname()) FOR [CR8_LOCN]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_CR8_DATE]  DEFAULT (getdate()) FOR [CR8_DATE]

	ALTER TABLE [dbo].[Commission] ADD  CONSTRAINT [DF_Commission_DEL_]  DEFAULT ((0)) FOR [DEL_]
END