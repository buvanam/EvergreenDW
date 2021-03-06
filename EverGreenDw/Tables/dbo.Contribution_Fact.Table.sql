CREATE TABLE [dbo].[Contribution_Fact](
	[Contribution_Fact_SID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_SID] [int] NOT NULL,
	[Transaction_Date_SID] [int] NOT NULL,
	[Contribution_Type_SID] [int] NOT NULL,
	[Total_Amount] [int] NOT NULL,
	[Campaign_SID] [int] NOT NULL,
	[Campaign_Type_SID] [int] NOT NULL,
	[Campaign_Status_SID] [int] NOT NULL,
	[Address_SID] [int] NOT NULL,
	[Membership_Type_SID] [int] NOT NULL,
	[Membership_Status_SID] [int] NOT NULL,
	[Chapter_SID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Address_SID] FOREIGN KEY([Address_SID])
REFERENCES [dbo].[Address_Dim] ([Address_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Address_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Campaign_SID] FOREIGN KEY([Campaign_SID])
REFERENCES [dbo].[Campaign_Dim] ([Campaign_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Campaign_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Campaign_Type_SID] FOREIGN KEY([Campaign_Type_SID])
REFERENCES [dbo].[Campaign_Type_Dim] ([Campaign_Type_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Campaign_Type_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Chapter_SID] FOREIGN KEY([Chapter_SID])
REFERENCES [dbo].[Chapter_Dim] ([Chapter_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Chapter_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Contact_SID] FOREIGN KEY([Contact_SID])
REFERENCES [dbo].[Contact_Dim] ([Contact_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Contact_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Contribution_Type_SID] FOREIGN KEY([Contribution_Type_SID])
REFERENCES [dbo].[Contribution_Type_Dim] ([Contribution_Type_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Contribution_Type_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Membership_Status_SID] FOREIGN KEY([Membership_Status_SID])
REFERENCES [dbo].[Membership_Status_Dim] ([Membership_Status_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Membership_Status_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Membership_Type_SID] FOREIGN KEY([Membership_Type_SID])
REFERENCES [dbo].[Membership_Type_Dim] ([Membership_Type_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Membership_Type_SID]
GO
ALTER TABLE [dbo].[Contribution_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Contribution_Fact_Transaction_Date_SID] FOREIGN KEY([Transaction_Date_SID])
REFERENCES [dbo].[Date_Dim] ([Date_Dim_SID])
GO
ALTER TABLE [dbo].[Contribution_Fact] CHECK CONSTRAINT [FK_Contribution_Fact_Transaction_Date_SID]

