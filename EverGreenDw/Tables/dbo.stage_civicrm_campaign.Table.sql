



CREATE TABLE [dbo].[stage_civicrm_campaign](
	[id] [bigint] NULL,
	[name] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[campaign_type_id] [bigint] NULL,
	[status_id] [bigint] NULL,
	[is_active] [smallint] NULL
) ON [PRIMARY]

