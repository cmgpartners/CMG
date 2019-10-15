IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.AgentCommission') AND Type = N'U')
BEGIN
   CREATE TABLE AgentCommission
   (
		Id int NOT NULL IDENTITY(1,1),
		AgentId INT,
		CommissionId INT NOT NULL,
		Commission FLOAT,
		Split FLOAT,
		AgentOrder INT,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME NOT NULL,
		ModifiedBy VARCHAR(50) NOT NULL,
		CONSTRAINT PK_AgentCommission PRIMARY KEY (Id),
		CONSTRAINT FK_Commission_AgentCommission FOREIGN KEY (CommissionId) REFERENCES [dbo].[Commission](Id),
		CONSTRAINT FK_Agent_AgentCommission FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id)
   )

	ALTER TABLE [dbo].[AgentCommission] ADD  CONSTRAINT [DF_AgentCommission_ModifiedBy]  DEFAULT (suser_sname()) FOR [ModifiedBy]

	ALTER TABLE [dbo].[AgentCommission] ADD  CONSTRAINT [DF_AgentCommission_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]

	ALTER TABLE [dbo].[AgentCommission] ADD  CONSTRAINT [DF_AgentCommission_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]

	ALTER TABLE [dbo].[AgentCommission] ADD  CONSTRAINT [DF_AgentCommission_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]

END