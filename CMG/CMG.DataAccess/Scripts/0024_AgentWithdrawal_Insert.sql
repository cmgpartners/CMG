IF NOT EXISTS(SELECT TOP 1 * FROM AgentWithdrawal)
BEGIN
	DECLARE @agentPeter INT
	SET @agentPeter = 1	
	DECLARE @agentCodePeter VARCHAR(5)
	SET @agentCodePeter = 'PFC'

	DECLARE @agentFrank INT
	SET @agentFrank = 2	
	DECLARE @agentCodeFrank VARCHAR(5)
	SET @agentCodeFrank = 'FAC'

	DECLARE @agentBob INT
	SET @agentBob = 3
	DECLARE @agentCodeBob VARCHAR(5)
	SET @agentCodeBob = 'RRG'

	DECLARE @agentMary INT
	SET @agentMary = 4
	DECLARE @agentCodeMary VARCHAR(5)
	SET @agentCodeMary = 'MEM'

	DECLARE @agentKate INT
	SET @agentKate = 5
	DECLARE @agentCodeKate VARCHAR(5)
	SET @agentCodeKate = 'KAC'

	DECLARE @agentMarty INT
	SET @agentMarty = 6	
	DECLARE @agentCodeMarty VARCHAR(5)
	SET @agentCodeMarty = 'MJM'

	DECLARE @agentCMG INT
	SET @agentCMG = 7
	DECLARE @agentCodeCMG VARCHAR(5)
	SET @agentCodeCMG = 'CMG'

	DECLARE @agentOthers INT
	SET @agentOthers = 8
	DECLARE @agentCodeOthers VARCHAR(5)
	SET @agentCodeOthers = 'OTH'

	DECLARE @withhdKey INT
	DECLARE @martyAmount FLOAT
	DECLARE @peterAmount FLOAT
	DECLARE @frankAmount FLOAT
	DECLARE @bobAmount FLOAT
	DECLARE @maryAmount FLOAT
	DECLARE @otherAmount FLOAT
	DECLARE @createdBy VARCHAR(50)
	DECLARE @createdDate DATETIME
	DECLARE @modifiedBy VARCHAR(50)
	DECLARE @modifiedDate DATETIME

	DECLARE db_cursorOne CURSOR FOR
	SELECT 
		KEYWITH,
		MARTY,
		PETER,
		FRANK,
		BOB,
		MARY,
		OTHER,
		CR8_DATE,
		CR8_LOCN,
		REV_DATE,
		REV_LOCN
	FROM WITHD

	OPEN db_cursorOne
		FETCH NEXT FROM db_cursorOne INTO @withhdKey, @martyAmount, @peterAmount, @frankAmount, @bobAmount, @maryAmount, @otherAmount, 
						 @createdDate, @createdBy,@modifiedDate, @modifiedBy
		
		WHILE @@fetch_status = 0
		BEGIN
		
		IF (@martyAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentMarty,
				@martyAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END

		IF (@peterAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentPeter,
				@peterAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END

		IF (@frankAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentFrank,
				@frankAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END
		
		IF (@bobAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentBob,
				@bobAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END

		IF (@maryAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentMary,
				@maryAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END

		IF (@otherAmount <> 0)
		BEGIN
			INSERT INTO AgentWithdrawal 
			(
				WithdrawalId, 
				AgentId, 
				Amount, 
				IsDeleted, 
				CreatedDate, 
				CreatedBy, 
				ModifiedDate, 
				ModifiedBy
			)
			SELECT
				@withhdKey,
				@agentOthers,
				@otherAmount,
				0,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
		END

			FETCH NEXT FROM db_cursorOne INTO @withhdKey, @martyAmount, @peterAmount, @frankAmount, @bobAmount, @maryAmount, @otherAmount, 
						 @createdDate, @createdBy,@modifiedDate, @modifiedBy
		END

	CLOSE db_cursorOne
	DEALLOCATE db_cursorOne

END