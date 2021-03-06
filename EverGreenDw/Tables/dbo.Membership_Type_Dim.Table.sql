



CREATE TABLE [dbo].[Membership_Type_Dim](
	[Membership_Type_SID] [int] IDENTITY(1,1) NOT NULL,
	[Membership_Type_ID] [int] NULL,
	[Membership_Type] [varchar](255) NULL,
	[Is_Active] [tinyint] NULL,
 CONSTRAINT [PK_Membership_Type_Dim] PRIMARY KEY CLUSTERED 
(
	[Membership_Type_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

