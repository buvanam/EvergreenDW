CREATE PROC [dbo].[Populate_ChapterDim]
AS
BEGIN
IF NOT EXISTS (SELECT * FROM dbo.Chapter_Dim WHERE Chapter_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Chapter_Dim ON
       INSERT INTO dbo.Chapter_Dim
	   ( 	
         Chapter_SID
		,Chapter_ID
		,Chapter_Name
		,Is_Active
	   )
	VALUES
	( 
    -1
		  , -1
		  , 'UNKNOWN'
		  , 0
	 )

SET IDENTITY_INSERT dbo.Chapter_Dim OFF
END
INSERT INTO dbo.Chapter_Dim
	   ( 
		Chapter_ID
		,Chapter_Name
		,Is_Active
	   )       
SELECT value as chapter_id
	  ,label as chapter_name
      ,is_active 
FROM stage_civicrm_option_value  src
WHERE option_group_id = 86  
  AND NOT EXISTS(SELECT 1 FROM Chapter_Dim tgt where tgt.chapter_id=src.value)

UPDATE tgt set tgt.Chapter_ID=src.chapter_id,tgt.Chapter_Name=src.chapter_name,tgt.Is_Active=src.is_active
FROM dbo.Chapter_Dim tgt
JOIN(
SELECT value as chapter_id
	  ,label as chapter_name
      ,is_active 
FROM stage_civicrm_option_value  
WHERE option_group_id = 86  ) src
 ON tgt.Chapter_ID=src.chapter_id
 END
