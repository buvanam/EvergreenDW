



CREATE TABLE [dbo].[stage_civicrm_contact](
	[id] [bigint] NULL,
	[first_name] [nvarchar](64) NULL,
	[middle_name] [nvarchar](64) NULL,
	[last_name] [nvarchar](64) NULL,
	[display_name] [nvarchar](128) NULL,
	[organization_name] [nvarchar](128) NULL,
	[contact_type] [nvarchar](64) NULL,
	[is_deleted] [smallint] NULL,
	[created_date] [datetime] NULL,
	[modified_date] [datetime] NULL
) ON [PRIMARY]

