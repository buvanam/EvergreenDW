CREATE PROC [dbo].[Populate_Address_Dim]
AS
BEGIN

IF NOT EXISTS (SELECT * FROM dbo.Address_Dim WHERE Address_SID = -1)
BEGIN
       SET IDENTITY_INSERT dbo.Address_Dim ON
       INSERT INTO dbo.Address_Dim
	   ( 	
		Address_SID
		,Address_ID
		,Address_Line1
        ,Address_Line2
		,City
        ,State
		,Postal_Code
        ,Country
		,Is_Primary
        ,Is_Billing
	   )
	VALUES
	( 
   		 -1
		  , -1
		  , 'UNKNOWN'
          , 'UNKNOWN'
          , 'UNKNOWN'
          , 'UNKNOWN'
          , 'UNKNOWN'
          , 'UNKNOWN'
          ,0
          ,0
	 )

       SET IDENTITY_INSERT dbo.Address_Dim OFF
END


 INSERT INTO dbo.Address_Dim
	   ( 	
		Address_ID
	   ,Address_Line1
       ,Address_Line2
	   ,City
       ,State
	   ,Postal_Code
       ,Country
	   ,Is_Primary
       ,Is_Billing
      )
   		SELECT * FROM (select ca.id as Address_ID
				,street_address as Address_Line1
				,supplemental_address_1 as Address_Line2
				,city
				,csp.name as state
				,postal_code
				,cc.name as country
				,is_primary
				,is_billing
		from stage_civicrm_address ca
		join stage_civicrm_state_province csp
		on ca.state_province_id = csp.id
		join stage_civicrm_country cc
		on ca.country_id = cc.id ) src
WHERE NOT EXISTS(SELECT 1 FROM dbo.Address_Dim tgt WHERE tgt.Address_ID=src.Address_ID)

UPDATE tgt set tgt.Address_ID=src.Address_ID
			,tgt.Address_Line1=src.Address_Line1
			,tgt.Address_Line2=src.Address_Line2
			,tgt.City=src.city
			,tgt.State=src.state
			,tgt.Postal_Code=src.postal_code
			,tgt.Country=src.country
			,tgt.Is_Primary=src.is_primary
			,tgt.Is_Billing=src.is_billing
FROM dbo.Address_Dim tgt
JOIN (select ca.id as Address_ID
				,street_address as Address_Line1
				,supplemental_address_1 as Address_Line2
				,city
				,csp.name as state
				,postal_code
				,cc.name as country
				,is_primary
				,is_billing
		from stage_civicrm_address ca
		join stage_civicrm_state_province csp
		on ca.state_province_id = csp.id
		join stage_civicrm_country cc
		on ca.country_id = cc.id ) src ON tgt.Address_ID=src.Address_ID

END

