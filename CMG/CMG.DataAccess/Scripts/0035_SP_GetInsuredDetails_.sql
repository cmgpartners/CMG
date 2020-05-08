/****** Object:  StoredProcedure [dbo].[SP_GetInsuredDetails]    Script Date: 4/29/2020 10:05:32 AM ******/
IF EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.SP_GetInsuredDetails') AND Type IN ( N'P', N'PC' ))
BEGIN
	DROP PROCEDURE [dbo].[SP_GetInsuredDetails]
END
GO

CREATE PROCEDURE [dbo].[SP_GetInsuredDetails](@policyId int)
AS
BEGIN
	DECLARE @InsuredName VARCHAR(250);

	SELECT @InsuredName = INSUR FROM POLICYS WHERE KEYNUMO = @policyId 
	
	SELECT * From PEOPLE WHERE KEYNUMP IN 
	(
		SELECT 
			CASE 
				WHEN (SELECT [dbo].[f_IOB](@policyId,73,0,0)) = @InsuredName THEN KEYNUMP
			END 
		FROM PEOPLE_POLICYS
		WHERE KEYNUMO = @policyId
		AND CATGRY = 'I'
	)
END
GO


