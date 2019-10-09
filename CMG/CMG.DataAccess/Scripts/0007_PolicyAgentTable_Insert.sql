IF NOT EXISTS(SELECT TOP 1 * FROM PolicyAgent)
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

				ELSE IF (TRIM(@agent1) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				ELSE IF (TRIM(@agent1) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				ELSE IF (TRIM(@agent1) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent1) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent2
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
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent2) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent3
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
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent3) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent4
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
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent4) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent5
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
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent5) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent6
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
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent6) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentCMG, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentOthers, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentDean, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentEdward, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentGAS, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentJohn, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentKirk, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentLawrance, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPeterEmerson, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPhil, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentPaul, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentRC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTIC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTom, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent6) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keynumo, @agentTP, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
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
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMarty, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent2
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent3
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent4
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent5
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent6
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
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
				-- Check Agent1
				IF (TRIM(@agent1) != '')
				BEGIN
					IF (TRIM(@agent1) = @agentCodeMarty)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMarty, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeter)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeter, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeFrank)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentFrank, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeBob)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentBob, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeMary)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					ELSE IF (TRIM(@agent1) = @agentCodeKate)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentMary, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent1) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent1) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split1, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent2
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent2) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent2) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split2, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent3
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent3) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent3) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split3, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent4
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent4) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent4) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split4, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent5
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent5) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent5) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split5, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END

				-- Check Agent6
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
				
					-- ***** NEW AGENTS *****
					ELSE IF (TRIM(@agent6) = @agentCodeCMG)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentCMG, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeOthers)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentOthers, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeDean)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentDean, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeEdward)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentEdward, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeGAS)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentGAS, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeJohn)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentJohn, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeKirk)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentKirk, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeLawrance)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentLawrance, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePeterEmerson)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPeterEmerson, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePhil)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPhil, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodePaul)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentPaul, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeRC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentRC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTIC)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTIC, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTom)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTom, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END

					ELSE IF (TRIM(@agent6) = @agentCodeTP)
					BEGIN
						SET @i = @i + 1					
						INSERT INTO PolicyAgent ( PolicyId, AgentId, Split, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
						VALUES ( @keynumo, @agentTP, @split6, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
					END
				END
			END
			FETCH NEXT FROM db_cursorThree INTO @keynumo, @policyNumber, @modifiedDate, @modifiedBy, @createdDate, @createdBy
		END
	CLOSE db_cursorThree
	DEALLOCATE db_cursorThree

END