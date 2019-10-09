DECLARE @firstName VARCHAR(50)
SET @firstName = 'Peter'

DECLARE @lastName VARCHAR(50)
SET @lastName = 'Creaghan'

DECLARE @middlename VARCHAR(50)

DECLARE @agentCode VARCHAR(5)
SET @agentCode = 'PFC'

DECLARE @createdBy VARCHAR(50)
SET @createdBy = 'RNakum'

DECLARE @isDeleted BIT
SET @isDeleted = 0

DECLARE @color VARCHAR(15)
SET @color = '#FFF0C6FF'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Frank'
SET @agentCode = 'FAC'
SET @color = '#FFA8DFF6'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Bob'
SET @lastName = 'Gould'
SET @agentCode = 'RRG'
SET @color = '#FFFFBEBE'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Mary'
SET @lastName = 'Murphy'
SET @agentCode = 'MEM'
SET @color = '#FFFFE76A'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Kate'
SET @lastName = 'McConnell'
SET @agentCode = 'KAC'
SET @color = '#FFAEA7A7'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Marty'
SET @lastName = 'McConnell'
SET @agentCode = 'MJM'
SET @color = '#FFB2E888'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'CMG'
SET @color = '#FFFF35C5'
SET @agentCode = 'CMG'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@agentCode,
		@color,
		@isDeleted,
		0,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Others'
SET @color = '#FFE5EBF1'
SET @agentCode = 'OTH'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

-- EXTERNAL AGENTS --------------------------
SET @firstName = 'Dean'
SET @lastName = 'French'
SET @middleName = 'R'
SET @agentCode = 'DRF'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Edward'
SET @lastName = 'Martin'
SET @middleName = 'J'
SET @agentCode = 'EJM'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END


SET @firstName = 'GAS'
SET @agentCode = 'GAS'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'John'
SET @lastName = 'McConnell'
SET @middleName = 'E'
SET @agentCode = 'JEM'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Kirk'
SET @lastName = 'Polson'
SET @middleName = 'J'
SET @agentCode = 'JKP'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Lawrance'
SET @lastName = 'Geller'
SET @middleName = 'I'
SET @agentCode = 'LIG'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Peter'
SET @lastName = 'Emerson'
SET @middleName = 'I'
SET @agentCode = 'PE'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Phil'
SET @lastName = 'Belec'
SET @middleName = 'J'
SET @agentCode = 'PJB'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Paul'
SET @lastName = 'Tompkins'
SET @middleName = 'M'
SET @agentCode = 'PMT'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		MiddleName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@middleName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'RC'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@firstName,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'TIC'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@firstName,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Tom'
SET @lastName = 'McBride'
SET @agentCode = 'TM'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END

SET @firstName = 'TP'
SET @color = '#FFE5EBF1'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		AgentCode,
		Color,
		IsDeleted,
		IsExternal,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@firstName,
		@color,
		@isDeleted,
		1,
		GETDATE(),
		@createdBy
END