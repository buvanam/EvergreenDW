



CREATE TABLE [dbo].[Contribution_Type_Dim](
	[Contribution_Type_SID] [int] IDENTITY(1,1) NOT NULL,
	[Contribution_Type_ID] [int] NULL,
	[Contribution_Type] [varchar](255) NULL,
	[Is_Active] [tinyint] NULL,
 CONSTRAINT [PK_Contribution_Type_Dim] PRIMARY KEY CLUSTERED 
(
	[Contribution_Type_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

