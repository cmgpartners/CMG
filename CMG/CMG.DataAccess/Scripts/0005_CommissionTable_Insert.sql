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

	DECLARE @agentCodePeter VARCHAR(5)
	SET @agentCodePeter = 'PFC'

	DECLARE @agentCodeFrank VARCHAR(5)
	SET @agentCodeFrank = 'FAC'

	DECLARE @agentCodeBob VARCHAR(5)
	SET @agentCodeBob = 'RRG'

	DECLARE @agentCodeMary VARCHAR(5)
	SET @agentCodeMary = 'MEM'

	DECLARE @agentCodeKate VARCHAR(5)
	SET @agentCodeKate = 'KAC'

	DECLARE @agentCodeMarty VARCHAR(5)
	SET @agentCodeMarty = 'MJM'

	DECLARE @agentCommission FLOAT
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
	DECLARE @agent1 VARCHAR(5)
	DECLARE @agent2 VARCHAR(5)
	DECLARE @agent3 VARCHAR(5)
	DECLARE @agent4 VARCHAR(5)
	DECLARE @agent5 VARCHAR(5)
	DECLARE @agent6 VARCHAR(5)

	DECLARE @split1 FLOAT
	DECLARE @split2 FLOAT
	DECLARE @split3 FLOAT
	DECLARE @split4 FLOAT
	DECLARE @split5 FLOAT
	DECLARE @split6 FLOAT

	-- AgentCommission Table
	DECLARE @agentId INT
	DECLARE @commissionId INT
	DECLARE @commission FLOAT
	DECLARE @split FLOAT
	DECLARE @createdBy VARCHAR(50)
	DECLARE @createdDate DATETIME
	DECLARE @modifiedBy VARCHAR(50)
	DECLARE @modifiedDate DATETIME
	DECLARE @i INT

	DECLARE @temp TABLE
	(
		Amount FLOAT
	)
	
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
		comm.AGENT1,
		comm.AGENT2,
		comm.AGENT3,
		comm.AGENT4,
		comm.AGENT5,
		comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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
			
			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				--DECLARE @agentCommission FLOAT
				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END	
			
			FETCH NEXT FROM db_cursorOne INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6

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
			comm.AGENT1,
			comm.AGENT2,
			comm.AGENT3,
			comm.AGENT4,
			comm.AGENT5,
			comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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

			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END	
			FETCH NEXT FROM db_cursorTwo INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6

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
			comm.AGENT1,
			comm.AGENT2,
			comm.AGENT3,
			comm.AGENT4,
			comm.AGENT5,
			comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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

			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				--DECLARE @agentCommission FLOAT
				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END
			FETCH NEXT FROM db_cursorThree INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6
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
			comm.AGENT1,
			comm.AGENT2,
			comm.AGENT3,
			comm.AGENT4,
			comm.AGENT5,
			comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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

			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				--DECLARE @agentCommission FLOAT
				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END		
			
			FETCH NEXT FROM db_cursorFour INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6

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
			comm.AGENT1,
			comm.AGENT2,
			comm.AGENT3,
			comm.AGENT4,
			comm.AGENT5,
			comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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

			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				--DECLARE @agentCommission FLOAT
				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END
			FETCH NEXT FROM db_cursorFive INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6

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
			comm.AGENT1,
			comm.AGENT2,
			comm.AGENT3,
			comm.AGENT4,
			comm.AGENT5,
			comm.AGENT6,
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
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6

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

			SET @i = 0
			SET @commissionId = SCOPE_IDENTITY()
			
			-- Check if agent code is null to set up priority
			IF (TRIM(@agent1) = '' AND TRIM(@agent2) = '' AND TRIM(@agent3) = '' AND TRIM(@agent4) = '' AND TRIM(@agent5) = '' AND TRIM(@agent6) = '' )
			BEGIN
				INSERT INTO @temp VALUES(@commissionMarty) 
				INSERT INTO @temp VALUES(@commissionPeter) 
				INSERT INTO @temp VALUES(@commissionFrank) 
				INSERT INTO @temp VALUES(@commissionBob) 
				INSERT INTO @temp VALUES(@commissionMary) 
				INSERT INTO @temp VALUES(@commissionKate) 

				--DECLARE @agentCommission FLOAT
				DECLARE cursor_temp CURSOR FOR
				SELECT Amount FROM @temp ORDER BY Amount DESC
				OPEN cursor_temp

				FETCH NEXT FROM cursor_temp INTO @agentCommission
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF (@agentCommission <> 0)
					BEGIN
						IF (@agentCommission = @commissionMarty)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
						END
					END
					FETCH NEXT FROM cursor_temp INTO @agentCommission
				END
				CLOSE cursor_temp
				DEALLOCATE cursor_temp
				DELETE FROM @temp
			END

			ELSE IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter AND (@commissionPeter <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob AND (@commissionBob <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary AND (@commissionMary <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate AND (@commissionKate <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent2
				IF (TRIM(@agent2) != '')
				BEGIN
					IF (TRIM(@agent2) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeter AND (@commissionPeter <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent2) = @agentCodeBob AND (@commissionBob <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeMary AND (@commissionMary <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent2) = @agentCodeKate AND (@commissionKate <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent3
				IF (TRIM(@agent3) != '')
				BEGIN
					IF (TRIM(@agent3) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeter AND (@commissionPeter <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent3) = @agentCodeBob AND (@commissionBob <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeMary AND (@commissionMary <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent3) = @agentCodeKate AND (@commissionKate <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent4
				IF (TRIM(@agent4) != '')
				BEGIN
					IF (TRIM(@agent4) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeter AND (@commissionPeter <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent4) = @agentCodeBob AND (@commissionBob <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeMary AND (@commissionMary <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent4) = @agentCodeKate AND (@commissionKate <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent5
				IF (TRIM(@agent5) != '')
				BEGIN
					IF (TRIM(@agent5) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeter AND (@commissionpeter <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeFrank AND (@commissionFrank<> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent5) = @agentCodeBob AND (@commissionBob <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeMary AND (@commissionMary <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent5) = @agentCodeKate AND (@commissionKate <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END

				-- Check Agent6
				IF (TRIM(@agent6) != '')
				BEGIN
					IF (TRIM(@agent6) = @agentCodeMarty AND (@commissionMarty <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMarty, @commissionId, @commissionMarty, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeter AND (@commissionPeter <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeter, @commissionId, @commissionPeter, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeFrank AND (@commissionFrank <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentFrank, @commissionId, @commissionFrank, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					ELSE IF (TRIM(@agent6) = @agentCodeBob AND (@commissionBob <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentBob, @commissionId, @commissionBob, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeMary AND (@commissionMary <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentMary, @commissionId, @commissionMary, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				
					ELSE IF (TRIM(@agent6) = @agentCodeKate AND (@commissionKate <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKate, @commissionId, @commissionKate, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END	
			END
			FETCH NEXT FROM db_cursorSix INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6

		END

	CLOSE db_cursorSix
	DEALLOCATE db_cursorSix
	
END