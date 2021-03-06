



CREATE TABLE [dbo].[stage_civicrm_address](
	[id] [bigint] NULL,
	[contact_id] [bigint] NULL,
	[is_billing] [smallint] NULL,
	[is_primary] [smallint] NULL,
	[location_type_id] [bigint] NULL,
	[street_address] [nvarchar](96) NULL,
	[supplemental_address_1] [nvarchar](96) NULL,
	[city] [nvarchar](64) NULL,
	[state_province_id] [bigint] NULL,
	[country_id] [bigint] NULL,
	[postal_code_suffix] [nvarchar](12) NULL,
	[postal_code] [nvarchar](64) NULL
) ON [PRIMARY]

