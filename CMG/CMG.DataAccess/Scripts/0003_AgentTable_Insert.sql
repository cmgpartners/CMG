DECLARE @firstName VARCHAR(50)
SET @firstName = 'Peter'

DECLARE @lastName VARCHAR(50)
SET @lastName = 'Creaghan'

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

SET @firstName = 'Others'
SET @color = '#FFFFFFFF'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		Color,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@color,
		@isDeleted,
		GETDATE(),
		@createdBy
END