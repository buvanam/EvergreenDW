





CREATE PROC [dbo].[Populate_Membership_Type_Dim]
AS
BEGIN


IF NOT EXISTS (SELECT * FROM dbo.Membership_Type_Dim WHERE Membership_Type_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Membership_Type_Dim ON
       INSERT INTO dbo.Membership_Type_Dim
	   ( 
       Membership_Type_SID
		,Membership_Type_ID
		,Membership_Type	
		,Is_Active
	   )
	VALUES
	( 
   		 -1
		,-1
		,'UNKNOWN'
		,0
	 )

       SET IDENTITY_INSERT dbo.Membership_Type_Dim OFF
END

 INSERT INTO dbo.Membership_Type_Dim
	   ( 
		Membership_Type_ID
		,Membership_Type	
		,Is_Active
	   ) 

select id as Membership_Type_ID,name as Membership_Type,is_active
from stage_civicrm_membership_type src
	 WHERE NOT EXISTS(SELECT 1 FROM dbo.Membership_Type_Dim tgt WHERE tgt.Membership_Type_ID=src.id)


UPDATE tgt set tgt.Membership_Type_ID=src.Membership_Type_ID,tgt.Membership_Type=src.Membership_Type,tgt.Is_Active=src.is_active
FROM dbo.Membership_Type_Dim tgt
JOIN (select id as Membership_Type_ID,name as Membership_Type,is_active
from stage_civicrm_membership_type) src ON tgt.Membership_Type_ID=src.Membership_Type_ID

END



