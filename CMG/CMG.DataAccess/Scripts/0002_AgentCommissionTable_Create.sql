IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.AgentCommission') AND Type = N'U')
BEGIN
   CREATE TABLE AgentCommission
   (
		Id int NOT NULL IDENTITY(1,1),
		CommissionId int NOT NULL,
		Commission decimal,
		Split decimal,
		CreatedDate datetime NOT NULL,
		CreatedBy varchar(50) NOT NULL,
		ModifiedDate datetime,
		ModifiedBy varchar(50),
		CONSTRAINT PK_AgentCommission PRIMARY KEY (Id),
		FOREIGN KEY (CommissionId) REFERENCES [dbo].[COMM](KEYCOMM)
   )
END