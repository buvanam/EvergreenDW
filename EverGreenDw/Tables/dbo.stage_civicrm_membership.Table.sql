



CREATE TABLE [dbo].[stage_civicrm_membership](
	[id] [bigint] NULL,
	[contact_id] [bigint] NULL,
	[join_date] [datetime] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[status_id] [bigint] NULL,
	[membership_type_id] [bigint] NULL,
	[owner_membership_id] [bigint] NULL,
	[campaign_id] [bigint] NULL,
	[is_test] [smallint] NULL
) ON [PRIMARY]

