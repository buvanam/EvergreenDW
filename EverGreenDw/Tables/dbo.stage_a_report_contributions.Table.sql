



CREATE TABLE [dbo].[stage_a_report_contributions](
	[contact_id] [bigint] NULL,
	[first_name] [nvarchar](64) NULL,
	[last_name] [nvarchar](64) NULL,
	[organization_name] [nvarchar](128) NULL,
	[email] [nvarchar](254) NULL,
	[phone] [nvarchar](32) NULL,
	[street_address1] [nvarchar](96) NULL,
	[street_address2] [nvarchar](96) NULL,
	[city] [nvarchar](64) NULL,
	[state] [nvarchar](4) NULL,
	[zip] [nvarchar](64) NULL,
	[contribution_id] [bigint] NULL,
	[fin_trxn_id] [bigint] NULL,
	[status] [nvarchar](512) NULL,
	[financial_type] [nvarchar](64) NULL,
	[accounting_code] [nvarchar](64) NULL,
	[trxn_id] [nvarchar](255) NULL,
	[source] [nvarchar](255) NULL,
	[campaign] [nvarchar](255) NULL,
	[trxn_date] [datetime] NULL,
	[total_amount] [numeric](20, 2) NULL,
	[chapter] [nvarchar](255) NULL,
	[payment_method] [nvarchar](512) NULL
) ON [PRIMARY]

