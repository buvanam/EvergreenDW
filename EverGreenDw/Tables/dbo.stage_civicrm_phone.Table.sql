



CREATE TABLE [dbo].[stage_civicrm_phone](
	[id] [bigint] NULL,
	[contact_id] [bigint] NULL,
	[is_billing] [smallint] NULL,
	[is_primary] [smallint] NULL,
	[phone] [nvarchar](32) NULL,
	[phone_numeric] [nvarchar](32) NULL,
	[phone_type_id] [bigint] NULL
) ON [PRIMARY]

