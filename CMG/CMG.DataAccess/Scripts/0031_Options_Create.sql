CREATE TABLE [dbo].[Options](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Key] [varchar](50) NOT NULL,
	[Value] [varchar](max) NOT NULL,
	[User] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Options] ADD  CONSTRAINT [DF_Options_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[Options] ADD  CONSTRAINT [DF_Options_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO

ALTER TABLE [dbo].[Options] ADD  CONSTRAINT [DF_Options_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [dbo].[Options] ADD  CONSTRAINT [DF_Options_ModifiedBy]  DEFAULT (suser_sname()) FOR [ModifiedBy]
GO

ALTER TABLE [dbo].[Options] ADD  CONSTRAINT [DF_Options_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO


