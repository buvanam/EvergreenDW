



CREATE TABLE [dbo].[stage_civicrm_contribution](
	[id] [bigint] NULL,
	[contact_id] [bigint] NULL,
	[financial_type_id] [bigint] NULL,
	[receive_date] [datetime] NULL,
	[total_amount] [numeric](20, 2) NULL,
	[fee_amount] [numeric](20, 2) NULL,
	[net_amount] [numeric](20, 2) NULL,
	[currency] [nvarchar](3) NULL,
	[contribution_recur_id] [bigint] NULL,
	[address_id] [bigint] NULL,
	[campaign_id] [bigint] NULL
) ON [PRIMARY]

