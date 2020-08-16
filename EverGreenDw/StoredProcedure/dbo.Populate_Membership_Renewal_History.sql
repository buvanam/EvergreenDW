CREATE PROC [dbo].[Populate_Membership_Renewal_History]
AS
BEGIN
	WITH distinctdate AS
	(
	select distinct contact_id,start_date as Start_Date,end_date as End_Date
	from dbo.stage_civicrm_membership
	where is_test=0 and start_date is not null 
	)	
	,CTE AS
	(
	select contact_id,Start_Date,End_Date,
	ROW_NUMBER() over(partition by contact_id order by Start_Date desc) AS RowNum
	from distinctdate)
   ,MembershipRenewalHistory AS
   (
	SELECT ConDim.Contact_SID
		  ,CTE.Start_Date
		  ,CTE.End_Date
		  ,case when RowNum=1 then 1 else 0 end AS Is_Active
	FROM CTE
	JOIN dbo.Contact_Dim ConDim
	  ON ConDIm.Contact_ID=CTE.contact_id)
	MERGE dbo.Membership_Renewal_History AS target  
    USING MembershipRenewalHistory AS source 
    ON (target.Contact_SID = source.Contact_SID
	   AND target.Start_Date=source.Start_Date
	   AND target.End_Date=source.End_Date)  
    WHEN MATCHED THEN
        UPDATE SET Is_Active = source.Is_Active
    WHEN NOT MATCHED THEN  
        INSERT (Contact_SID,Start_Date,End_Date,Is_Active)  
        VALUES (source.Contact_SID, source.Start_Date,source.End_Date,source.Is_Active);
END
