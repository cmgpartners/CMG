IF NOT EXISTS(SELECT TOP 1 * FROM Commission)
BEGIN
	DECLARE @policyNumberMisc INT
	SET @policyNumberMisc = 7825

	DECLARE @PolicyNumberRollUp INT
	SET @PolicyNumberRollUp = 7824

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

	DECLARE @agentDean INT
	SET @agentDean = 9
	DECLARE @agentCodeDean VARCHAR(5)
	SET @agentCodeDean = 'DRF'
	
	DECLARE @agentEdward INT
	SET @agentEdward = 10
	DECLARE @agentCodeEdward VARCHAR(5)
	SET @agentCodeEdward = 'EJM'
	
	DECLARE @agentGAS INT
	SET @agentGAS = 11
	DECLARE @agentCodeGAS VARCHAR(5)
	SET @agentCodeGAS = 'GAS'
	
	DECLARE @agentJohn INT
	SET @agentJohn = 12
	DECLARE @agentCodeJohn VARCHAR(5)
	SET @agentCodeJohn = 'JEM'
	
	DECLARE @agentKirk INT
	SET @agentKirk = 13
	DECLARE @agentCodeKirk VARCHAR(5)
	SET @agentCodeKirk = 'JKP'
	
	DECLARE @agentLawrance INT
	SET @agentLawrance = 14
	DECLARE @agentCodeLawrance VARCHAR(5)
	SET @agentCodeLawrance = 'LIG'
	
	DECLARE @agentPeterEmerson INT
	SET @agentPeterEmerson = 15
	DECLARE @agentCodePeterEmerson VARCHAR(5)
	SET @agentCodePeterEmerson = 'PE'
	
	DECLARE @agentPhil INT
	SET @agentPhil = 16
	DECLARE @agentCodePhil VARCHAR(5)
	SET @agentCodePhil = 'PJB'

	DECLARE @agentPaul INT
	SET @agentPaul = 17
	DECLARE @agentCodePaul VARCHAR(5)
	SET @agentCodePaul = 'PMT'

	DECLARE @agentRC INT
	SET @agentRC = 18
	DECLARE @agentCodeRC VARCHAR(5)
	SET @agentCodeRC = 'RC'
	
	DECLARE @agentTIC INT
	SET @agentTIC = 19
	DECLARE @agentCodeTIC VARCHAR(5)
	SET @agentCodeTIC = 'TIC'

	DECLARE @agentTom INT
	SET @agentTom = 20
	DECLARE @agentCodeTom VARCHAR(5)
	SET @agentCodeTom = 'TM'
	
	DECLARE @agentTP INT
	SET @agentTP = 21
	DECLARE @agentCodeTP VARCHAR(5)
	SET @agentCodeTP = 'TP'

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
	DECLARE @insured VARCHAR(500)

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
		comm.SPLIT6,
		comm.INSURED
	FROM COMM comm
	INNER JOIN POLICYS plcy
		ON plcy.KEYNUMO = comm.KEYNUMO
	-- Inserted 19091 records above select

	OPEN db_cursorOne
		FETCH NEXT FROM db_cursorOne INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther) 

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END	
			
			FETCH NEXT FROM db_cursorOne INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
			comm.SPLIT6,
			comm.INSURED
		FROM COMM comm
		WHERE TRIM(comm.POLICYNUM) IN (SELECT TRIM(POLICYNUM) FROM POLICYS)
			AND comm.KEYNUMO = 0
			AND TRIM(comm.POLICYNUM) <> ''

	OPEN db_cursorTwo
		FETCH NEXT FROM db_cursorTwo INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther)

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
						
						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END	
			FETCH NEXT FROM db_cursorTwo INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
			comm.SPLIT6,
			comm.INSURED
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND TRIM(comm.POLICYNUM) = ''
	-- Inserted 19091 records above select
	
	OPEN db_cursorThree
		FETCH NEXT FROM db_cursorThree INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther) 

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END
			FETCH NEXT FROM db_cursorThree INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured
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
			comm.SPLIT6,
			comm.INSURED
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND insured LIKE '%Daneluzzi, Denise%'
			AND comm.POLICYNUM NOT IN (SELECT POLICYNUM FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorFour
		FETCH NEXT FROM db_cursorFour INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther) 

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END		
			
			FETCH NEXT FROM db_cursorFour INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
			comm.SPLIT6,
			comm.INSURED
		FROM COMM comm
		WHERE comm.KEYNUMO = 0
			AND insured <> 'Daneluzzi, Denise'
			AND comm.POLICYNUM NOT IN (SELECT POLICYNUM FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorFive
		FETCH NEXT FROM db_cursorFive INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther) 

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END
			FETCH NEXT FROM db_cursorFive INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
			comm.SPLIT6,
			comm.INSURED
		FROM COMM comm
		WHERE comm.KEYNUMO > 0
			AND comm.KEYNUMO NOT IN(SELECT KEYNUMO FROM POLICYS)
	-- Inserted 19091 records above select

	OPEN db_cursorSix
		FETCH NEXT FROM db_cursorSix INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
		@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
		@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
		@split1, @split2, @split3, @split4, @split5, @split6, @insured

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
				ModifiedBy,
				Insured
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
				@modifiedBy,
				@insured
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
				INSERT INTO @temp VALUES(@commissionOther) 

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
							VALUES ( @agentMarty, @commissionId, @commissionMarty, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionPeter)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentPeter, @commissionId, @commissionPeter, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionFrank)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentFrank, @commissionId, @commissionFrank, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionBob)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentBob, @commissionId, @commissionBob, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionMary)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentMary, @commissionId, @commissionMary, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END
					
						ELSE IF (@agentCommission = @commissionKate)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentKate, @commissionId, @commissionKate, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
						END

						ELSE IF (@agentCommission = @commissionOther)
						BEGIN
							SET @i = @i + 1
							INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
							VALUES ( @agentOthers, @commissionId, @commissionOther, 0, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy ) -- take 0 instead of @split1
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent1) = @agentCodeOthers AND (@commissionOther <> 0 OR @split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeDean AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeEdward AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeGAS AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeJohn AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeKirk AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeLawrance AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePhil AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodePaul AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeRC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent1) = @agentCodeTIC AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent1) = @agentCodeTom AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent1) = @agentCodeTP AND (@split1 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split1, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent2) = @agentCodeOthers AND (@commissionOther <> 0 OR @split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeDean AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeEdward AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeGAS AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeJohn AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeKirk AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeLawrance AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePhil AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodePaul AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeRC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent2) = @agentCodeTIC AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent2) = @agentCodeTom AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent2) = @agentCodeTP AND (@split2 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split2, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent3) = @agentCodeOthers AND (@commissionOther <> 0 OR @split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeDean AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeEdward AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeGAS AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeJohn AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeKirk AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeLawrance AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePhil AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodePaul AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeRC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent3) = @agentCodeTIC AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent3) = @agentCodeTom AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent3) = @agentCodeTP AND (@split3 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split3, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent4) = @agentCodeOthers AND (@commissionOther <> 0 OR @split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeDean AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeEdward AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeGAS AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeJohn AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeKirk AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeLawrance AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePhil AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodePaul AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeRC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent4) = @agentCodeTIC AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent4) = @agentCodeTom AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent4) = @agentCodeTP AND (@split4 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split4, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent5) = @agentCodeOthers AND (@commissionOther <> 0 OR @split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeDean AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeEdward AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeGAS AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeJohn AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeKirk AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeLawrance AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePhil AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodePaul AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeRC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent5) = @agentCodeTIC AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent5) = @agentCodeTom AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent5) = @agentCodeTP AND (@split5 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split5, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
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

					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentCMG, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END

					--***** OTHERS *****
					ELSE IF (TRIM(@agent6) = @agentCodeOthers AND (@commissionOther <> 0 OR @split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentOthers, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeDean AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentDean, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeEdward AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentEdward, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeGAS AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentGAS, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeJohn AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentJohn, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeKirk AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentKirk, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeLawrance AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentLawrance, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPeterEmerson, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePhil AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPhil, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodePaul AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentPaul, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeRC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentRC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
					
					ELSE IF (TRIM(@agent6) = @agentCodeTIC AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTIC, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END					
					
					ELSE IF (TRIM(@agent6) = @agentCodeTom AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTom, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END			
					
					ELSE IF (TRIM(@agent6) = @agentCodeTP AND (@split6 <> 0))
					BEGIN
						SET @i = @i + 1
						INSERT INTO [dbo].[AgentCommission] (AgentId, CommissionId, Commission, Split, AgentOrder, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @agentTP, @commissionId, @commissionOther, @split6, @i, @createdDate, @createdBy, @modifiedDate, @modifiedBy )
					END
				END
			END
			FETCH NEXT FROM db_cursorSix INTO @commissionType, @yearMonth, @payDate, @policyId, @premium, @renewalType, @total, @isDeleted, @createdDate, @createdBy, @modifiedDate, @modifiedBy, 
			@commissionMarty, @commissionPeter, @commissionFrank, @commissionBob, @commissionMary, @commissionKate, @commissionOther, 
			@agent1, @agent2, @agent3, @agent4, @agent5, @agent6, 
			@split1, @split2, @split3, @split4, @split5, @split6, @insured

		END

	CLOSE db_cursorSix
	DEALLOCATE db_cursorSix
	
END