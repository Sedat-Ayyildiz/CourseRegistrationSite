USE [DbSınavEntity]
GO
/****** Object:  Table [dbo].[TblDersler]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblDersler](
	[Dersid] [int] IDENTITY(1,1) NOT NULL,
	[DersAd] [varchar](50) NULL,
 CONSTRAINT [PK_TblDersler] PRIMARY KEY CLUSTERED 
(
	[Dersid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblKulupler]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblKulupler](
	[Kulupid] [tinyint] IDENTITY(1,1) NOT NULL,
	[KulupAd] [varchar](50) NULL,
 CONSTRAINT [PK_TblKulupler] PRIMARY KEY CLUSTERED 
(
	[Kulupid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblNotlar]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblNotlar](
	[Notid] [int] IDENTITY(1,1) NOT NULL,
	[Ogr] [int] NULL,
	[Ders] [int] NULL,
	[Sınav1] [smallint] NULL,
	[Sınav2] [smallint] NULL,
	[Sınav3] [smallint] NULL,
	[Ortalama] [decimal](5, 2) NULL,
	[Durum] [bit] NULL,
 CONSTRAINT [PK_TblNotlar] PRIMARY KEY CLUSTERED 
(
	[Notid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblOgrenci]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblOgrenci](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [varchar](20) NULL,
	[Soyad] [varchar](20) NULL,
	[Fotograf] [varchar](100) NULL,
	[Sehir] [varchar](50) NULL,
	[OgrKulup] [tinyint] NULL,
 CONSTRAINT [PK_TblOgrenci] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TblUrunler]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUrunler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ad] [varchar](50) NULL,
	[Marka] [varchar](50) NULL,
	[Fiyat] [int] NULL,
	[Stok] [int] NULL,
 CONSTRAINT [PK_TblUrunler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblNotlar]  WITH CHECK ADD  CONSTRAINT [FK_TblNotlar_TblDersler] FOREIGN KEY([Ders])
REFERENCES [dbo].[TblDersler] ([Dersid])
GO
ALTER TABLE [dbo].[TblNotlar] CHECK CONSTRAINT [FK_TblNotlar_TblDersler]
GO
ALTER TABLE [dbo].[TblNotlar]  WITH CHECK ADD  CONSTRAINT [FK_TblNotlar_TblOgrenci] FOREIGN KEY([Ogr])
REFERENCES [dbo].[TblOgrenci] ([id])
GO
ALTER TABLE [dbo].[TblNotlar] CHECK CONSTRAINT [FK_TblNotlar_TblOgrenci]
GO
ALTER TABLE [dbo].[TblOgrenci]  WITH CHECK ADD  CONSTRAINT [FK_TblOgrenci_TblKulupler] FOREIGN KEY([OgrKulup])
REFERENCES [dbo].[TblKulupler] ([Kulupid])
GO
ALTER TABLE [dbo].[TblOgrenci] CHECK CONSTRAINT [FK_TblOgrenci_TblKulupler]
GO
/****** Object:  StoredProcedure [dbo].[Kulupler]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Kulupler]
as
SELECT Ad , Soyad , Sehir , KulupAd
FROM TblOgrenci
INNER JOIN TblKulupler
ON
TblOgrenci.OgrKulup=TblKulupler.Kulupid
GO
/****** Object:  StoredProcedure [dbo].[NotListesi]    Script Date: 23.06.2023 05:22:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[NotListesi]
as
select Notid,ad+' '+soyad as 'AD SOYAD',dersad,sınav1,sınav2,sınav3,ortalama,durum from TblNotlar
inner join TblOgrenci on TblNotlar.Ogr=TblOgrenci.id
inner join TblDersler on TblDersler.Dersid=TblNotlar.Ders
GO
