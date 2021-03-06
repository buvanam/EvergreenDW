




CREATE PROC [dbo].[Populate_Contribution_Type_Dim]
AS
BEGIN


IF NOT EXISTS (SELECT * FROM dbo.Contribution_Type_Dim WHERE Contribution_Type_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Contribution_Type_Dim ON
       INSERT INTO dbo.Contribution_Type_Dim
	   ( 	
		Contribution_Type_SID
		,Contribution_Type_ID
		,Contribution_Type
		,Is_Active
	   )
	VALUES
	( 
   		 -1
		  , -1
		  , 'UNKNOWN'
		  ,0
	 )

       SET IDENTITY_INSERT dbo.Contribution_Type_Dim OFF
END

INSERT INTO dbo.Contribution_Type_Dim
	   ( 	
		Contribution_Type_ID
		,Contribution_Type
		,Is_Active
	   )
SELECT id AS Contribution_Type_ID, name AS Contribution_Type, is_active
FROM stage_civicrm_financial_type src
WHERE NOT EXISTS(SELECT 1 FROM dbo.Contribution_Type_Dim tgt WHERE tgt.Contribution_Type_ID=src.id)

UPDATE tgt set tgt.Contribution_Type_ID=src.Contribution_Type_ID,tgt.Contribution_Type=src.Contribution_Type,tgt.Is_Active=src.is_active
FROM dbo.Contribution_Type_Dim tgt
JOIN (select id as Contribution_Type_ID, name as Contribution_Type, is_active
from stage_civicrm_financial_type) src ON tgt.Contribution_Type_ID=src.Contribution_Type_ID

END

