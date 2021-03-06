CREATE PROC [dbo].[InsDate_DimYearly]
( 
	@Year INT=NULL
)
AS
SET NOCOUNT ON;

DECLARE @Date DATE, @FirstDate Date, @LastDate Date;

SELECT @Year=COALESCE(@Year,YEAR(DATEADD(d,1,MAX(Date_Dim_SID)))) FROM dbo.Date_Dim;

SET @FirstDate=DATEFROMPARTS(COALESCE(@Year,YEAR(GETDATE())-1), 01, 01); -- First Day of the Year
SET @LastDate=DATEFROMPARTS(COALESCE(@Year,YEAR(GETDATE())-1), 12, 31); -- Last Day of the Year

SET @Date=@FirstDate;
-- create CTE with all dates needed for load
;WITH DateCTE AS
(
SELECT @FirstDate AS StartDate -- earliest date to load in table
UNION ALL
SELECT DATEADD(day, 1, StartDate)
FROM DateCTE -- recursively select the date + 1 over and over
WHERE DATEADD(day, 1, StartDate) <= @LastDate -- last date to load in table
)

-- load date dimension table with all dates
INSERT INTO dbo.Date_Dim 
	(
	Full_Date 
	,Day_Number_Of_Week 
	,Day_Name_Of_Week 
	,Day_Number_Of_Month 
	,Day_Number_Of_Year 
	,Weekday_Flag
	,Week_Number_Of_Year 
	,[Month_Name] 
	,Month_Number_Of_Year 
	,Calendar_Quarter 
	,Calendar_Year 	 
	)
SELECT 
	 CAST(StartDate AS DATE) AS Full_Date
	,DATEPART(dw, StartDate) AS Day_Number_Of_Week
	,DATENAME(dw, StartDate) AS Day_Name_Of_Week
	,DAY(StartDate) AS Day_Number_Of_Month
	,DATEPART(dy, StartDate) AS Day_Number_Of_Year
	,CASE DATENAME(dw, StartDate) WHEN 'Saturday' THEN 0 WHEN 'Sunday' THEN 0 ELSE 1 END AS Weekday_Flag
	,DATEPART(wk, StartDate) AS Week_Number_Of_Year
	,DATENAME(mm, StartDate) AS [Month_Name]
	,MONTH(StartDate) AS Month_Number_Of_Year
	,DATEPART(qq, StartDate) AS Calendar_Quarter
	,YEAR(StartDate) AS Calendar_Year	
FROM DateCTE
OPTION (MAXRECURSION 0);-- prevents infinate loop from running more than once

