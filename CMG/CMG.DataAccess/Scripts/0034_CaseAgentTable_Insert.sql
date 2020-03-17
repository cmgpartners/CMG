IF NOT EXISTS(SELECT TOP 1 * FROM CaseAgent)
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
	SET @agentCodeKate = 'KAM'

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

	-- Case Table
	DECLARE @keycase INT
	DECLARE @agent1 CHAR(3)
	DECLARE @agent2 CHAR(3)
	DECLARE @agent3 CHAR(3)
	DECLARE @agent4 CHAR(3)
	DECLARE @agent5 CHAR(3)
	DECLARE @modifiedBy VARCHAR(50)
	DECLARE @modifiedDate DATETIME
	DECLARE @createdDate DATETIME
	DECLARE @createdBy VARCHAR(50)
	
	DECLARE @i INT
	DECLARE @caseId INT

	DECLARE db_cursorOne CURSOR FOR
		SELECT
			KEYCASE,
			AGENT1,
			AGENT2,
			AGENT3,
			AGENT4,
			AGENT5,
			REV_LOCN,
			REV_DATE,
			CR8_DATE,
			CR8_LOCN
		FROM CASES
		WHERE TRIM(AGENT1) <> ''
			OR TRIM(AGENT2) <> ''
			OR TRIM(AGENT3) <> ''
			OR TRIM(AGENT4) <> ''
			OR TRIM(AGENT5) <> ''

	OPEN db_cursorOne
		FETCH NEXT FROM db_cursorOne INTO @keycase, @agent1, @agent2, @agent3, @agent4, @agent5,
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
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMarty, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeter, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentFrank, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentBob, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				ELSE IF (TRIM(@agent1) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				ELSE IF (TRIM(@agent1) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent1) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentCMG, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentOthers, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentDean, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentEdward, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentGAS, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentJohn, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentKirk, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentLawrance, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeterEmerson, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPhil, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPaul, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentRC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTIC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTom, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent1) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTP, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent2
			IF (TRIM(@agent2) != '')
			BEGIN
				IF (TRIM(@agent2) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMarty, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeter, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentFrank, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent2) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentBob, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent2) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent2) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent2) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentCMG, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentOthers, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentDean, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentEdward, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentGAS, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentJohn, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentKirk, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentLawrance, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeterEmerson, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPhil, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPaul, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentRC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTIC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTom, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent2) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTP, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent3
			IF (TRIM(@agent3) != '')
			BEGIN
				IF (TRIM(@agent3) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMarty, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeter, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentFrank, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent3) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentBob, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent3) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent3) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent3) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentCMG, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentOthers, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentDean, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentEdward, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentGAS, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentJohn, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentKirk, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentLawrance, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeterEmerson, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPhil, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPaul, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentRC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTIC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTom, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent3) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTP, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent4
			IF (TRIM(@agent4) != '')
			BEGIN
				IF (TRIM(@agent4) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMarty, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeter, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentFrank, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent4) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentBob, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent4) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent4) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent4) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentCMG, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentOthers, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentDean, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentEdward, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentGAS, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentJohn, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentKirk, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentLawrance, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeterEmerson, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPhil, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPaul, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentRC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTIC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTom, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent4) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTP, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END

			-- Check Agent5
			IF (TRIM(@agent5) != '')
			BEGIN
				IF (TRIM(@agent5) = @agentCodeMarty)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMarty, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodePeter)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeter, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodeFrank)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentFrank, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				IF (TRIM(@agent5) = @agentCodeBob)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentBob, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent5) = @agentCodeMary)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				IF (TRIM(@agent5) = @agentCodeKate)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentMary, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
				
				-- ***** NEW AGENTS *****
				ELSE IF (TRIM(@agent5) = @agentCodeCMG)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentCMG, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeOthers)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentOthers, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeDean)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentDean, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeEdward)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentEdward, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeGAS)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentGAS, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeJohn)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentJohn, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeKirk)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentKirk, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeLawrance)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentLawrance, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePeterEmerson)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPeterEmerson, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePhil)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPhil, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodePaul)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentPaul, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeRC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentRC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTIC)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTIC, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTom)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTom, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END

				ELSE IF (TRIM(@agent5) = @agentCodeTP)
				BEGIN
					SET @i = @i + 1					
					INSERT INTO CaseAgent ( CaseId, AgentId, AgentOrder, IsDeleted, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy )
					VALUES ( @keycase, @agentTP, @i, 0, @createdDate, @createdBy, @modifiedDate, @modifiedBy)
				END
			END
		FETCH NEXT FROM db_cursorOne INTO @keycase, @agent1, @agent2, @agent3, @agent4, @agent5, 
				@modifiedBy, @modifiedDate, @createdDate, @createdBy
		END
	CLOSE db_cursorOne
	DEALLOCATE db_cursorOne
END