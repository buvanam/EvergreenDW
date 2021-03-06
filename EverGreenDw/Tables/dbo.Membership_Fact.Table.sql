
CREATE TABLE [dbo].[Membership_Fact](
	[Membership_Fact_SID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_SID] [int] NOT NULL,
	[Start_Date_SID] [int] NOT NULL,
	[End_Date_SID] [int] NOT NULL,
	[Membership_Type_SID] [int] NOT NULL,
	[Membership_Status_SID] [int] NOT NULL,
	[Chapter_SID] [int] NOT NULL,
 CONSTRAINT [PK_Membership_Fact] PRIMARY KEY CLUSTERED 
(
	[Membership_Fact_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_Chapter_SID] FOREIGN KEY([Chapter_SID])
REFERENCES [dbo].[Chapter_Dim] ([Chapter_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_Chapter_SID]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_Contact_SID] FOREIGN KEY([Contact_SID])
REFERENCES [dbo].[Contact_Dim] ([Contact_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_Contact_SID]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_End_Date_SID] FOREIGN KEY([End_Date_SID])
REFERENCES [dbo].[Date_Dim] ([Date_Dim_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_End_Date_SID]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_Membership_Status_SID] FOREIGN KEY([Membership_Status_SID])
REFERENCES [dbo].[Membership_Status_Dim] ([Membership_Status_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_Membership_Status_SID]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_Membership_Type_SID] FOREIGN KEY([Membership_Type_SID])
REFERENCES [dbo].[Membership_Type_Dim] ([Membership_Type_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_Membership_Type_SID]
GO
ALTER TABLE [dbo].[Membership_Fact]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Fact_Start_Date_SID] FOREIGN KEY([Start_Date_SID])
REFERENCES [dbo].[Date_Dim] ([Date_Dim_SID])
GO
ALTER TABLE [dbo].[Membership_Fact] CHECK CONSTRAINT [FK_Membership_Fact_Start_Date_SID]
GO
