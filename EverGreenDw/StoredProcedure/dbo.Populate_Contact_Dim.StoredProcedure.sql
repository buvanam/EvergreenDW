







CREATE PROC [dbo].[Populate_Contact_Dim]
AS
BEGIN

IF NOT EXISTS (SELECT * FROM dbo.Contact_Dim WHERE Contact_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.[Contact_Dim] ON
       INSERT INTO dbo.[Contact_Dim]
	   ( 	
		 [Contact_SID]
      ,[Contact_ID]
      ,[First_Name]
      ,[Middle_Name]
      ,[Last_Name]
      ,[Join_Date]
      ,[Start_Date]
      ,[End_Date]
      ,[Membership_Type]
      ,[Tenure]
      ,[Organization_Name]
      ,[Email_ID]
      ,[Phone_Number]
      ,Street_Address
      ,[City]
      ,[Postal_Code]
      ,[Contact_Type]
      ,[Chapter_Name]
      ,[Is_Member]
      ,[Membership_Status]
      ,[Is_Primary_Member]
      ,[Is_Deleted]	
	   )
	VALUES
	( 
   	 -1
,-1
,'UNKNOWN'
,'UNKNOWN'
,'UNKNOWN'
, '1900-01-01 00:00:00.000'
, '1900-01-01 00:00:00.000'
, '1900-01-01 00:00:00.000'
,'UNKNOWN'
,0
,'UNKNOWN'
,'UNKNOWN'
,'9999999999'
,'UNKNOWN'
,'UNKNOWN'
,'99999'
,'UNKNOWN'
,'UNKNOWN'
,0
,'UNKNOWN'
,0
,0
	 )

SET IDENTITY_INSERT dbo.[Contact_Dim] OFF

END


;WITH src AS
(select 
cc.id as contact_id
,cm.join_date
,cm.start_date
,cm.end_date
,cmt.name as membership_type
,(year(cm.end_date) - year(cm.join_date)) as tenure
,cc.first_name
,cc.middle_name
,cc.last_name
,cc.organization_name
,(CASE  WHEN ce.email IS NOT NULL THEN ce.email WHEN cc.display_name LIKE '%@%' THEN cc.display_name ELSE '' END) as email_id ,cp.phone as phone_number
,concat(ca.street_address,' ', ca.supplemental_address_1) as street_address
,ca.city
,ca.postal_code
,cc.contact_type
,case when cm.membership_type_id is not null then coalesce(cov.label,'Statewide') else null end as chapter_name
,(case when cm.membership_type_id is null then 0 else 1 end) as is_member
,cms.label as membership_status
,(case  when (cm.membership_type_id is not null and cm.owner_membership_id is null) then 1 else 0 end) as is_primary_member 
,is_deleted
from stage_civicrm_contact cc
left join (select *
			, coalesce(join_date, start_date) as adj_join_date
			, rank() over(partition by contact_id order by end_date desc) as rnk
			from stage_civicrm_membership) cm 
			on cm.rnk = 1 and cm.is_test = 0 and adj_join_date is not null and cc.id = cm.contact_id
			
left join stage_civicrm_membership_status cms on cm.status_id = cms.id
left join stage_civicrm_membership_type cmt on cm.membership_type_id = cmt.id 
left join (select *
			, rank() over(partition by contact_id order by id desc) as rnk
			from stage_civicrm_phone) cp on cp.rnk = 1 and cp.is_primary = 1 and cc.id = cp.contact_id
left join (select *
			, rank() over(partition by contact_id order by id desc) as rnk
			from stage_civicrm_email) ce on cp.rnk = 1 and ce.is_primary = 1 and cc.id = ce.contact_id
left join stage_additional_membership_info cvam on cm.contact_id = cvam.entity_id 
left join stage_civicrm_option_value cov on cov.option_group_id = 86 and cvam.chapter_42 = cov.value
left join (select *
			, rank() over(partition by contact_id order by is_primary desc, id desc) as rnk
			from stage_civicrm_address) as ca on ca.rnk = 1 and ca.contact_id = cc.id
where (contact_type = 'Individual' and coalesce(first_name, last_name) is not null)
or (contact_type = 'Organization' and organization_name is not null)
)

INSERT INTO [dbo].[Contact_Dim](
Contact_ID
,First_Name
,Middle_Name
,Last_Name
,Join_Date
,Start_Date
,End_Date
,Membership_Type
,Tenure
,Organization_Name
,Email_ID
,Phone_Number
,Street_Address
,City
,Postal_Code
,Contact_Type
,Chapter_Name
,Is_Member
,Membership_Status
,Is_Primary_Member
,Is_Deleted)
SELECT 
contact_id
,first_name
,middle_name
,last_name
,join_date
,start_date
,end_date
,membership_type
,tenure
,organization_name
,email_id
,phone_number
,street_address
,city
,postal_code
,contact_type
,chapter_name
, is_member
,membership_status
,is_primary_member
,is_deleted 
FROM src
WHERE NOT EXISTS(SELECT 1 FROM dbo.Contact_Dim tgt WHERE tgt.Contact_ID=src.contact_id);


;WITH src AS
(select 
cc.id as contact_id
,cm.join_date
,cm.start_date
,cm.end_date
,cmt.name as membership_type
,(year(cm.end_date) - year(cm.join_date)) as tenure
,cc.first_name
,cc.middle_name
,cc.last_name
,cc.organization_name
,(CASE  WHEN ce.email IS NOT NULL THEN ce.email WHEN cc.display_name LIKE '%@%' THEN cc.display_name ELSE '' END) as email_id ,cp.phone as phone_number
,concat(ca.street_address,' ', ca.supplemental_address_1) as street_address
,ca.city
,ca.postal_code
,cc.contact_type
,case when cm.membership_type_id is not null then coalesce(cov.label,'Statewide') else null end as chapter_name
,(case when cm.membership_type_id is null then 0 else 1 end) as is_member
,cms.label as membership_status
,(case  when (cm.membership_type_id is not null and cm.owner_membership_id is null) then 1 else 0 end) as is_primary_member 
,is_deleted
from stage_civicrm_contact cc
left join (select *
			, coalesce(join_date, start_date) as adj_join_date
			, rank() over(partition by contact_id order by end_date desc) as rnk
			from stage_civicrm_membership) cm 
			on cm.rnk = 1 and cm.is_test = 0 and adj_join_date is not null and cc.id = cm.contact_id
			
left join stage_civicrm_membership_status cms on cm.status_id = cms.id
left join stage_civicrm_membership_type cmt on cm.membership_type_id = cmt.id 
left join (select *
			, rank() over(partition by contact_id order by id desc) as rnk
			from stage_civicrm_phone) cp on cp.rnk = 1 and cp.is_primary = 1 and cc.id = cp.contact_id
left join (select *
			, rank() over(partition by contact_id order by id desc) as rnk
			from stage_civicrm_email) ce on cp.rnk = 1 and ce.is_primary = 1 and cc.id = ce.contact_id
left join stage_additional_membership_info cvam on cm.contact_id = cvam.entity_id 
left join stage_civicrm_option_value cov on cov.option_group_id = 86 and cvam.chapter_42 = cov.value
left join (select *
			, rank() over(partition by contact_id order by is_primary desc, id desc) as rnk
			from stage_civicrm_address) as ca on ca.rnk = 1 and ca.contact_id = cc.id
where (contact_type = 'Individual' and coalesce(first_name, last_name) is not null)
or (contact_type = 'Organization' and organization_name is not null)
)

Update tgt set tgt.Contact_ID=src.contact_id
,tgt.First_Name=src.first_name
,tgt.Middle_Name=src.middle_name
,tgt.Last_Name=src.last_name
,tgt.Join_Date=src.join_date
,tgt.Start_Date=src.start_date
,tgt.End_Date=src.end_date
,tgt.Membership_Type=src.Membership_Type
,tgt.Tenure=src.Tenure
,tgt.Organization_Name=src.Organization_Name
,tgt.Email_ID=src.Email_ID
,tgt.Phone_Number=src.Phone_Number
,tgt.Street_Address=src.street_address
,tgt.City=src.City
,tgt.Postal_Code=src.Postal_Code
,tgt.Contact_Type=src.Contact_Type
,tgt.Chapter_Name=src.Chapter_Name
,tgt.Is_Member=src.Is_Member
,tgt.Membership_Status=src.Membership_Status
,tgt.Is_Primary_Member=src.Is_Primary_Member
,tgt.Is_Deleted=src.Is_Deleted
FROM [dbo].[Contact_Dim] tgt 
JOIN (
SELECT contact_id
,first_name
,middle_name
,last_name
,join_date
,start_date
,end_date
,membership_type
,tenure
,organization_name
,email_id
,phone_number
,street_address
,city
,postal_code
,contact_type
,chapter_name
, is_member
,membership_status
,is_primary_member
,is_deleted FROM src) src ON tgt.Contact_ID=src.contact_id
END

