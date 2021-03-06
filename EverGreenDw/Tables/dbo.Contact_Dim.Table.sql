



CREATE TABLE [dbo].[Contact_Dim](
	[Contact_SID] [int] IDENTITY(1,1) NOT NULL,
	[Contact_ID] [int] NULL,
	[First_Name] [varchar](100) NULL,
	[Middle_Name] [varchar](100) NULL,
	[Last_Name] [varchar](100) NULL,
	[Join_Date] [datetime] NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Membership_Type] [varchar](255) NULL,
	[Tenure] [nvarchar](10) NULL,
	[Organization_Name] [varchar](255) NULL,
	[Email_ID] [nvarchar](255) NULL,
	[Phone_Number] [varchar](100) NULL,
	[Street_Address] [varchar](255) NULL,
	[City] [varchar](100) NULL,
	[Postal_Code] [varchar](100) NULL,
	[Contact_Type] [varchar](100) NULL,
	[Chapter_Name] [varchar](255) NULL,
	[Is_Member] [tinyint] NULL,
	[Membership_Status] [varchar](255) NULL,
	[Is_Primary_Member] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Contact_Dim] PRIMARY KEY CLUSTERED 
(
	[Contact_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

