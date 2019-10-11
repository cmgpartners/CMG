IF (OBJECT_ID('FK_REL_PP_PEOPLE') IS NULL)
BEGIN
    ALTER TABLE [dbo].[REL_PP]
		ADD CONSTRAINT [FK_REL_PP_PEOPLE] FOREIGN KEY (KEYNUMP) REFERENCES PEOPLE(KEYNUMP);
END
GO

IF (OBJECT_ID('FK_REL_PP_PEOPLE_KEYNUMP2') IS NULL)
BEGIN
    ALTER TABLE [dbo].[REL_PP]
		ADD CONSTRAINT [FK_REL_PP_PEOPLE_KEYNUMP2] FOREIGN KEY (KEYNUMP2) REFERENCES PEOPLE(KEYNUMP);
END
GO