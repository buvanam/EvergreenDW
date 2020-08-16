/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROC [dbo].[Populate_Chapter_History]
AS
BEGIN
	WITH chapters as
	(SELECT [id]
		  ,[option_group_id]
		  ,[label]
		  ,[name]
		  ,[value]
		  ,[is_active]
	  FROM [dbo].[stage_civicrm_option_value]
	  where option_group_id=86)
	,contactchapter AS
	(
	SELECT distinct
		   contact_id
		  ,name
		  ,trxn_date
	  FROM [dbo].[stage_a_report_contributions] stg
	  JOIN chapters chap
		ON stg.chapter=chap.value WHERE trxn_date IS NOT NULL)
	,CTE AS(SELECT contact_id,name,trxn_date,ROW_NUMBER() over(partition by contact_id order by trxn_date desc) AS RowNum
	  FROM contactchapter)
	,ChapterHIstory AS
	   (
		SELECT ConDim.Contact_SID
			  ,CTE.trxn_date AS Start_Date
			  ,CTE.trxn_date AS Date_Date
			  ,name AS Chapter_Name
			  ,case when RowNum=1 then 1 else 0 end AS Is_Current
		FROM  CTE
		JOIN dbo.Contact_Dim ConDim
		  ON ConDIm.Contact_ID=CTE.contact_id)
		MERGE dbo.Chapter_HIstory AS target  
		USING ChapterHIstory AS source 
		ON (target.Contact_SID = source.Contact_SID
		   AND target.Start_Date=source.Start_Date
		   AND target.Chapter_Name=source.Chapter_Name)  
		WHEN MATCHED THEN
			UPDATE SET Is_Current = source.Is_Current
		WHEN NOT MATCHED THEN  
			INSERT (Contact_SID,Start_Date,Date_Date,Chapter_Name,Is_Current)  
			VALUES (source.Contact_SID, source.Start_Date,source.Date_Date,source.Chapter_Name,source.Is_Current);
END