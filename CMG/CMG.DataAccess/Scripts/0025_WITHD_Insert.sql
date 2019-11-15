IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Loan')
BEGIN
	INSERT INTO COMBO
	(
		FIELDNAME,
		FLDCODE,
		DESC_,
		REV_LOCN,
		REV_DATE
	)
	VALUES
	(
		'DTYPE',
		'L',
		'Loan',
		'CM\Rishita',
		GETDATE()
	)
END

IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Withdrawal')
BEGIN
	INSERT INTO COMBO
	(
		FIELDNAME,
		FLDCODE,
		DESC_,
		REV_LOCN,
		REV_DATE
	)
	VALUES
	(
		'DTYPE',
		'W',
		'Withdrawal',
		'CM\Rishita',
		GETDATE()
	)
END

IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Bank Position')
BEGIN
	INSERT INTO COMBO
	(
		FIELDNAME,
		FLDCODE,
		DESC_,
		REV_LOCN,
		REV_DATE
	)
	VALUES
	(
		'DTYPE',
		'B',
		'Bank Position',
		'CM\Rishita',
		GETDATE()
	)
END

IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Personal Commission')
BEGIN
	INSERT INTO COMBO
	(
		FIELDNAME,
		FLDCODE,
		DESC_,
		REV_LOCN,
		REV_DATE
	)
	VALUES
	(
		'DTYPE',
		'P',
		'Personal Commission',
		'CM\Rishita',
		GETDATE()
	)
END