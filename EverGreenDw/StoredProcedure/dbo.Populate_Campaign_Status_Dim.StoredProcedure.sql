CREATE PROC [dbo].[Populate_Campaign_Status_Dim]
AS
BEGIN


IF NOT EXISTS (SELECT * FROM dbo.Campaign_Status_Dim WHERE Campaign_Status_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Campaign_Status_Dim ON
       INSERT INTO dbo.Campaign_Status_Dim
	   ( 
		Campaign_Status_SID
		,Campaign_Status_ID
		,Campaign_Status	
	   )
	VALUES
	( 
   		 -1
		,-1
		,'UNKNOWN'
	 )

       SET IDENTITY_INSERT dbo.Campaign_Status_Dim OFF
END




INSERT INTO dbo.Campaign_Status_Dim
	   ( 
		Campaign_Status_ID
		,Campaign_Status	
	   )
SELECT * FROM
	( 
   		select value as Campaign_Status_ID,label as Campaign_Status
		from stage_civicrm_option_value cov 
		where cov.option_group_id = 52
)src
WHERE NOT EXISTS(SELECT 1 FROM dbo.Campaign_Status_Dim tgt WHERE tgt.Campaign_Status_ID=src.Campaign_Status_ID)


UPDATE tgt set tgt.Campaign_Status_ID=src.Campaign_Status_ID,tgt.Campaign_Status=src.Campaign_Status
FROM dbo.Campaign_Status_Dim tgt
JOIN (select value as Campaign_Status_ID,label as Campaign_Status
		from stage_civicrm_option_value cov 
		where cov.option_group_id = 52) src ON tgt.Campaign_Status_ID=src.Campaign_Status_ID

END


