





CREATE PROC [dbo].[Populate_Membership_Status_Dim]
AS
BEGIN

IF NOT EXISTS (SELECT * FROM dbo.Membership_Status_Dim WHERE Membership_Status_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Membership_Status_Dim ON
       INSERT INTO dbo.Membership_Status_Dim
	   ( 
       Membership_Status_SID
		,Membership_Status_ID
		,Membership_Status	
		,Is_Active
	   )
	VALUES
	( 
   		 -1
		,-1
		,'UNKNOWN'
		,0
	 )

       SET IDENTITY_INSERT dbo.Membership_Status_Dim OFF
END



INSERT INTO dbo.Membership_Status_Dim
	   ( 
		Membership_Status_ID
		,Membership_Status	
		,Is_Active
	   )
SELECT * FROM
	( 
   		select id as Membership_Status_ID,label as Membership_Status,is_active
		from stage_civicrm_membership_status

	 ) src

	 	 WHERE NOT EXISTS(SELECT 1 FROM dbo.Membership_Status_Dim tgt WHERE tgt.Membership_Status_ID=src.Membership_Status_ID)


UPDATE tgt set tgt.Membership_Status_ID=src.Membership_Status_ID,tgt.Membership_Status=src.Membership_Status,tgt.Is_Active=src.is_active
FROM dbo.Membership_Status_Dim tgt
JOIN (select id as Membership_Status_ID,label as Membership_Status,is_active
		from stage_civicrm_membership_status) src ON tgt.Membership_Status_ID=src.Membership_Status_ID

END

