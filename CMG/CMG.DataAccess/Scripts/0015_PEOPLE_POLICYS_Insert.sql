IF NOT EXISTS(SELECT TOP 1 * FROM PEOPLE_POLICYS)
BEGIN
	--Matched KEYNUMB
	INSERT INTO [dbo].[PEOPLE_POLICYS]
	(
		KEYNUML,
		KEYNUMO,
		CATGRY,
		BUS,
		HNAME,
		KEYNUMP,
		RELATN,
		REV_LOCN,
		REV_DATE,
		CR8_LOCN,
		CR8_DATE,
		DEL_,
		split,
		Hsplit,
		Salesforce_Id
	)
	SELECT 
		KEYNUML,
		KEYNUMO,
		CATGRY,
		BUS,
		HNAME,
		KEYNUMBP,
		RELATN,
		REV_LOCN,
		REV_DATE,
		CR8_LOCN,
		CR8_DATE,
		DEL_,
		split,
		Hsplit,
		Salesforce_Id
	FROM PEO_POL 
	WHERE KEYNUMBP IN (SELECT KEYNUMP FROM PEOPLE) 
		AND BUS = 0 
		AND KEYNUMBP <> 0

	-- Zero KEYNUMB
	INSERT INTO [dbo].[PEOPLE_POLICYS]
	(
		KEYNUML,
		KEYNUMO,
		CATGRY,
		BUS,
		HNAME,
		KEYNUMP,
		RELATN,
		REV_LOCN,
		REV_DATE,
		CR8_LOCN,
		CR8_DATE,
		DEL_,
		split,
		Hsplit,
		Salesforce_Id
	)
	SELECT 
		KEYNUML,
		KEYNUMO,
		CATGRY,
		BUS,
		HNAME,
		KEYNUMBP,
		RELATN,
		REV_LOCN,
		REV_DATE,
		CR8_LOCN,
		CR8_DATE,
		DEL_,
		split,
		Hsplit,
		Salesforce_Id
	FROM PEO_POL 
	WHERE KEYNUMBP = 0 
		ANd BUS = 0
END