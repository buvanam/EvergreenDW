
CREATE TABLE [dbo].[Chapter_History](
	[Chapter_History_ID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_SID] [int] NOT NULL,
	[Start_Date] [datetime] NOT NULL,
	[Date_Date] [datetime] NOT NULL,
	[Chapter_Name] [varchar](255) NOT NULL,
	[Is_Current] [tinyint] NOT NULL,
 CONSTRAINT [PK_Chapter_History] PRIMARY KEY CLUSTERED 
(
	[Chapter_History_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chapter_History]  WITH CHECK ADD  CONSTRAINT [FK_Chapter_History_Contact_SID] FOREIGN KEY([Contact_SID])
REFERENCES [dbo].[Contact_Dim] ([Contact_SID])
GO
ALTER TABLE [dbo].[Chapter_History] CHECK CONSTRAINT [FK_Chapter_History_Contact_SID]

