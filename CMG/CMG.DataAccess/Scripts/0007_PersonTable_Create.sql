IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.Person') AND TYPE = N'U')
BEGIN
   CREATE TABLE Person
   (
		Id INT NOT NULL IDENTITY(1,1),
		FirstName VARCHAR(50) NOT NULL,
		MiddleName VARCHAR(50),
		LastName VARCHAR(50),
		Sex CHAR,
		IsSmoker BIT,
		BirthDate DATETIME,
		IsDeleted BIT DEFAULT(0) NOT NULL,
		CreatedDate DATETIME NOT NULL,
		CreatedBy VARCHAR(50) NOT NULL,
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CONSTRAINT PK_Person PRIMARY KEY (Id)
   )
END