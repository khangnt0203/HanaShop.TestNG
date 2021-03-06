USE [master]
GO
/****** Object:  Database [HanaShop]    Script Date: 3/10/2021 10:03:28 PM ******/
CREATE DATABASE [HanaShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HanaShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\HanaShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HanaShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\HanaShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [HanaShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HanaShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HanaShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HanaShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HanaShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HanaShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HanaShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HanaShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HanaShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HanaShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HanaShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HanaShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HanaShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HanaShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HanaShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HanaShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HanaShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HanaShop] SET RECOVERY FULL 
GO
ALTER DATABASE [HanaShop] SET  MULTI_USER 
GO
ALTER DATABASE [HanaShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HanaShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HanaShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HanaShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HanaShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [HanaShop]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/10/2021 10:03:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[userId] [nvarchar](30) NOT NULL,
	[password] [nvarchar](30) NULL,
	[role] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/10/2021 10:03:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryId] [nvarchar](30) NOT NULL,
	[name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 3/10/2021 10:03:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[invoiceId] [nvarchar](30) NOT NULL,
	[dateOfIssue] [date] NULL,
	[total] [float] NULL,
	[userId] [nvarchar](30) NULL,
	[payment] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[numberphone] [nvarchar](50) NULL,
 CONSTRAINT [PK__Invoice__1252416CAB1F9610] PRIMARY KEY CLUSTERED 
(
	[invoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice_Details]    Script Date: 3/10/2021 10:03:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Details](
	[invoiceId] [nvarchar](30) NOT NULL,
	[proId] [nvarchar](30) NOT NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_Invoice_Details] PRIMARY KEY CLUSTERED 
(
	[invoiceId] ASC,
	[proId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 3/10/2021 10:03:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[proId] [nvarchar](30) NOT NULL,
	[name] [nvarchar](30) NULL,
	[description] [nvarchar](300) NULL,
	[price] [float] NULL,
	[isAvailable] [bit] NULL CONSTRAINT [DF_Product_isAvailable]  DEFAULT ((1)),
	[createDate] [date] NULL CONSTRAINT [DF_Product_createDate]  DEFAULT (getdate()),
	[updateDate] [date] NULL,
	[quantity] [int] NULL CONSTRAINT [DF_Product_quantity]  DEFAULT ((0)),
	[categoryId] [nvarchar](30) NULL,
	[image] [varchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[proId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'admin', N'123456', N'admin')
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'thanhgodlike@gmail.com', NULL, NULL)
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'thanhgodlike1@gmail.com', NULL, NULL)
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'tungvsse140240@fpt.edu.vn', NULL, NULL)
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'user', N'123456', N'user')
INSERT [dbo].[Account] ([userId], [password], [role]) VALUES (N'user2', N'123456', N'user')
INSERT [dbo].[Category] ([categoryId], [name]) VALUES (N'1', N'food')
INSERT [dbo].[Category] ([categoryId], [name]) VALUES (N'2', N'drink')
INSERT [dbo].[Invoice] ([invoiceId], [dateOfIssue], [total], [userId], [payment], [address], [numberphone]) VALUES (N'06190137202123491', CAST(N'2021-01-19' AS Date), 25.399999618530273, N'user', N'Zalo Pay', N'dai hoc fpt quan 9 tphcm', N'0123456789')
INSERT [dbo].[Invoice] ([invoiceId], [dateOfIssue], [total], [userId], [payment], [address], [numberphone]) VALUES (N'20090312202112263', CAST(N'2021-03-09' AS Date), 17.600000381469727, N'user', N'Cash upon delivery', N'tphcm quan 9', N'0777997001')
INSERT [dbo].[Invoice_Details] ([invoiceId], [proId], [quantity]) VALUES (N'06190137202123491', N'cocacola', 2)
INSERT [dbo].[Invoice_Details] ([invoiceId], [proId], [quantity]) VALUES (N'06190137202123491', N'ganuong', 3)
INSERT [dbo].[Invoice_Details] ([invoiceId], [proId], [quantity]) VALUES (N'20090312202112263', N'ganuong', 1)
INSERT [dbo].[Invoice_Details] ([invoiceId], [proId], [quantity]) VALUES (N'20090312202112263', N'xienque', 3)
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'7upnuocngot', N'7 UP', N'Nuoc ngot huong chanh', 0.9, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-03-07' AS Date), 2, N'2', N'image.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'asdfg111', N'Dong Suong Sau', N'Food in Binh Dinh', 3, 1, CAST(N'2021-01-14' AS Date), CAST(N'2021-01-15' AS Date), 250, N'2', N'65296268_1139459809570576_9153219784798633984_n.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'bananadrink', N'Sweet banana', N'Food in Binh Dinh', 2, 1, CAST(N'2021-01-14' AS Date), CAST(N'2021-01-17' AS Date), 50, N'2', N'images.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'banhmivn', N'Banh Mi', N'good for heath', 1, 1, CAST(N'2021-01-14' AS Date), CAST(N'2021-01-19' AS Date), 50, N'1', N'kinh-doanh-thuc-an-duong-pho-bytuong-com.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'cacaoda', N'ca cao sua', N'good for heath', 2, 1, CAST(N'2021-01-14' AS Date), CAST(N'2021-01-17' AS Date), 5, N'2', N'tra-sua-oreo-cake-cream(1).jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'cakhoto', N'Ca Kho To', N'Ca kho vn', 3, 0, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 0, N'1', N'1459770927-cach-lam-ca-kho-to-chuan-ngon-nhu-me-lam.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'canuong', N'Ca Nuong', N'ca nuong sieu ngon', 6, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 14, N'1', N'1434344254-vrfhca1_ybmg.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'chagio', N'Cha Gio', N'Cha gio vn', 3, 0, CAST(N'2021-01-17' AS Date), NULL, 9, N'1', N'cha-gio-cuon-khoai-mon-zi13.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'changa', N'Chan Ga Nuong', N'Chan ga nuong cay ngon', 3, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 24, N'1', N'cach-lam-chan-ga-nuong-mat-ong-bang-lo-nuong-thumbnail.png')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'cocacola', N'Coca Cola', N'Nuoc ngot', 0.7, 1, CAST(N'2021-01-17' AS Date), NULL, 71, N'2', N'nuoc-ngot-coca-cola-nguyen-ban-giam-duong-chai-15-lit-202005151922094152.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'drink1', N'Tea', N'good for heath', 5.6, 1, CAST(N'2021-01-12' AS Date), NULL, 10, N'2', N'65032683_1140077216175502_9058078145999011840_n.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'drink3', N'Orange juice', N'Orange juice less sweet', 1, 0, CAST(N'2021-01-13' AS Date), NULL, 18, N'2', N'images (1).jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'drink4', N'Milk Tea', N'Best seller in vn', 1.5, 1, CAST(N'2021-01-13' AS Date), NULL, 20, N'2', N'tra-sua-xoai-01.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'drink6', N'Lemon tea', N'good for heath', 2, 1, CAST(N'2021-01-13' AS Date), NULL, 25, N'2', N'photo1556527094597-1556527095043-crop-1556527203625175025878.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'food1', N'Cha ram tom dat', N'Food in Binh Dinh', 5, 1, CAST(N'2021-01-13' AS Date), NULL, 10, N'1', N'an-vat-ntphuong1-2.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'food3', N'cherry Smoothie', N'cherry', 3, 1, CAST(N'2021-01-13' AS Date), CAST(N'2021-01-15' AS Date), 12, N'2', N'do-uong-hot-hien-nay-5.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'ganuong', N'Ga Nuong', N'Ga nuong nguyen con', 8, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 3, N'1', N'cach-lam-ga-nuong-muoi-ot-ngon-800-153822.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'heoquay', N'Heo Quay', N'Heo quay nong', 4, 1, CAST(N'2021-01-17' AS Date), NULL, 5, N'1', N'unnamed (1).jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'icreamdau', N'Kem Dau', N'Kem lam tu dau', 2, 1, CAST(N'2021-01-17' AS Date), NULL, 8, N'1', N'kem-dau-da-bao-mat-lanh-thumbnail-1.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'milkteamango', N'Tra Sua Xoai', N'Milk tea Mango', 1, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 27, N'2', N'tra-sua-xoai-01.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'mirindacam', N'Mirinda Cam', N'Nuoc cam co ga', 0.5, 1, CAST(N'2021-01-17' AS Date), NULL, 56, N'2', N'nuoc-ngot-mirinda-cam-330ml.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'nuocmia', N'Nuoc Mia', N'Nuoc tu mia ngot', 0.5, 1, CAST(N'2021-01-17' AS Date), NULL, 29, N'2', N'Uong-nuoc-mia-sai-cach-can-than-sinh-benh-2.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'sadadad', N'oc nhoi', N'mon ngon moi nha', 8, 1, CAST(N'2021-03-09' AS Date), CAST(N'2021-03-09' AS Date), 5, N'1', N'65057796_1139408399575717_2456588230930202624_n.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'shushi', N'shushi', N'good for heath', 5, 1, CAST(N'2021-01-14' AS Date), CAST(N'2021-01-19' AS Date), 2, N'1', N'unnamed.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'suachua', N'Yaourt', N'Sua chua dau', 0.5, 1, CAST(N'2021-01-17' AS Date), CAST(N'2021-01-19' AS Date), 100, N'2', N'cong-thuc-cach-lam-sua-chua.jpg')
INSERT [dbo].[Product] ([proId], [name], [description], [price], [isAvailable], [createDate], [updateDate], [quantity], [categoryId], [image]) VALUES (N'xienque', N'Xien Que', N'xien nuong sieu ngon', 3.2, 1, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-20' AS Date), 2, N'1', N'pho-di-bo-70aa0192636917242876496354.jpg')
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK__Invoice__userId__1DE57479] FOREIGN KEY([userId])
REFERENCES [dbo].[Account] ([userId])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK__Invoice__userId__1DE57479]
GO
ALTER TABLE [dbo].[Invoice_Details]  WITH CHECK ADD  CONSTRAINT [FK__Invoice_D__invoi__1ED998B2] FOREIGN KEY([invoiceId])
REFERENCES [dbo].[Invoice] ([invoiceId])
GO
ALTER TABLE [dbo].[Invoice_Details] CHECK CONSTRAINT [FK__Invoice_D__invoi__1ED998B2]
GO
ALTER TABLE [dbo].[Invoice_Details]  WITH CHECK ADD FOREIGN KEY([proId])
REFERENCES [dbo].[Product] ([proId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([categoryId])
GO
USE [master]
GO
ALTER DATABASE [HanaShop] SET  READ_WRITE 
GO
