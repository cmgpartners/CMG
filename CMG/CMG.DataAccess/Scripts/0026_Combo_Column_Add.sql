IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'Id'
          AND Object_ID = Object_ID(N'DBO.Combo'))
BEGIN

	ALTER TABLE Combo
	Add [Id] [INT] IDENTITY(1,1) NOT NULL

	ALTER TABLE Combo
	ADD CONSTRAINT [PK_Combo] PRIMARY KEY CLUSTERED (
		[Id] ASC
)
END 
GO

