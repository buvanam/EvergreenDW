



CREATE TABLE [dbo].[Campaign_Dim](
	[Campaign_SID] [int] IDENTITY(1,1) NOT NULL,
	[Campaign_ID] [int] NULL,
	[Campaign_Name] [varchar](255) NULL,
	[Campaign_Title] [varchar](255) NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Campaign_Type] [varchar](255) NULL,
	[Campaign_Status] [varchar](255) NULL,
	[Is_Active] [tinyint] NULL,
 CONSTRAINT [PK_Campaign_Dim] PRIMARY KEY CLUSTERED 
(
	[Campaign_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

