IF NOT EXISTS (SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.AgentWithdrawal') AND TYPE = N'U')
BEGIN
	CREATE TABLE AgentWithdrawal
	(
		Id INT NOT NULL IDENTITY(1,1),
		WithdrawalId INT NOT NULL,
		AgentId INT,
		Amount FLOAT,
		IsDeleted BIT DEFAULT(0) NOT NULL,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CONSTRAINT PK_WithdrawalAgent PRIMARY KEY (Id),
		CONSTRAINT FK_Agent_AgentWithdrawal FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id),
		CONSTRAINT FK_WITHD_AgentWithdrawal FOREIGN KEY (WithdrawalId) REFERENCES [dbo].[WITHD](KEYWITH),
	)

select * into WITHD_BACKUP from WITHD
END

