/****** Object:  Table [dbo].[Chapter_Dim]    Script Date: 8/15/2020 6:40:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Chapter_Dim](
	[Chapter_SID] [int] IDENTITY(1,1) NOT NULL,
	[Chapter_ID] [int] NULL,
	[Chapter_Name] [varchar](255) NULL,
	[Is_Active] [tinyint] NULL,
 CONSTRAINT [PK_Chapter_Dim] PRIMARY KEY CLUSTERED 
(
	[Chapter_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

