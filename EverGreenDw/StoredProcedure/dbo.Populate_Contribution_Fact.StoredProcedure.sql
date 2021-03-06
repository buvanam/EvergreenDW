







CREATE PROC [dbo].[Populate_Contribution_Fact]
AS
BEGIN
 INSERT INTO dbo.Contribution_Fact
	   ( 	
		   Contact_SID  
		  ,Contribution_Type_SID 
		  ,Transaction_Date_SID 
		  ,Total_Amount 
		  ,Campaign_SID 
		  ,Campaign_Type_SID 
		  ,Campaign_Status_SID 
		  ,Address_SID 
		  ,Membership_Type_SID 
		  ,Membership_Status_SID 
		  ,Chapter_SID 
	   )
		SELECT * from 
	(Select ConDim.Contact_SID
		,ISNULL(contTypeDim.Contribution_Type_SID,-1) AS Contribution_Type_SID 
		,ISNULL(transdatedim.Date_Dim_SID,-1) AS Transaction_Date_SID 
		,ISNULL(stage_con.total_amount,0) AS Total_Amount
		,ISNULL(CampDim.Campaign_SID,-1) AS Campaign_SID 
		,ISNULL(CampTypeDim.Campaign_Type_SID,-1) AS Campaign_Type_SID 
		,ISNULL(CampStatusDim.Campaign_Status_SID,-1) AS Campaign_Status_SID
		,ISNULL(Addressdim.Address_SID,-1) AS Address_SID 
		,ISNULL(memtypedim.Membership_Type_SID,-1) AS Membership_Type_SID
		,ISNULL(memstatusdim.Membership_Status_SID,-1) AS Membership_Status_SID
		,ISNULL(chapdim.Chapter_SID,-1) AS Chapter_SID
		from dbo.stage_civicrm_contribution stage_con
		join dbo.Contact_Dim ConDim
		on stage_con.contact_id=ConDim.Contact_ID
		left join dbo.Contribution_Type_Dim contTypeDim
		  on contTypeDim.Contribution_Type_ID=stage_con.financial_type_id
		left join dbo.Date_Dim transdatedim
		  on transdatedim.Full_Date=CAST(stage_con.receive_date AS DATE)
		left join dbo.Campaign_Dim CampDim
		  on CampDim.Campaign_ID=stage_con.campaign_id
		left join dbo.Campaign_Type_Dim CampTypeDim
		  on CampTypeDim.Campaign_Type=CampDim.Campaign_Type
		left join dbo.Campaign_Status_Dim CampStatusDim
		  on CampStatusDim.Campaign_Status=CampDim.Campaign_Status
		left join (select *
			, rank() over(partition by contact_id order by is_primary desc, id desc) as rnk
			from stage_civicrm_address) as stageAdd on stageAdd.rnk = 1 and stageAdd.contact_id = stage_con.contact_id 		
		left join dbo.Address_Dim Addressdim
		   on Addressdim.Address_ID=stageAdd.id
		left join dbo.Membership_Type_Dim memtypedim
		  on memtypedim.Membership_Type =ConDim.Membership_Type
		left join dbo.Membership_Status_Dim memstatusdim
		  on memstatusdim.Membership_Status =ConDim.Membership_Status
		left join dbo.Chapter_Dim ChapDim
		  on ChapDim.Chapter_Name=ConDim.Chapter_Name) src
  Where NOT EXISTS(
  SELECT 1 FROM Contribution_Fact tgt 
  WHERE tgt.Contact_sid=src.Contact_SID
   and tgt.Contribution_Type_SID=src.Contribution_Type_SID
   and tgt.Transaction_Date_SID=src.Transaction_Date_SID
   and tgt.Contribution_Type_SID=src.Contribution_Type_SID
   )


END
 

