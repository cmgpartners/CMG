IF EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'MARTY' AND Object_ID = Object_ID(N'dbo.WITHD'))
BEGIN
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_MARTY]
	ALTER TABLE WITHD DROP COLUMN MARTY
	
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_PETER]
	ALTER TABLE WITHD DROP COLUMN PETER
	
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_FRANK]
	ALTER TABLE WITHD DROP COLUMN FRANK
	
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_BOB]
	ALTER TABLE WITHD DROP COLUMN BOB
	
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_MARY]
	ALTER TABLE WITHD DROP COLUMN MARY
	
	ALTER TABLE WITHD DROP CONSTRAINT [DF_WITHD_OTHER]
	ALTER TABLE WITHD DROP COLUMN OTHER
END