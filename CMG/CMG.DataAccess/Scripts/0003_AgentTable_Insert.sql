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

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Frank'
SET @agentCode = 'FAC'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Bob'
SET @lastName = 'Gould'
SET @agentCode = 'RRG'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Mary'
SET @lastName = 'Murphy'
SET @agentCode = 'MEM'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Kate'
SET @lastName = 'McConnell'
SET @agentCode = 'KAC'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Marty'
SET @lastName = 'McConnell'
SET @agentCode = 'MJM'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		LastName,
		AgentCode,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@lastName,
		@agentCode,
		@isDeleted,
		GETDATE(),
		@createdBy
END

SET @firstName = 'Others'

IF NOT EXISTS (SELECT TOP 1 * FROM [dbo].Agent WHERE FirstName = @firstName AND LastName = @lastName)
BEGIN
	INSERT INTO Agent
	(
		FirstName,
		IsDeleted,
		CreatedDate,
		CreatedBy
	)
	SELECT
		@firstName,
		@isDeleted,
		GETDATE(),
		@createdBy
END
