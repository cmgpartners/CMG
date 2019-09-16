IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.AgentCommission') AND Type = N'U')
BEGIN
   CREATE TABLE AgentCommission
   (
		Id int NOT NULL IDENTITY(1,1),
		AgentId INT,
		CommissionId INT NOT NULL,
		Commission FLOAT,
		Split FLOAT,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CONSTRAINT PK_AgentCommission PRIMARY KEY (Id),
		FOREIGN KEY (CommissionId) REFERENCES [dbo].[Commission](Id),
		FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id)
   )
END