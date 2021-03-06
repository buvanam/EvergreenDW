





CREATE PROC [dbo].[Populate_Membership_Fact]
AS
BEGIN
 INSERT INTO dbo.Membership_Fact
	   ( 	
		   Contact_SID  
		  ,Start_Date_SID 
		  ,End_Date_SID 
		  ,Membership_Type_SID 
		  ,Membership_Status_SID 
		  ,Chapter_SID 
	   )
		SELECT * from 
	(SELECT ConDim.Contact_SID
		,ISNULL(startdatedim.Date_Dim_SID,-1)  AS Start_Date_SID
		,ISNULL(enddatedim.Date_Dim_SID,-1)  AS End_Date_SID
		,ISNULL(memtypedim.Membership_Type_SID,-1) AS Membership_Type_SID
		,ISNULL(memstatdim.Membership_Status_SID,-1) AS Membership_Status_SID
		,ISNULL(chapdim.Chapter_SID,-1) AS Chapter_SID
		from dbo.Contact_Dim ConDim
		left join (select *
			, coalesce(join_date, start_date) as adj_join_date
			, rank() over(partition by contact_id order by end_date desc) as rnk
			from stage_civicrm_membership) cm on cm.is_test = 0 and adj_join_date is not null and ConDim.Contact_ID = cm.contact_id 
		left join dbo.Date_Dim startdatedim
		   on startdatedim.Full_Date=cm.start_date
		left join dbo.Date_Dim enddatedim
		   on enddatedim.Full_Date=cm.end_date
		left join dbo.Membership_Type_Dim memtypedim
		  on memtypedim.Membership_Type_ID = cm.membership_type_id 
		left join dbo.Membership_Status_Dim memstatdim
		  on memstatdim.Membership_Status_ID = cm.status_id 
		left join dbo.Chapter_Dim chapdim on chapdim.Chapter_Name = ConDim.Chapter_Name
		where  ConDim.Is_Member=1) as src
	Where NOT EXISTS(
	  SELECT 1 FROM Membership_Fact tgt 
	  WHERE tgt.Contact_sid=src.Contact_SID
	   and tgt.start_date_sid=src.Start_Date_SID
	   and tgt.End_Date_SID=src.End_Date_SID
	   and tgt.Membership_Type_SID=src.Membership_Type_SID
	   and tgt.Membership_Status_SID=src.Membership_Status_SID
	   and tgt.Chapter_SID=src.Chapter_SID
	   )
		END
	 

