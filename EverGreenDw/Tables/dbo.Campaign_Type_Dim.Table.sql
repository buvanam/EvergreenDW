



CREATE TABLE [dbo].[Campaign_Type_Dim](
	[Campaign_Type_SID] [int] IDENTITY(1,1) NOT NULL,
	[Campaign_Type_ID] [int] NULL,
	[Campaign_Type] [varchar](255) NULL,
 CONSTRAINT [PK_Campaign_Type_Dim] PRIMARY KEY CLUSTERED 
(
	[Campaign_Type_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

