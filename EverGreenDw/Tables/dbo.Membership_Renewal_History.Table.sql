



CREATE TABLE [dbo].[Membership_Renewal_History](
	[Membership_Renewal_History_SID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_SID] [int] NOT NULL,
	[Start_Date] [datetime] NOT NULL,
	[End_Date] [datetime] NOT NULL,
	[Is_Active] [int] NOT NULL,
 CONSTRAINT [PK_Membership_Renewal_History] PRIMARY KEY CLUSTERED 
(
	[Membership_Renewal_History_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Membership_Renewal_History]  WITH CHECK ADD  CONSTRAINT [FK_Membership_Renewal_History_Contact_SID] FOREIGN KEY([Contact_SID])
REFERENCES [dbo].[Contact_Dim] ([Contact_SID])
GO
ALTER TABLE [dbo].[Membership_Renewal_History] CHECK CONSTRAINT [FK_Membership_Renewal_History_Contact_SID]

