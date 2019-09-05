IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.Agent') AND Type = N'U')
BEGIN
   CREATE TABLE Agent
   (
		Id int NOT NULL IDENTITY(1,1),
		FirstName varchar(50) NOT NULL,
		LastName varchar(50) NOT NULL,
		AgentCode varchar(5) NOT NULL,
		IsDeleted bit default(0) NOT NULL,
		CreatedDate datetime NOT NULL,
		CreatedBy varchar(50) NOT NULL,
		ModifiedDate datetime,
		ModifiedBy varchar(50),
		CONSTRAINT PK_Agent PRIMARY KEY (Id)
   )
END