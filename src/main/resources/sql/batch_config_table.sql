USE [IPASSPORTDDB]
GO
/****** Object:  Table [dbo].[IPRO_TX_BATCHCONFIG]    Script Date: 3/3/2025 11:19:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPRO_TX_BATCHCONFIG](
	[config_id] [int] IDENTITY(1,1) NOT NULL,
	[config_key] [nvarchar](255) NOT NULL,
	[config_value] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[config_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[IPRO_TX_BATCHCONFIG] ON
INSERT [dbo].[IPRO_TX_BATCHCONFIG] ([config_id], [config_key], [config_value], [created_at], [updated_at]) VALUES (1, N'DataRetentionYear', N'3', CAST(N'2025-02-28T10:23:33.843' AS DateTime), CAST(N'2025-02-28T10:23:33.843' AS DateTime))
INSERT [dbo].[IPRO_TX_BATCHCONFIG] ([config_id], [config_key], [config_value], [created_at], [updated_at]) VALUES (2, N'DailyClearHour', N'24', CAST(N'2025-02-28T10:23:33.843' AS DateTime), CAST(N'2025-02-28T10:23:33.843' AS DateTime))
INSERT [dbo].[IPRO_TX_BATCHCONFIG] ([config_id], [config_key], [config_value], [created_at], [updated_at]) VALUES (3, N'MarkExpireHour', N'3', CAST(N'2025-02-28T10:23:33.843' AS DateTime), CAST(N'2025-02-28T10:23:33.843' AS DateTime))
SET IDENTITY_INSERT [dbo].[IPRO_TX_BATCHCONFIG] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__IPRO_TX___BDF6033D0764F555]    Script Date: 3/3/2025 11:19:41 AM ******/
ALTER TABLE [dbo].[IPRO_TX_BATCHCONFIG] ADD UNIQUE NONCLUSTERED 
(
	[config_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IPRO_TX_BATCHCONFIG] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[IPRO_TX_BATCHCONFIG] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
