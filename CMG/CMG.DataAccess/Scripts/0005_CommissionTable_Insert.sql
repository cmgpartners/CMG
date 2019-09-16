IF NOT EXISTS(SELECT TOP 1 * FROM Commission)
BEGIN
	DECLARE @policyNumberMisc INT
	SET @policyNumberMisc = 7825

	DECLARE @PolicyNumberRollUp INT
	SET @PolicyNumberRollUp = 7824

	DECLARE @agentPeter INT
	SET @agentPeter = 1

	DECLARE @agentFrank INT
	SET @agentFrank = 2

	DECLARE @agentBob INT
	SET @agentBob = 3

	DECLARE @agentMary INT
	SET @agentMary = 4

	DECLARE @agentKate INT
	SET @agentKate = 5

	DECLARE @agentMarty INT
	SET @agentMarty = 6

	DECLARE @agentOthers INT
	SET @agentOthers = 7

	-- Commission Table
	DECLARE @commissionType CHAR
	DECLARE @yearMonth INT
	DECLARE @payDate DATETIME
	DECLARE @policyId INT
	DECLARE @premium FLOAT
	DECLARE @renewalType VARCHAR(5)
	DECLARE @total FLOAT
	DECLARE @isDeleted BIT
	DECLARE @commissionMarty FLOAT
	DECLARE @commissionPeter FLOAT
	DECLARE @commissionFrank FLOAT
	DECLARE @commissionBob FLOAT
	DECLARE @commissionMary FLOAT
	DECLARE @commissionKate FLOAT
	DECLARE @commissionOther FLOAT

	DECLARE @splitMarty FLOAT
	DECLARE @splitPeter FLOAT
	DECLARE @splitFrank FLOAT
	DECLARE @splitBob FLOAT
	DECLARE @splitMary FLOAT
	DECLARE @splitKate FLOAT

	-- AgentCommission Table
	DECLARE @agentId INT
	DECLARE @commissionId INT
	DECLARE @commission FLOAT
	DECLARE @split FLOAT
	DECLARE @createdBy VARCHAR(50)
	DECLARE @createdDate DATETIME
	DECLARE @modifiedBy VARCHAR(50)
	DECLARE @modifiedDate DATETIME

	DECLARE db_cursorOne CURSOR FOR
	SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			plcy.KEYNUMO AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		INNER JOIN POLICYS plcy
		 ON plcy.KEYNUMO = comm.KEYNUMO
	-- Inserted 19091 records above select

	OPEN db_cursorOne
		FETCH NEXT FROM db_cursorOne INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorOne INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorOne

	DEALLOCATE db_cursorOne

	/*
		SCENARIO 2 - 132 Records
	*/
	DECLARE db_cursorTwo CURSOR FOR
		SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			(SELECT TOP 1 KEYNUMO FROM POLICYS WHERE TRIM(comm.POLICYNUM) = TRIM(POLICYNUM) AND comm.KEYNUMO = 0 AND TRIM(comm.POLICYNUM) <> '') AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		WHERE TRIM(comm.POLICYNUM) IN (SELECT TRIM(POLICYNUM) FROM POLICYS)
			AND comm.KEYNUMO = 0
			AND TRIM(comm.POLICYNUM) <> ''

	OPEN db_cursorTwo
		FETCH NEXT FROM db_cursorTwo INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorTwo INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorTwo

	DEALLOCATE db_cursorTwo

	/*
		SCENARIO 3 - 4742 Records
	*/
	DECLARE db_cursorThree CURSOR FOR
		SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			@policyNumberMisc AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND TRIM(comm.POLICYNUM) = ''
	-- Inserted 19091 records above select

	OPEN db_cursorThree
		FETCH NEXT FROM db_cursorThree INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorThree INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorThree

	DEALLOCATE db_cursorThree

	/*
		SCENARIO 4 - 219 Records
	*/
	DECLARE db_cursorFour CURSOR FOR
		SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			@policyNumberMisc AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND insured LIKE '%Daneluzzi, Denise%'
			AND comm.POLICYNUM NOT IN (SELECT POLICYNUM FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorFour
		FETCH NEXT FROM db_cursorFour INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorFour INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorFour

	DEALLOCATE db_cursorFour

	/*
		SCENARIO 5 - 6225 Records
	*/

	DECLARE db_cursorFive CURSOR FOR
		SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			@policyNumberMisc AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND insured <> 'Daneluzzi, Denise'
			AND comm.POLICYNUM NOT IN (SELECT POLICYNUM FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorFive
		FETCH NEXT FROM db_cursorFive INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorFive INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorFive

	DEALLOCATE db_cursorFive

	/*
		SCENARIO 6 - 481 Records
	*/
	DECLARE db_cursorSix CURSOR FOR
		SELECT 
			TRIM(comm.COMMTYPE),
			TRIM(comm.YRMO),
			comm.PAYDATE,
			@policyNumberMisc AS POL_KEYNUMO,
			comm.PREMIUM,
			TRIM(comm.RENEWALS),
			comm.TOTAL,
			comm.DEL_,
			comm.CR8_DATE,
			TRIM(comm.CR8_LOCN),
			comm.REV_DATE,
			TRIM(comm.REV_LOCN),
			MARTY,
			PETER,
			FRANK,
			BOB,
			MARY,
			KATE,
			OTHER,
			comm.SPLIT1,
			comm.SPLIT2,
			comm.SPLIT3,
			comm.SPLIT4,
			comm.SPLIT5,
			comm.SPLIT6		
		FROM COMM comm
		WHERE comm.KEYNUMO > 0
			AND comm.KEYNUMO NOT IN(SELECT KEYNUMO FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorSix
		FETCH NEXT FROM db_cursorSix INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, 
		@commissionPeter,
		@commissionFrank, 
		@commissionBob, 
		@commissionMary,
		@commissionKate, 
		@commissionOther, 
		@splitMarty,
		@splitPeter,
		@splitFrank,
		@splitBob,
		@splitMary,
		@splitKate

		WHILE @@fetch_status = 0
		BEGIN
			INSERT INTO [dbo].[Commission]
			(
				CommissionType,
				YearMonth,
				PayDate,
				PolicyId,
				Premium,
				RenewalType,
				Total,
				IsDeleted,
				CreatedDate,
				CreatedBy,
				ModifiedDate,
				ModifiedBy
			)
			VALUES
			(
				@commissionType,
				@yearMonth,
				@payDate,
				@policyId,
				@premium,
				@renewalType,
				@total,
				@isDeleted,
				@createdDate,
				@createdBy,
				@modifiedDate,
				@modifiedBy
			)

		
			SET @commissionId = SCOPE_IDENTITY()
			IF (@commissionMarty > 0 OR @splitMarty > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMarty, @commissionId, @commissionMarty, @splitMarty, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionPeter > 0 OR @splitPeter > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentPeter, @commissionId, @commissionPeter, @splitPeter, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END

			IF (@commissionFrank > 0 OR @splitFrank > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentFrank , @commissionId, @commissionFrank , @splitFrank , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionBob > 0 OR @splitBob > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentBob , @commissionId, @commissionBob , @splitBob , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionMary > 0 OR @splitMary > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentMary , @commissionId, @commissionMary , @splitMary , @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionKate > 0 OR @splitKate > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentKate, @commissionId, @commissionKate, @splitKate, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END
	
			IF (@commissionOther > 0)
			BEGIN
				INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
				VALUES ( @agentOthers, @commissionId, @commissionOther, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
			END		
	
			FETCH NEXT FROM db_cursorSix INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, 
			@commissionPeter,
			@commissionFrank, 
			@commissionBob, 
			@commissionMary,
			@commissionKate, 
			@commissionOther, 
			@splitMarty,
			@splitPeter,
			@splitFrank,
			@splitBob,
			@splitMary,
			@splitKate

		END

	CLOSE db_cursorSix

	DEALLOCATE db_cursorSix
END