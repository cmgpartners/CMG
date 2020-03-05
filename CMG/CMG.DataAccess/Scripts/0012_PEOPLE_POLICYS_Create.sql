IF NOT EXISTS(SELECT 1 FROM sys.Objects WHERE  Object_id = OBJECT_ID(N'dbo.PEOPLE_POLICYS') AND TYPE = N'U')
BEGIN
	CREATE TABLE [dbo].[PEOPLE_POLICYS](
	[KEYNUML] [int] NOT NULL,
	[KEYNUMO] [int] NOT NULL,
	[CATGRY] [char](1) NOT NULL,
	[BUS] [bit] NOT NULL,
	[HNAME] [varchar](35) NOT NULL,
	[KEYNUMP] [int] NOT NULL,
	[RELATN] [char](10) NOT NULL,
	[REV_LOCN] [varchar](50) NOT NULL,
	[REV_DATE] [datetime] NOT NULL,
	[CR8_LOCN] [varchar](50) NOT NULL,
	[CR8_DATE] [datetime] NOT NULL,
	[DEL_] [bit] NOT NULL,
	[split] [numeric](5, 2) NULL,
	[Hsplit] [numeric](5, 2) NOT NULL,
	[Salesforce_Id] [char](18) NULL,
	[EMAILC]  AS ([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'A.EMAIL')),
	[DPHONEBUSC]  AS ([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'A.DPHONEBUS')),
	[PHONEBUSC]  AS ([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'C.PHONEBUS')),
	[DPHONEEXTC]  AS ([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'B.DPHONEEXT')),
	[islinked]  AS ([dbo].[FUNC_linkpol]([KEYNUMP],[bus])),
	[hnamec]  AS ([dbo].[FUNC_hname]([KEYNUMP],[bus],[hname],(5))),
	 CONSTRAINT [PK_PEOPLE_POLICYS] PRIMARY KEY NONCLUSTERED 
	(
		[KEYNUML] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END


