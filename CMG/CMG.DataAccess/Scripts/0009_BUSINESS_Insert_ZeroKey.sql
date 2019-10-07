ALTER TABLE [BUSINESS] DROP CONSTRAINT IF EXISTS CK_BUSINESS;
GO
IF NOT EXISTS(SELECT TOP 1 * FROM BUSINESS WHERE KEYNUMB = 0)
BEGIN
INSERT INTO [dbo].[BUSINESS]
           ([KEYNUMB]
           ,[BUSNAME]
           ,[PARNAME]
           ,[BSTREET]
           ,[BCITY]
           ,[BPROV]
           ,[BPOSTALCOD]
           ,[PHONEBUS]
           ,[PHONEFAX]
           ,[BPHONEOTH]
           ,[BOTHTYPE]
           ,[PROD_TYPE]
           ,[SIC1]
           ,[SIC2]
           ,[SIC3]
           ,[SIC4]
           ,[DUNSNO]
           ,[BNOTES]
           ,[BFOREIGN]
           ,[BPUBLIC]
           ,[CLIENTDIR]
           ,[YEAREND]
           ,[FYEAR]
           ,[FYEAR2]
           ,[FYEAR3]
           ,[FYEAR4]
           ,[FYEAR5]
           ,[ANNSALES]
           ,[ANNSALES2]
           ,[ANNSALES3]
           ,[ANNSALES4]
           ,[ANNSALES5]
           ,[NUM_EMPL]
           ,[NUM_EMPL2]
           ,[NUM_EMPL3]
           ,[NUM_EMPL4]
           ,[NUM_EMPL5]
           ,[ANNPROFIT]
           ,[ANNPROFIT2]
           ,[ANNPROFIT3]
           ,[ANNPROFIT4]
           ,[ANNPROFIT5]
           ,[MARKETVAL]
           ,[MARKETVAL2]
           ,[MARKETVAL3]
           ,[MARKETVAL4]
           ,[MARKETVAL5]
           ,[BOOKVAL]
           ,[BOOKVAL2]
           ,[BOOKVAL3]
           ,[BOOKVAL4]
           ,[BOOKVAL5]
           ,[REV_LOCN]
           ,[REV_DATE]
           ,[CR8_LOCN]
           ,[CR8_DATE]
           ,[WEBSITE]
           ,[DEL_]
           ,[MAPID]
           ,[SUMM_POLC]
           ,[Salesforce_Id])
     VALUES
          (
			0
			,'Primary Key Zero'
			,'Primary Key Zero'
			,'Primary Key Zero'
			,'Concord'
			,'ON'
			,'L4K 4R1'
			,'9056956829'
			,''
			,''
			,''
			,'Primary Key Zero'
			,''
			,''
			,''
			,''
			,''
			,'Inserted Zero Key to apply FK on BUSINESS_POLICYS table'
			,0
			,0
			,''
			,''
			,0
			,0
			,0
			,0
			,0
			,10000000
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,0
			,'CM\Juliana'
			,'2018-08-27 10:02:57.000'
			,'CM\Juliana'
			,'2016-07-18 14:28:35.000'
			,'http://www.ozzsolar.com/'
			,0
			,'V-113-F-5'
			,0
			,''   
		  )
END


