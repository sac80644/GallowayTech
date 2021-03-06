USE [webapps]
GO
/****** Object:  Table [dbo].[SiteContent]    Script Date: 09/07/2009 23:18:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SiteContent](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleContent] [ntext] NULL,
	[ModuleID] [int] NOT NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_SiteContent] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
