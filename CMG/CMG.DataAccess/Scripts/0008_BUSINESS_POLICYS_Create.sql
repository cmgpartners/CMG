IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.BUSINESS_POLICYS') AND TYPE = N'U')
BEGIN
CREATE TABLE [dbo].[BUSINESS_POLICYS](
	[KEYNUM] [int] NOT NULL,
	[KEYNUMO] [int] NOT NULL,
	[CATGRY] [char](1) NOT NULL,
	[BUS] [bit] NOT NULL,
	[HNAME] [varchar](35) NOT NULL,
	[KEYNUMB] [int] NOT NULL,
	[RELATN] [char](10) NOT NULL,
	[REV_LOCN] [varchar](50) NOT NULL,
	[REV_DATE] [datetime] NOT NULL,
	[CR8_LOCN] [varchar](50) NOT NULL,
	[CR8_DATE] [datetime] NOT NULL,
	[DEL_] [bit] NOT NULL,
	[split] [numeric](5, 2) NULL,
	[Hsplit] [numeric](5, 2) NOT NULL,
	[Salesforce_Id] [char](18) NULL,
	[EMAILC]  AS ([dbo].[FUNC_Cinfo]([keynumb],[bus],'A.EMAIL')),
	[DPHONEBUSC]  AS ([dbo].[FUNC_Cinfo]([keynumb],[bus],'A.DPHONEBUS')),
	[PHONEBUSC]  AS ([dbo].[FUNC_Cinfo]([keynumb],[bus],'C.PHONEBUS')),
	[DPHONEEXTC]  AS ([dbo].[FUNC_Cinfo]([keynumb],[bus],'B.DPHONEEXT')),
	[islinked]  AS ([dbo].[FUNC_linkpol]([keynumb],[bus])),
	[hnamec]  AS ([dbo].[FUNC_hname]([keynumb],[bus],[hname],(5))),
 CONSTRAINT [PK_BUSINESS_POLICYS] PRIMARY KEY NONCLUSTERED 
(
	[KEYNUM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



END

