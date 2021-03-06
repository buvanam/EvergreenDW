



CREATE TABLE [dbo].[Address_Dim](
	[Address_SID] [int] IDENTITY(1,1) NOT NULL,
	[Address_ID] [int] NULL,
	[Address_Line1] [varchar](255) NULL,
	[Address_Line2] [varchar](255) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](100) NULL,
	[Postal_Code] [varchar](100) NULL,
	[Country] [varchar](100) NULL,
	[Is_Primary] [tinyint] NULL,
	[Is_Billing] [tinyint] NULL,
 CONSTRAINT [PK_Address_Dim] PRIMARY KEY CLUSTERED 
(
	[Address_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

