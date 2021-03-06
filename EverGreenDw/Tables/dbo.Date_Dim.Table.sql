



CREATE TABLE [dbo].[Date_Dim](
	[Date_Dim_SID] [int] IDENTITY(1,1) NOT NULL,
	[Full_Date] [date] NOT NULL,
	[Day_Number_Of_Week] [tinyint] NOT NULL,
	[Day_Name_Of_Week] [varchar](9) NOT NULL,
	[Day_Number_Of_Month] [tinyint] NOT NULL,
	[Day_Number_Of_Year] [int] NOT NULL,
	[Weekday_Flag] [int] NOT NULL,
	[Week_Number_Of_Year] [tinyint] NOT NULL,
	[Month_Name] [varchar](9) NOT NULL,
	[Month_Number_Of_Year] [tinyint] NOT NULL,
	[Calendar_Quarter] [int] NOT NULL,
	[Calendar_Year] [int] NOT NULL,
 CONSTRAINT [PK_Date_Dim] PRIMARY KEY CLUSTERED 
(
	[Date_Dim_SID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

