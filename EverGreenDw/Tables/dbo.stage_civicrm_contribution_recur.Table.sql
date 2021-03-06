



CREATE TABLE [dbo].[stage_civicrm_contribution_recur](
	[id] [bigint] NULL,
	[contact_id] [bigint] NULL,
	[amount] [numeric](20, 2) NULL,
	[currency] [nvarchar](3) NULL,
	[frequency_unit] [nvarchar](8) NULL,
	[frequency_interval] [bigint] NULL,
	[installments] [bigint] NULL,
	[start_date] [datetime] NULL,
	[create_date] [datetime] NULL,
	[modified_date] [datetime] NULL,
	[cancel_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[contribution_status_id] [bigint] NULL,
	[is_test] [smallint] NULL,
	[cycle_day] [bigint] NULL,
	[next_sched_contribution_date] [datetime] NULL,
	[failure_count] [bigint] NULL,
	[failure_retry_date] [datetime] NULL,
	[auto_renew] [smallint] NULL,
	[payment_processor_id] [bigint] NULL,
	[financial_type_id] [bigint] NULL,
	[payment_instrument_id] [bigint] NULL,
	[campaign_id] [bigint] NULL,
	[is_email_receipt] [smallint] NULL
) ON [PRIMARY]

