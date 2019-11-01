ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [FK_PEOPLE_POLICYS_PEOPLE] FOREIGN KEY (KEYNUMP) REFERENCES PEOPLE(KEYNUMP);

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [FK_PEOPLE_POLICYS_PEOPLE] FOREIGN KEY (KEYNUMO) REFERENCES POLICYS(KEYNUMO);

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_KEYNUMO]  DEFAULT ((0)) FOR [KEYNUMO]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_CATGRY]  DEFAULT ('') FOR [CATGRY]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_HNAME]  DEFAULT ('') FOR [HNAME]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_KEYNUMP]  DEFAULT ((0)) FOR [KEYNUMP]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_RELATN]  DEFAULT ('') FOR [RELATN]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_REV_LOCN]  DEFAULT (suser_sname()) FOR [REV_LOCN]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_REV_DATE]  DEFAULT (getdate()) FOR [REV_DATE]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_CR8_LOCN]  DEFAULT (suser_sname()) FOR [CR8_LOCN]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_CR8_DATE]  DEFAULT (getdate()) FOR [CR8_DATE]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_DEL_]  DEFAULT ((0)) FOR [DEL_]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_SPLIT]  DEFAULT ((0.0)) FOR [split]

ALTER TABLE [dbo].[PEOPLE_POLICYS] ADD  CONSTRAINT [DF_PEOPLE_POLICYS_HSPLIT]  DEFAULT ((0)) FOR [Hsplit]

ALTER TABLE [dbo].[PEOPLE_POLICYS]  WITH CHECK ADD  CONSTRAINT [CK_PEOPLE_POLICYS] CHECK  (([KEYNUML]>(0)))

ALTER TABLE [dbo].[PEOPLE_POLICYS] CHECK CONSTRAINT [CK_PEOPLE_POLICYS]