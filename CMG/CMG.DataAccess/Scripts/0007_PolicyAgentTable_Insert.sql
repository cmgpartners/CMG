IF NOT EXISTS(SELECT TOP 1 * FROM PolicyAgent)
BEGIN

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

	-- Policies Table
	DECLARE @keynumo INT
	DECLARE @policynumber VARCHAR(15)
	DECLARE @agent1 CHAR(3)
	DECLARE @agent2 CHAR(3)
	DECLARE @agent3 CHAR(3)
	DECLARE @agent4 CHAR(3)
	DECLARE @agent5 CHAR(3)
	DECLARE @agent6 CHAR(3)
	DECLARE @split1 NUMERIC(5,2)
	DECLARE @split2 NUMERIC(5,2)
	DECLARE @split3 NUMERIC(5,2)
	DECLARE @split4 NUMERIC(5,2)
	DECLARE @split5 NUMERIC(5,2)
	DECLARE @split6 NUMERIC(5,2)
	DECLARE @modifiedBy VARCHAR(50)
	DECLARE @modifiedDate DATETIME
	DECLARE @createdDate DATETIME
	DECLARE @createdBy VARCHAR(50)
	
	DECLARE @i INT
	DECLARE @commissionId INT

	DECLARE @tmpPolicyAgent TABLE
	(
		KEYNUMO int,
		PolicyNumber VARCHAR(50),
		ModifiedDate DATETIME,
		ModifiedBy VARCHAR(50),
		CreatedDate DATETIME,
		CreatedBy VARCHAR(50)
	)
	
	DECLARE db_cursorOne CURSOR FOR
		SELECT
			KEYNUMO,
			AGENT1,
			AGENT2,
			AGENT3,
			AGENT4,
			AGENT5,
			AGENT6,
			SPLIT1,
			SPLIT2,
			SPLIT3,
			SPLIT4,
			SPLIT5,
			SPLIT6,
			REV_LOCN,
			REV_DATE,
			CR8_DATE,
			CR8_LOCN
		FROM POLICYS
		WHERE TRIM(AGENT1) <> ''
			OR TRIM(AGENT2) <> ''
			OR TRIM(AGENT3) <> ''
			OR TRIM(AGENT4) <> ''
			OR TRIM(AGENT5) <> ''

	OPEN db_cursorOne
		FETCH NEXT FROM db_cursorOne INTO @keynumo, @agent1, @agent2, @agent3, @agent4, @agent5, @agent6, @split1, @split2, @split3, @split4, @split5, @split6, 
				@modifiedBy, @modifiedDate, @createdDate, @createdBy

		WHILE @@fetch_status = 0
		BEGIN
			SET @i = 0	
			-- Check Agent1
			IF (TRIM(@agent1) != '')
			BEGIN
				IF (TRIM(@agent1) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent1) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent1) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent1) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent1) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent1) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			IF (TRIM(@agent2) != '')
			BEGIN
				IF (TRIM(@agent2) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent2) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent2) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			IF (TRIM(@agent3) != '')
			BEGIN
				IF (TRIM(@agent3) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent3) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent3) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			IF (TRIM(@agent4) != '')
			BEGIN
				IF (TRIM(@agent4) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent4) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent4) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			IF (TRIM(@agent5) != '')
			BEGIN
				IF (TRIM(@agent5) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent5) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent5) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			IF (TRIM(@agent6) != '')
			BEGIN
				IF (TRIM(@agent6) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMarty, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent6) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent6) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent6) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent6) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent6) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END
		FETCH NEXT FROM db_cursorOne INTO @keynumo, @agent1, @agent2, @agent3, @agent4, @agent5, @agent6, @split1, @split2, @split3, @split4, @split5, @split6, 
				@modifiedBy, @modifiedDate, @createdDate, @createdBy
		END
	CLOSE db_cursorOne
	DEALLOCATE db_cursorOne
	

	INSERT INTO @tmpPolicyAgent
	(
		KEYNUMO, 
		PolicyNumber,
		ModifiedDate, 
		ModifiedBy, 
		CreatedDate, 
		CreatedBy
	)
	SELECT
		KEYNUMO,
		POLICYNUM,
		REV_DATE,
		REV_LOCN,
		CR8_DATE,
		CR8_LOCN
	FROM POLICYS
	WHERE TRIM(AGENT1) = ''
		AND TRIM(AGENT2) = ''
		AND TRIM(AGENT3) = ''
		AND TRIM(AGENT4) = ''
		AND TRIM(AGENT5) = ''	
		AND KEYNUMO in(SELECT PolicyId FROM Commission)

	DECLARE db_cursorTwo CURSOR FOR
	SELECT
		KEYNUMO,
		ModifiedDate,
		ModifiedBy,
		CreatedDate,
		CreatedBy
	FROM @tmpPolicyAgent
	WHERE KEYNUMO in(select KEYNUMO FROM COMM)
	-- 107 RECORDS
	OPEN db_cursorTwo
		FETCH NEXT FROM db_cursorTwo INTO @keynumo, @modifiedDate, @modifiedBy, @createdDate, @createdBy
		WHILE @@fetch_status = 0
		BEGIN
			SET @i = 0	
			SELECT TOP 1 
				@commissionId = KEYCOMM,
				@agent1 = AGENT1,
				@agent2 = AGENT2,
				@agent3 = AGENT3,
				@agent4 = AGENT4,
				@agent5 = AGENT5,
				@agent6 = AGENT6,
				@split1 = SPLIT1,
				@split2 = SPLIT2,
				@split3 = SPLIT3,
				@split4 = SPLIT4,
				@split5 = SPLIT5,
				@split6 = SPLIT6
			FROM Comm WHERE KEYNUMO = @keynumo ORDER BY PayDate, YRMO DESC
			IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Agent 1
				IF (TRIM(@agent1) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				-- Agent 2
				IF (TRIM(@agent2) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			
				-- Agent 3
				IF (TRIM(@agent3) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			
				-- Agent 4
				IF (TRIM(@agent4) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END			
			
				-- Agent 5
				IF (TRIM(@agent5) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END			
			
				-- Agent 6
				IF (TRIM(@agent6) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END
			FETCH NEXT FROM db_cursorTwo INTO @keynumo, @modifiedDate, @modifiedBy, @createdDate, @createdBy
		END
	CLOSE db_cursorTwo
	DEALLOCATE db_cursorTwo


	DECLARE db_cursorThree CURSOR FOR
	SELECT
		KEYNUMO,
		PolicyNumber,
		ModifiedDate,
		ModifiedBy,
		CreatedDate,
		CreatedBy
	FROM @tmpPolicyAgent
	WHERE KEYNUMO not in(select KEYNUMO FROM COMM)
	-- 4 RECORDS
	OPEN db_cursorThree
		FETCH NEXT FROM db_cursorThree INTO @keynumo, @policyNumber, @modifiedDate, @modifiedBy, @createdDate, @createdBy
		WHILE @@fetch_status = 0
		BEGIN
			SET @i = 0	
			SELECT TOP 1 
				@commissionId = KEYCOMM,
				@agent1 = AGENT1,
				@agent2 = AGENT2,
				@agent3 = AGENT3,
				@agent4 = AGENT4,
				@agent5 = AGENT5,
				@agent6 = AGENT6,
				@split1 = SPLIT1,
				@split2 = SPLIT2,
				@split3 = SPLIT3,
				@split4 = SPLIT4,
				@split5 = SPLIT5,
				@split6 = SPLIT6
			FROM Comm WHERE POLICYNUM = @policyNumber ORDER BY PayDate, YRMO DESC
			IF (TRIM(@agent1) != '' OR TRIM(@agent2) != '' OR TRIM(@agent3) != '' OR TRIM(@agent4) != '' OR TRIM(@agent5) != '' OR TRIM(@agent6) = '' )
			BEGIN
				-- Agent 1
				IF (TRIM(@agent1) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				-- Agent 2
				IF (TRIM(@agent2) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			
				-- Agent 3
				IF (TRIM(@agent3) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			
				-- Agent 4
				IF (TRIM(@agent4) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END			
			
				-- Agent 5
				IF (TRIM(@agent5) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END			
			
				-- Agent 6
				IF (TRIM(@agent6) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMarty, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentPeter, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentFrank, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentBob, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentMary, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES( @keynumo, @agentKate, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END
			FETCH NEXT FROM db_cursorThree INTO @keynumo, @policyNumber, @modifiedDate, @modifiedBy, @createdDate, @createdBy
		END
	CLOSE db_cursorThree
	DEALLOCATE db_cursorThree

END