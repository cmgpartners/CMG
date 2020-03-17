IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.CaseAgent') AND Type = N'U')
BEGIN
   CREATE TABLE CaseAgent
   (
		Id int NOT NULL IDENTITY(1,1),
		CaseId INT NOT NULL,
		AgentId INT,
		AgentOrder INT,
		IsDeleted BIT,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CONSTRAINT PK_CaseAgent PRIMARY KEY (Id),
		CONSTRAINT FK_CASES_CaseAgent FOREIGN KEY (CaseId) REFERENCES [dbo].[CASES](KEYCASE),
		CONSTRAINT FK_Agent_CaseAgent FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id)
   )
END