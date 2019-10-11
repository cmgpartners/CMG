IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.PolicyAgent') AND Type = N'U')
BEGIN
   CREATE TABLE PolicyAgent
   (
		Id int NOT NULL IDENTITY(1,1),
		PolicyId INT NOT NULL,
		AgentId INT,
		Split FLOAT,
		AgentOrder INT,
		IsDeleted BIT,
		IsServiceAgent BIT DEFAULT(0) NOT NULL,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CONSTRAINT PK_PolicyAgent PRIMARY KEY (Id),
		CONSTRAINT FK_Policies_PolicyAgent FOREIGN KEY (PolicyId) REFERENCES [dbo].[POLICYS](KEYNUMO),
		CONSTRAINT FK_Agent_PolicyAgent FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id)
   )
END