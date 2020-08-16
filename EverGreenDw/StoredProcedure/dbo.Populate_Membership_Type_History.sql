CREATE PROC [dbo].[Populate_Membership_Type_History]
AS
BEGIN
	WITH distinctdate AS
	(
	select distinct contact_id,start_date as conversiondate,membership_type_id
	from dbo.stage_civicrm_membership
	where is_test=0 and start_date is not null
	)	
	,CTE AS
	(
	select contact_id,conversiondate,membership_type_id,
	ROW_NUMBER() over(partition by contact_id order by conversiondate desc) AS RowNum
	from distinctdate)
   ,MembershipTypeHistory AS
   (
	SELECT ConDim.Contact_SID
		  ,conversiondate AS Conversion_Date
		  ,MemDim.Membership_Type AS Membership_Type
		  ,case when RowNum=1 then 1 else 0 end AS Is_Current
	FROM CTE
	JOIN dbo.Contact_Dim ConDim
	  ON ConDIm.Contact_ID=CTE.contact_id
	JOIN dbo.Membership_Type_Dim MemDim
	  ON MemDim.Membership_Type_ID=CTE.membership_type_id)
	MERGE dbo.Membership_Type_History AS target  
    USING MembershipTypeHistory AS source 
    ON (target.Contact_SID = source.Contact_SID
	   AND target.MemberShip_Type=source.MemberShip_Type
	   AND target.Conversion_Date=source.Conversion_Date)  
    WHEN MATCHED THEN
        UPDATE SET Is_Current = source.Is_Current  
    WHEN NOT MATCHED THEN  
        INSERT (Contact_SID,Conversion_Date,Membership_Type,Is_Current)  
        VALUES (source.Contact_SID, source.Conversion_Date,source.Membership_Type,source.Is_Current);
END
