



CREATE TABLE [dbo].[Campaign_Status_Dim](
	[Campaign_Status_SID] [int] IDENTITY(1,1) NOT NULL,
	[Campaign_Status_ID] [int] NULL,
	[Campaign_Status] [varchar](255) NULL,
 CONSTRAINT [PK_Campaign_Status_Dim] PRIMARY KEY CLUSTERED 
(
	[Campaign_Status_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

