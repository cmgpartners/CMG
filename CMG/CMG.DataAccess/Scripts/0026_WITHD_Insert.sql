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

IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Personal Commission Entered')
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
		'Personal Commission Entered',
		'CM\Rishita',
		GETDATE()
	)
END

IF NOT EXISTS(SELECT TOP 1 * FROM COMBO WHERE DESC_ LIKE 'Personal Commission Not Entered')
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
		'N',
		'Personal Commission Not Entered',
		'CM\Rishita',
		GETDATE()
	)
END
