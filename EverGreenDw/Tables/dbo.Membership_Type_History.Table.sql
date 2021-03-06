



CREATE TABLE [dbo].[Membership_Type_History](
	[Membership_Type_History_ID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_SID] [int] NOT NULL,
	[Conversion_Date] [datetime] NOT NULL,
	[Membership_Type] [varchar](100) NOT NULL,
	[Is_Current] [tinyint] NOT NULL,
 CONSTRAINT [PK_Membership_Type_History] PRIMARY KEY CLUSTERED 
(
	[Membership_Type_History_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Membership_Type_History]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Type_History_Contact_SID] FOREIGN KEY([Contact_SID])
REFERENCES [dbo].[Contact_Dim] ([Contact_SID])
GO
ALTER TABLE [dbo].[Membership_Type_History] CHECK CONSTRAINT [FK_Membership_Type_History_Contact_SID]
GO
