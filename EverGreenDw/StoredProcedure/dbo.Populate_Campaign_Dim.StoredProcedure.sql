CREATE PROC [dbo].[Populate_Campaign_Dim]
AS
BEGIN

IF NOT EXISTS (SELECT * FROM dbo.Campaign_Dim WHERE Campaign_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Campaign_Dim ON
       INSERT INTO dbo.Campaign_Dim
	   ( 	
		Campaign_SID
		,Campaign_ID
		,Campaign_Name
		,Campaign_Title
       		 ,Start_Date
		,End_Date
,Campaign_Type
,Campaign_Status
,Is_Active		
	   )
	VALUES
	( 
   	 -1
,-1
,'UNKNOWN'
,'UNKNOWN'
, '1900-01-01 00:00:00.000'
, '1900-01-01 00:00:00.000'
,'UNKNOWN'
,'UNKNOWN'
,0
	 )

       SET IDENTITY_INSERT dbo.Campaign_Dim OFF
END


 INSERT INTO dbo.Campaign_Dim
	   ( 	
		Campaign_ID
		,Campaign_Name
		,Campaign_Title
       	,Start_Date
		,End_Date
      	,Campaign_Type
      	,Campaign_Status
      	,Is_Active		
	   )
SELECT * FROM
	(( 
   	select id as Campaign_ID
	    ,name as Campaign_Name
        ,title	as Campaign_Title
        ,start_date
        ,end_date
        ,(	select label 
			from stage_civicrm_option_value cov 
			where cov.option_group_id = 52 
           			 and cc.campaign_type_id = cov.value
	) as campaign_type
	,(select label 
			from stage_civicrm_option_value cov 
			where cov.option_group_id = 53 
           	and cc.campaign_type_id = cov.value
	) as campaign_status
	,is_active
from stage_civicrm_campaign cc
	 )) src
	 WHERE NOT EXISTS(SELECT 1 FROM dbo.Campaign_Dim tgt WHERE tgt.Campaign_ID=src.Campaign_ID)


UPDATE tgt set tgt.Campaign_ID=src.Campaign_ID,tgt.Campaign_Title=src.Campaign_Title,tgt.Campaign_Name=src.Campaign_Name,tgt.Campaign_Type=src.Campaign_Type,tgt.Campaign_Status=src.Campaign_Status,tgt.Is_Active=src.is_active
FROM dbo.Campaign_Dim tgt
JOIN (( 
   	select id as Campaign_ID
	    ,name as Campaign_Name
        ,title	as Campaign_Title
        ,start_date
        ,end_date
        ,(	select label 
			from stage_civicrm_option_value cov 
			where cov.option_group_id = 52 
           			 and cc.campaign_type_id = cov.value
	) as campaign_type
	,(select label 
			from stage_civicrm_option_value cov 
			where cov.option_group_id = 53 
           	and cc.campaign_type_id = cov.value
	) as campaign_status
	,is_active
from stage_civicrm_campaign cc
	 )) src
	 ON tgt.Campaign_ID=src.Campaign_ID

END

