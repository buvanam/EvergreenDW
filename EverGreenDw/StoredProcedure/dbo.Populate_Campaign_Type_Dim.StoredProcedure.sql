



CREATE PROC [dbo].[Populate_Campaign_Type_Dim]
AS
BEGIN


IF NOT EXISTS (SELECT * FROM dbo.Campaign_Type_Dim WHERE Campaign_Type_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Campaign_Type_Dim ON
       INSERT INTO dbo.Campaign_Type_Dim
	   ( 
		Campaign_Type_SID
		,Campaign_Type_ID
		,Campaign_Type	
	   )
	VALUES
	( 
   		 -1
		,-1
		,'UNKNOWN'
	 )

       SET IDENTITY_INSERT dbo.Campaign_Type_Dim OFF
END




INSERT INTO dbo.Campaign_Type_Dim
	   ( 
		Campaign_Type_ID
		,Campaign_Type	
	   )
SELECT * FROM
	( 
   		select value as Campaign_Type_ID,label as Campaign_Type
		from stage_civicrm_option_value cov 
		where cov.option_group_id = 52
)src
WHERE NOT EXISTS(SELECT 1 FROM dbo.Campaign_Type_Dim tgt WHERE tgt.Campaign_Type_ID=src.Campaign_Type_ID)


UPDATE tgt set tgt.Campaign_Type_ID=src.Campaign_Type_ID,tgt.Campaign_Type=src.Campaign_Type
FROM dbo.Campaign_Type_Dim tgt
JOIN (select value as Campaign_Type_ID,label as Campaign_Type
		from stage_civicrm_option_value cov 
		where cov.option_group_id = 52) src ON tgt.Campaign_Type_ID=src.Campaign_Type_ID

END


