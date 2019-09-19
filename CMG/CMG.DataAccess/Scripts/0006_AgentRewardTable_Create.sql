IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.AgentReward') AND TYPE = N'U')
BEGIN
	CREATE TABLE AgentReward
	(
		ID INT NOT NULL IDENTITY(1,1),
		AgentId INT,
		Amount DECIMAL,
		Year INT,
		Month INT,
		CreatedDate DATETIME,
		CreatedBy VARCHAR(50),
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50)
		CONSTRAINT FK_Agent_AgentReward FOREIGN KEY (AgentId) REFERENCES [dbo].[Agent](Id)
	)
END

