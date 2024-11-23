USE [master]
GO
/****** Object:  Database [GymFitnessPL]    Script Date: 11/23/2024 1:14:07 PM ******/
CREATE DATABASE [GymFitnessPL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GymFitnessPL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.LASCHANH\MSSQL\DATA\GymFitnessPL.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GymFitnessPL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.LASCHANH\MSSQL\DATA\GymFitnessPL_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [GymFitnessPL] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GymFitnessPL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GymFitnessPL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GymFitnessPL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GymFitnessPL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GymFitnessPL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GymFitnessPL] SET ARITHABORT OFF 
GO
ALTER DATABASE [GymFitnessPL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GymFitnessPL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GymFitnessPL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GymFitnessPL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GymFitnessPL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GymFitnessPL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GymFitnessPL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GymFitnessPL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GymFitnessPL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GymFitnessPL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GymFitnessPL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GymFitnessPL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GymFitnessPL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GymFitnessPL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GymFitnessPL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GymFitnessPL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GymFitnessPL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GymFitnessPL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GymFitnessPL] SET  MULTI_USER 
GO
ALTER DATABASE [GymFitnessPL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GymFitnessPL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GymFitnessPL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GymFitnessPL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GymFitnessPL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GymFitnessPL] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'GymFitnessPL', N'ON'
GO
ALTER DATABASE [GymFitnessPL] SET QUERY_STORE = ON
GO
ALTER DATABASE [GymFitnessPL] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [GymFitnessPL]
GO
/****** Object:  User [LASCHANH171]    Script Date: 11/23/2024 1:14:08 PM ******/
CREATE USER [LASCHANH171] FOR LOGIN [LASCHANH171] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [hthanh]    Script Date: 11/23/2024 1:14:08 PM ******/
CREATE USER [hthanh] FOR LOGIN [hthanh] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(100,1) NOT NULL,
	[CategoryName] [nvarchar](20) NOT NULL,
	[Date_Modified] [datetime] NULL,
	[Date_Added] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [varchar](5) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[SupplierID] [varchar](5) NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL,
	[Date_Added] [datetime] NULL,
	[Date_Modified] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ProductID] UNIQUE NONCLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetails](
	[PurchaseID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [varchar](5) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Amount] [int] NULL,
	[Discount] [int] NULL,
	[TotalAmount] [decimal](18, 0) NULL,
	[PurchaseDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_getPurchaseDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_getPurchaseDetails]
AS
SELECT        TOP (100) PERCENT dbo.PurchaseDetails.PurchaseID, dbo.Products.ProductName, dbo.Categories.CategoryName, dbo.PurchaseDetails.Amount, dbo.PurchaseDetails.Discount, dbo.PurchaseDetails.TotalAmount, 
                         dbo.PurchaseDetails.PurchaseDate
FROM            dbo.PurchaseDetails INNER JOIN
                         dbo.Products ON dbo.PurchaseDetails.ProductID = dbo.Products.ProductID AND dbo.PurchaseDetails.CategoryID = dbo.Products.CategoryID INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [varchar](4) NOT NULL,
	[StaffName] [nvarchar](50) NULL,
	[Gender] [nvarchar](7) NULL,
	[DateOfBirth] [datetime] NULL,
	[Email] [varchar](50) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[PositionId] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[Status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [varchar](5) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL,
	[Discount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [varchar](4) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](10) NULL,
	[DateofBirth] [datetime] NULL,
	[PhoneNumber] [varchar](20) NULL,
	[PackID] [varchar](3) NULL,
	[StaffID] [varchar](4) NULL,
	[Startdate] [datetime] NULL,
	[DateRegister] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[Date_Added] [datetime] NULL,
	[Date_Modified] [datetime] NULL,
	[Image] [varchar](255) NULL,
 CONSTRAINT [pk_Cid] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [varchar](4) NOT NULL,
	[StaffID] [varchar](4) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_getOrderDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_getOrderDetails]
AS
SELECT        dbo.OrderDetails.OrderDetailID, dbo.OrderDetails.OrderID, dbo.Customers.CustomerName, dbo.Staff.StaffName, dbo.Categories.CategoryName, dbo.Products.ProductName, dbo.OrderDetails.Quantity, dbo.OrderDetails.Discount, 
                         dbo.OrderDetails.UnitPrice, dbo.Orders.OrderDate
FROM            dbo.Products INNER JOIN
                         dbo.OrderDetails ON dbo.Products.ProductID = dbo.OrderDetails.ProductID AND dbo.Products.CategoryID = dbo.OrderDetails.CategoryID INNER JOIN
                         dbo.Orders ON dbo.OrderDetails.OrderID = dbo.Orders.OrderID INNER JOIN
                         dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID INNER JOIN
                         dbo.Staff ON dbo.Orders.StaffID = dbo.Staff.StaffID AND dbo.Customers.StaffID = dbo.Staff.StaffID INNER JOIN
                         dbo.Categories ON dbo.Products.CategoryID = dbo.Categories.CategoryID
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [varchar](5) NOT NULL,
	[CompanyName] [nvarchar](50) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactPhone] [varchar](20) NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Date_Added] [datetime] NULL,
	[Date_Modified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_getProductInfoDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_getProductInfoDetails]
AS
SELECT        dbo.Products.ProductID, dbo.Products.ProductName, dbo.Categories.CategoryName, dbo.Products.Quantity, dbo.Supplier.CompanyName, FORMAT(dbo.Products.UnitPrice, 'C0', 'vi-VN') AS 'Price', dbo.Products.Description, 
                         dbo.Supplier.Country
FROM            dbo.Categories INNER JOIN
                         dbo.Products ON dbo.Categories.CategoryID = dbo.Products.CategoryID INNER JOIN
                         dbo.Supplier ON dbo.Products.SupplierID = dbo.Supplier.SupplierID
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [varchar](4) NOT NULL,
	[StaffID] [varchar](4) NOT NULL,
	[ProductID] [varchar](5) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [int] NULL,
	[Date_Added] [datetime] NULL,
	[Date_Modified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_getCartDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_getCartDetails]
AS
SELECT        dbo.Cart.CartID, dbo.Customers.CustomerName, dbo.Staff.StaffName, dbo.Products.ProductName, dbo.Categories.CategoryName, dbo.Cart.Quantity, dbo.Cart.Discount
FROM            dbo.Cart INNER JOIN
                         dbo.Categories ON dbo.Cart.CategoryID = dbo.Categories.CategoryID INNER JOIN
                         dbo.Customers ON dbo.Cart.CustomerID = dbo.Customers.CustomerID INNER JOIN
                         dbo.Staff ON dbo.Cart.StaffID = dbo.Staff.StaffID INNER JOIN
                         dbo.Products ON dbo.Cart.ProductID = dbo.Products.ProductID AND dbo.Cart.CategoryID = dbo.Products.CategoryID AND dbo.Categories.CategoryID = dbo.Products.CategoryID
GO
/****** Object:  Table [dbo].[Absence]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Absence](
	[StaffID] [varchar](4) NOT NULL,
	[DateAbsent] [datetime] NOT NULL,
	[Reason] [nvarchar](max) NULL,
 CONSTRAINT [PK_Absence] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC,
	[DateAbsent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [varchar](4) NOT NULL,
	[FullName] [nvarchar](50) NULL,
	[Username] [varchar](50) NULL,
	[Password] [varchar](60) NULL,
	[Email] [varchar](50) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Status] [nvarchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[LastLogin] [datetime] NULL,
	[RoleId] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendance]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendance](
	[EmployeeID] [varchar](4) NOT NULL,
	[WorkDate] [date] NOT NULL,
	[ClockInTime] [time](7) NULL,
	[ClockOutTime] [time](7) NULL,
	[ShiftID] [char](4) NULL,
	[HoursWorked] [float] NULL,
	[Note] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[WorkDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CashHandOver]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashHandOver](
	[handover_id] [int] IDENTITY(1,1) NOT NULL,
	[from_id] [varchar](4) NULL,
	[to_id] [varchar](4) NULL,
	[amount] [decimal](18, 0) NULL,
	[handover_time] [datetime] NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_CashHandOver] PRIMARY KEY CLUSTERED 
(
	[handover_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CheckIn_Customer]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckIn_Customer](
	[CustomerID] [varchar](4) NOT NULL,
	[LastDateCheck] [datetime] NULL,
	[LastDateCheckOut] [datetime] NULL,
 CONSTRAINT [PK_CheckInCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Checking_ProductDetails]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Checking_ProductDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [varchar](5) NULL,
	[CategoryId] [int] NULL,
	[StockId] [int] NULL,
	[Fill_Amount] [int] NULL,
	[Residual_Qty] [int] NULL,
	[InUse_Qty] [int] NULL,
	[Date_Filled] [datetime] NULL,
	[DateAdded] [date] NULL,
	[DateModified] [datetime] NULL,
	[Notes] [text] NULL,
 CONSTRAINT [PK_Checking_ProductDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Debit]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Debit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [varchar](4) NULL,
	[Debit_Amount] [decimal](18, 0) NULL,
	[Debit_date] [datetime] NULL,
	[Repayment_date] [datetime] NULL,
 CONSTRAINT [PK_Debit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncomeExpense]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncomeExpense](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[StaffID] [varchar](4) NULL,
	[Amount] [decimal](18, 0) NULL,
	[TransactionType] [nvarchar](5) NULL,
	[TransactionTime] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[PackID] [varchar](3) NOT NULL,
	[PackName] [nvarchar](50) NOT NULL,
	[PackPrice] [decimal](18, 0) NULL,
 CONSTRAINT [pk_PackID] PRIMARY KEY CLUSTERED 
(
	[PackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonTrainer]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonTrainer](
	[PtID] [varchar](5) NOT NULL,
	[StaffID] [varchar](4) NOT NULL,
	[CustomerID] [varchar](4) NOT NULL,
	[Startdate] [datetime] NOT NULL,
	[SessionTime] [int] NOT NULL,
	[TotalPrice] [decimal](18, 0) NOT NULL,
	[Note] [nvarchar](max) NULL,
	[Price] [decimal](18, 0) NOT NULL,
 CONSTRAINT [pk_PtID] PRIMARY KEY CLUSTERED 
(
	[PtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Positions]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Positions](
	[PositionId] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED 
(
	[PositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[ReceiptID] [varchar](4) NOT NULL,
	[DateRegistered] [datetime] NOT NULL,
	[CustomerID] [varchar](4) NOT NULL,
	[PackID] [varchar](3) NOT NULL,
	[StaffID] [varchar](4) NOT NULL,
	[PtID] [varchar](5) NULL,
 CONSTRAINT [PK_Receiption] PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefillProducts]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefillProducts](
	[ProductID] [varchar](5) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Fill_Amount] [int] NULL,
	[Date_Filled] [datetime] NOT NULL,
 CONSTRAINT [PK_RefillProducts] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CategoryID] ASC,
	[Date_Filled] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Role_Id] [int] IDENTITY(1,1) NOT NULL,
	[Role_Name] [nvarchar](20) NULL,
	[Role_Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Role_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salary]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salary](
	[StaffID] [varchar](4) NOT NULL,
	[Total_Payable] [decimal](18, 0) NULL,
	[Note] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ScheduleID] [varchar](5) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[EventContent] [nvarchar](max) NULL,
	[EventDate] [datetime] NULL,
	[EventTime] [time](7) NULL,
	[EventLocation] [nvarchar](100) NULL,
	[EventType] [nvarchar](20) NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShiftTime]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShiftTime](
	[ShiftID] [char](4) NOT NULL,
	[ShiftName] [char](7) NULL,
	[ShiftDescription] [varchar](20) NULL,
	[ShiftStartTime] [time](7) NULL,
	[ShiftEndTime] [time](7) NULL,
 CONSTRAINT [PK_ShiftTime] PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffShift]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffShift](
	[StaffShiftId] [int] IDENTITY(1,1) NOT NULL,
	[StaffId] [varchar](4) NULL,
	[ShiftId] [char](4) NULL,
	[WorkDate] [datetime] NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_StaffShift] PRIMARY KEY CLUSTERED 
(
	[StaffShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[StockID] [int] IDENTITY(1000,1) NOT NULL,
	[ProductID] [varchar](5) NULL,
	[CategoryID] [int] NULL,
	[Import_Qty] [int] NULL,
	[Date_Imported] [datetime] NULL,
	[Date_Added] [datetime] NULL,
	[Date_Modified] [datetime] NULL,
 CONSTRAINT [PK_Stocks] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timekeeping]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timekeeping](
	[EmployeeID] [varchar](4) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[ActionType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[Timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccounts]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccounts](
	[UserAccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NOT NULL,
	[UserType] [nvarchar](20) NULL,
	[UserId] [varchar](4) NULL,
 CONSTRAINT [PK_UserAccounts] PRIMARY KEY CLUSTERED 
(
	[UserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_Startdate]  DEFAULT (getdate()) FOR [Startdate]
GO
ALTER TABLE [dbo].[PersonTrainer] ADD  CONSTRAINT [DF_PT_Startdate]  DEFAULT (getdate()) FOR [Startdate]
GO
ALTER TABLE [dbo].[PersonTrainer] ADD  DEFAULT ((220000)) FOR [Price]
GO
ALTER TABLE [dbo].[PurchaseDetails] ADD  CONSTRAINT [DF_GetPurchaseDate]  DEFAULT (getdate()) FOR [PurchaseDate]
GO
ALTER TABLE [dbo].[Receipt] ADD  CONSTRAINT [DF_Receiption_DateRegistered]  DEFAULT (getdate()) FOR [DateRegistered]
GO
ALTER TABLE [dbo].[Absence]  WITH CHECK ADD  CONSTRAINT [FK_Absence_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Absence] CHECK CONSTRAINT [FK_Absence_Staff]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Role_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Roles]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_Attendance_Staff] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_Attendance_Staff]
GO
ALTER TABLE [dbo].[Attendance]  WITH CHECK ADD  CONSTRAINT [FK_ShiftTime] FOREIGN KEY([ShiftID])
REFERENCES [dbo].[ShiftTime] ([ShiftID])
GO
ALTER TABLE [dbo].[Attendance] CHECK CONSTRAINT [FK_ShiftTime]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Customer]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Staff]
GO
ALTER TABLE [dbo].[CashHandOver]  WITH CHECK ADD  CONSTRAINT [FK_CashHandOver_FromStaff] FOREIGN KEY([from_id])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CashHandOver] CHECK CONSTRAINT [FK_CashHandOver_FromStaff]
GO
ALTER TABLE [dbo].[CashHandOver]  WITH CHECK ADD  CONSTRAINT [FK_CashHandOver_ToStaff] FOREIGN KEY([to_id])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[CashHandOver] CHECK CONSTRAINT [FK_CashHandOver_ToStaff]
GO
ALTER TABLE [dbo].[CheckIn_Customer]  WITH CHECK ADD  CONSTRAINT [FK_CheckIn_Customer_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CheckIn_Customer] CHECK CONSTRAINT [FK_CheckIn_Customer_Customers]
GO
ALTER TABLE [dbo].[Checking_ProductDetails]  WITH CHECK ADD  CONSTRAINT [FK_Checking_ProductDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Checking_ProductDetails] CHECK CONSTRAINT [FK_Checking_ProductDetails_Products]
GO
ALTER TABLE [dbo].[Checking_ProductDetails]  WITH CHECK ADD  CONSTRAINT [FK_Checking_ProductDetails_Stocks] FOREIGN KEY([StockId])
REFERENCES [dbo].[Stocks] ([StockID])
GO
ALTER TABLE [dbo].[Checking_ProductDetails] CHECK CONSTRAINT [FK_Checking_ProductDetails_Stocks]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [fk_CusPackID] FOREIGN KEY([PackID])
REFERENCES [dbo].[Package] ([PackID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [fk_CusPackID]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Staff]
GO
ALTER TABLE [dbo].[Debit]  WITH CHECK ADD  CONSTRAINT [FK_Debit_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Debit] CHECK CONSTRAINT [FK_Debit_Customers]
GO
ALTER TABLE [dbo].[IncomeExpense]  WITH CHECK ADD  CONSTRAINT [FK_IncomeExpense_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[IncomeExpense] CHECK CONSTRAINT [FK_IncomeExpense_Staff]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customer]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Staff] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Staff]
GO
ALTER TABLE [dbo].[PersonTrainer]  WITH CHECK ADD  CONSTRAINT [FK_PersonTrainer_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonTrainer] CHECK CONSTRAINT [FK_PersonTrainer_Customers]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Category]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Supplier]
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[PurchaseDetails] CHECK CONSTRAINT [FK_Purchase_Products]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receiption_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receiption_Customers]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receiption_Package] FOREIGN KEY([PackID])
REFERENCES [dbo].[Package] ([PackID])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receiption_Package]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [FK_Receiption_PersonTrainer] FOREIGN KEY([PtID])
REFERENCES [dbo].[PersonTrainer] ([PtID])
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [FK_Receiption_PersonTrainer]
GO
ALTER TABLE [dbo].[RefillProducts]  WITH CHECK ADD  CONSTRAINT [FK_RefillProducts_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RefillProducts] CHECK CONSTRAINT [FK_RefillProducts_Products]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Positions] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Positions] ([PositionId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Positions]
GO
ALTER TABLE [dbo].[StaffShift]  WITH CHECK ADD  CONSTRAINT [FK_StaffShift_ShiftTime] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[ShiftTime] ([ShiftID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[StaffShift] CHECK CONSTRAINT [FK_StaffShift_ShiftTime]
GO
ALTER TABLE [dbo].[StaffShift]  WITH CHECK ADD  CONSTRAINT [FK_StaffShift_Staff] FOREIGN KEY([StaffId])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[StaffShift] CHECK CONSTRAINT [FK_StaffShift_Staff]
GO
ALTER TABLE [dbo].[Stocks]  WITH CHECK ADD  CONSTRAINT [FK_Stocks_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Stocks] CHECK CONSTRAINT [FK_Stocks_Products]
GO
ALTER TABLE [dbo].[Timekeeping]  WITH CHECK ADD  CONSTRAINT [FK_Timekeeping_Staff] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Staff] ([StaffID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Timekeeping] CHECK CONSTRAINT [FK_Timekeeping_Staff]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [chk_CusID] CHECK  (([CustomerID] like 'C[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [chk_CusID]
GO
ALTER TABLE [dbo].[Package]  WITH CHECK ADD  CONSTRAINT [chk_PackID] CHECK  (([PackID] like 'P[0-9][0-9]'))
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [chk_PackID]
GO
ALTER TABLE [dbo].[PersonTrainer]  WITH CHECK ADD  CONSTRAINT [chk_PtID] CHECK  (([PtID] like 'PT[0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[PersonTrainer] CHECK CONSTRAINT [chk_PtID]
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD  CONSTRAINT [chk_RepID] CHECK  (([ReceiptID] like 'R[0][0][0]'))
GO
ALTER TABLE [dbo].[Receipt] CHECK CONSTRAINT [chk_RepID]
GO
/****** Object:  StoredProcedure [dbo].[createOrderWithManualDiscounts]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createOrderWithManualDiscounts]
    @CustomerID varchar(4),
    @StaffID varchar(4),
    @OrderDate datetime,
    @TotalAmount decimal(18, 0) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Calculate total amount before applying discounts
    SET @TotalAmount = (
        SELECT SUM(C.Quantity * P.UnitPrice) 
        FROM Cart C
        INNER JOIN Products P ON C.ProductID = P.ProductID AND C.CategoryID = P.CategoryID
        WHERE C.CustomerID = @CustomerID
    );

    -- Update discounts in the cart if they are manually chosen
    -- For example, discounts could be stored in the Discount column in the Cart table
    -- This assumes that discounts are already entered for each item in the cart
    UPDATE Cart
    SET Discount = ISNULL(Discount, 0)
    WHERE CustomerID = @CustomerID;

    -- Calculate total discount amount
    DECLARE @TotalDiscount decimal(18, 0);
	SET @TotalDiscount = (
		SELECT SUM((C.Discount / 100.0) * C.Quantity * P.UnitPrice)
		FROM Cart C
		INNER JOIN Products P ON C.ProductID = P.ProductID AND C.CategoryID = P.CategoryID
		WHERE C.CustomerID = @CustomerID
	);

    -- Subtract total discount amount from total amount
    SET @TotalAmount = @TotalAmount - @TotalDiscount;

    -- Insert into Orders table
    INSERT INTO Orders (CustomerID, StaffID, OrderDate, TotalAmount)
    VALUES (@CustomerID, @StaffID, @OrderDate, @TotalAmount);

    DECLARE @OrderID int;
    SET @OrderID = SCOPE_IDENTITY(); -- Get the newly generated OrderID

    -- Insert into OrderDetails from Cart for the specific customer
    INSERT INTO OrderDetails (OrderID, ProductID, CategoryID, Quantity, UnitPrice, Discount)
    SELECT @OrderID, C.ProductID, C.CategoryID, C.Quantity, P.UnitPrice, C.Discount
    FROM Cart C
    INNER JOIN Products P ON C.ProductID = P.ProductID AND C.CategoryID = P.CategoryID
    WHERE C.CustomerID = @CustomerID;

    -- Clear the cart after creating the order
    DELETE FROM Cart
    WHERE CustomerID = @CustomerID;
END;
GO
/****** Object:  StoredProcedure [dbo].[filterbyCheckinDate]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[filterbyCheckinDate]
	@fromDate datetime,
	@toDate datetime
AS
BEGIN

SELECT c.CustomerID as 'Customer ID'
	  ,c.CustomerName as 'Customer Name'
	  ,CASE
		 WHEN LEN(c.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 3), '-', SUBSTRING(c.[PhoneNumber], 7, 4))
         WHEN LEN(c.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 4), '-', SUBSTRING(c.[PhoneNumber], 8, 4)) 
	     ELSE
              c.[PhoneNumber]
	    END as 'Phone Number'
	  ,p.PackName as 'Pack Name'
	  ,CONVERT(varchar, c.Startdate, 103) as 'Start Date'
	  ,Convert(varchar, dateadd(day, c.DateRegister, c.Startdate), 103) as 'Expiry Date'
	  ,cc.LastDateCheck'Last date check in'
	  ,cc.LastDateCheckOut as 'Last date check out'
FROM dbo.CheckIn_Customer cc
	LEFT JOIN dbo.Customers c on c.CustomerID = cc.CustomerID
	LEFT JOIN dbo.Package p on c.PackID = p.PackID
WHERE cc.LastDateCheck BETWEEN @fromDate and @toDate
ORDER BY c.CustomerID

END
GO
/****** Object:  StoredProcedure [dbo].[filterCustomersData]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[filterCustomersData]
	@fromDate datetime,
	@toDate datetime
as
BEGIN

SELECT c.CustomerID as 'Customer ID'
	  ,c.CustomerName as 'Customer Name'
	  ,c.Gender
	  ,Convert(varchar, c.[DateofBirth], 103) as 'Date of birth'
      ,CASE
		 WHEN LEN(c.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 3), '-', SUBSTRING(c.[PhoneNumber], 7, 4))
         WHEN LEN(c.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 4), '-', SUBSTRING(c.[PhoneNumber], 8, 4)) 
	     ELSE
              c.[PhoneNumber]
	    END as 'Phone'
      ,p.PackName as 'Pack Name'
      ,s.StaffName as 'Saler'
      ,Convert(varchar, c.Startdate, 103) as 'Start Date'
	  ,Convert(varchar, DATEADD(day, c.DateRegister, c.Startdate), 103) as 'Expiry Date'
	  ,c.Note
  FROM Customers c
  JOIN Package p ON c.PackID = p.PackID
  JOIN Staff s ON c.StaffID = s.StaffID
  WHERE c.Startdate BETWEEN @fromDate AND @toDate
  ORDER BY c.CustomerID ASC

END
GO
/****** Object:  StoredProcedure [dbo].[filterProductDataWithDate]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[filterProductDataWithDate]
	@date DATETIME
AS
BEGIN
SET NOCOUNT ON;
SELECT p.ProductID as 'Product_ID', p.CategoryID as 'Category_ID', p.ProductName as 'Product_Name', CAST(pd.PurchaseDate AS Date) as 'Date_Sold', SUM(pd.Amount) as Amount, SUM(pd.TotalAmount) as Total
FROM Products p
RIGHT JOIN dbo.PurchaseDetails pd ON p.ProductID = pd.ProductID
WHERE CAST(pd.PurchaseDate AS Date) = @date
GROUP BY p.ProductID, p.CategoryID, p.ProductName, CAST(pd.PurchaseDate AS Date)
ORDER BY p.ProductID

END
GO
/****** Object:  StoredProcedure [dbo].[getCheckInCustomersData]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[getCheckInCustomersData]
as
BEGIN

SELECT c.CustomerID as 'Customer ID'
	  ,c.CustomerName as 'Customer Name'
	  ,CASE
		 WHEN LEN(c.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 3), '-', SUBSTRING(c.[PhoneNumber], 7, 4))
         WHEN LEN(c.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 4), '-', SUBSTRING(c.[PhoneNumber], 8, 4)) 
	     ELSE
              c.[PhoneNumber]
	    END as 'Phone'
	  ,p.PackName as 'Pack Name'
	  ,CONVERT(varchar, c.Startdate, 103) as 'Start Date'
	  ,Convert(varchar, dateadd(day, c.DateRegister, c.Startdate), 103) as 'Expiry Date'
	  ,cc.LastDateCheck'Last date check in'
	  ,cc.LastDateCheckOut as 'Last date check out'
FROM dbo.CheckIn_Customer cc
	LEFT JOIN dbo.Customers c on c.CustomerID = cc.CustomerID
	LEFT JOIN dbo.Package p on c.PackID = p.PackID
ORDER BY c.CustomerID

END
GO
/****** Object:  StoredProcedure [dbo].[getCustomersData]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getCustomersData]
as
BEGIN

SELECT c.[CustomerID] as 'Customer ID'
      ,c.[CustomerName] as 'Customer Name'
      ,c.[Gender] as 'Gender'
      ,Convert(varchar, c.[DateofBirth], 103) as 'Date of birth'
      ,CASE
		 WHEN LEN(c.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 3), '-', SUBSTRING(c.[PhoneNumber], 7, 4))
         WHEN LEN(c.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 4), '-', SUBSTRING(c.[PhoneNumber], 8, 4)) 
	     ELSE
              c.[PhoneNumber]
	    END as 'Phone'
      ,p.[PackName] as 'Pack Name'
      ,s.[StaffName] as 'Saler'
      ,Convert(varchar, c.[Startdate], 103) as 'Start date'
      ,Convert(varchar, DATEADD(day, c.DateRegister, c.Startdate), 103) as 'Expiry date'
      ,c.[Note]
  FROM [GymFitnessPL].[dbo].[Customers] as c
  inner join Package as p
  on c.PackID = p.PackID
  inner join Staff as s
  on c.StaffID = s.StaffID

END
GO
/****** Object:  StoredProcedure [dbo].[getOrderDetailsResult]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getOrderDetailsResult]
AS
BEGIN
	SELECT od.OrderDetailID as 'LineItemId'
		  ,o.OrderID
		  ,cs.CustomerName
		  ,s.StaffName
		  ,p.ProductName as 'Product'
		  ,c.CategoryName as 'Category'
		  ,od.Quantity
		  ,FORMAT(od.Quantity * od.UnitPrice , 'C0', 'vi-VN') as 'Total'
		  ,o.OrderDate
		  ,od.Discount
	FROM OrderDetails od
	JOIN Orders o ON od.OrderID = o.OrderID
	JOIN Products p ON od.ProductID = p.ProductID AND od.CategoryID = p.CategoryID AND od.UnitPrice = p.UnitPrice
	JOIN Categories c  ON od.CategoryID = c.CategoryID
	JOIN Customers cs ON o.CustomerID = cs.CustomerID
	JOIN Staff s ON s.StaffID = o.StaffID
END;
GO
/****** Object:  StoredProcedure [dbo].[getOrdersResult]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[getOrdersResult]
AS
BEGIN
	SELECT o.OrderID
		  ,c.CustomerName as 'Customer Name'
		  ,s.StaffName as 'Saler'
		  ,FORMAT(o.OrderDate, 'dd/MM/yyyy HH:mm:ss') as 'Order Date'
		  ,FORMAT(o.TotalAmount, 'C0', 'vi-VN') as 'Total'
	FROM Orders o
	JOIN Customers c ON o.CustomerID = c.CustomerID
	JOIN Staff s ON o.StaffID = s.StaffID
END;
GO
/****** Object:  StoredProcedure [dbo].[getPercentDashboard]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[getPercentDashboard]
	@fromDate datetime,
	@toDate datetime
AS
Begin
	with cte as (
         select  c.Startdate as 'Start_date'
				,SUM(p.PackPrice) as 'Total'
				,row_number() over (order by c.Startdate) as rn1
			 from Customers c
			 join dbo.Package p on p.PackID = c.PackID
			 where c.Startdate BETWEEN @fromDate and @toDate
			 group by c.Startdate
	)
        
         Select t1.Start_date 
			   ,t1.Total
			   ,round(coalesce((t1.Total - t2.Total)*1.0/nullif(t2.Total, 0), 0)*100,2)
			from cte t1
            left join cte t2 on t1.rn1 = t2.rn1 + 1

END
GO
/****** Object:  StoredProcedure [dbo].[getPercentDashboardPT]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[getPercentDashboardPT]
	@fromDate datetime,
	@toDate datetime
AS
Begin
	with cte as (
         select  p.Startdate as 'Start_date'
				,SUM(p.TotalPrice) as 'Total'
				,row_number() over (order by p.Startdate) as rn1
			 from PersonTrainer p
			 where p.Startdate BETWEEN @fromDate and @toDate
			 group by p.Startdate
	)
        
         Select t1.Start_date 
			   ,t1.Total
			   ,round(coalesce((t1.Total - t2.Total)*1.0/nullif(t2.Total, 0), 0)*100,2)
			from cte t1
            left join cte t2 on t1.rn1 = t2.rn1 + 1

END
GO
/****** Object:  StoredProcedure [dbo].[getPersonTrainerData]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getPersonTrainerData]
as
BEGIN

SELECT p.[PtID] as 'PT_ID'
      ,s.[StaffName] as 'Coach Trainer'
	  ,c.[CustomerName] as 'Customer Name'
      ,c.[Gender] as 'Gender'
      ,Convert(varchar, c.[DateofBirth], 103) as 'Date of birth'
      ,CASE
		 WHEN LEN(c.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 3), '-', SUBSTRING(c.[PhoneNumber], 7, 4))
         WHEN LEN(c.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(c.[PhoneNumber], 1, 3), ') ', SUBSTRING(c.[PhoneNumber], 4, 4), '-', SUBSTRING(c.[PhoneNumber], 8, 4)) 
	     ELSE
              c.[PhoneNumber]
	    END as 'Phone Number'
      ,Convert(varchar, p.[Startdate], 103) as 'Start date'
	  ,p.[SessionTime] as 'Session time'
	  ,FORMAT(p.[TotalPrice], 'C0', 'vi-VN') as 'Total Price'
      ,p.[Note]
  FROM [GymFitnessPL].[dbo].[PersonTrainer] as p
  inner join Staff as s
  on p.StaffID = s.StaffID
  inner join Customers as c
  on p.CustomerID = c.CustomerID

END
GO
/****** Object:  StoredProcedure [dbo].[getStaffsData]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getStaffsData]
as
BEGIN

SELECT s.[StaffID] as 'Staff ID'
      ,s.[StaffName] as 'Staff Name'
      ,CASE
		 WHEN LEN(s.[PhoneNumber]) = 10 THEN 
              CONCAT('(', SUBSTRING(s.[PhoneNumber], 1, 3), ') ', SUBSTRING(s.[PhoneNumber], 4, 3), '-', SUBSTRING(s.[PhoneNumber], 7, 4))
         WHEN LEN(s.[PhoneNumber]) = 11 THEN 
              CONCAT('(', SUBSTRING(s.[PhoneNumber], 1, 3), ') ', SUBSTRING(s.[PhoneNumber], 4, 4), '-', SUBSTRING(s.[PhoneNumber], 8, 4)) 
	     ELSE
              s.[PhoneNumber]
	    END as 'Phone contact'
      ,s.[Email] as 'Email'
      ,pt.[PositionName] as 'Position'
	  ,s.[Status]
      ,s.[Note]
  FROM [GymFitnessPL].[dbo].[Staff] as s
  left join Positions as pt
  on pt.PositionId = s.PositionId

END
GO
/****** Object:  StoredProcedure [dbo].[getTotalCheckInDate]    Script Date: 11/23/2024 1:14:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[getTotalCheckInDate]
as

select Convert(varchar, LastDateCheck, 103) as 'Last Time Check In', COUNT(CustomerID) as 'Total'
FROM CheckIn_Customer
GROUP BY Convert(varchar, LastDateCheck, 103)

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cart"
            Begin Extent = 
               Top = 177
               Left = 477
               Bottom = 307
               Right = 647
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Categories"
            Begin Extent = 
               Top = 329
               Left = 885
               Bottom = 425
               Right = 1055
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 29
               Left = 97
               Bottom = 159
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Staff"
            Begin Extent = 
               Top = 313
               Left = 115
               Bottom = 443
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 68
               Left = 861
               Bottom = 198
               Right = 1031
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getCartDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getCartDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getCartDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 120
               Left = 79
               Bottom = 250
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 211
               Left = 343
               Bottom = 341
               Right = 513
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 200
               Left = 611
               Bottom = 330
               Right = 781
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 36
               Left = 863
               Bottom = 166
               Right = 1036
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Staff"
            Begin Extent = 
               Top = 301
               Left = 925
               Bottom = 431
               Right = 1095
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Categories"
            Begin Extent = 
               Top = 26
               Left = 362
               Bottom = 122
               Right = 532
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getOrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Categories"
            Begin Extent = 
               Top = 77
               Left = 115
               Bottom = 173
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 31
               Left = 410
               Bottom = 161
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Supplier"
            Begin Extent = 
               Top = 24
               Left = 760
               Bottom = 154
               Right = 933
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getProductInfoDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getProductInfoDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PurchaseDetails"
            Begin Extent = 
               Top = 103
               Left = 855
               Bottom = 291
               Right = 1025
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 72
               Left = 376
               Bottom = 256
               Right = 546
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Categories"
            Begin Extent = 
               Top = 146
               Left = 108
               Bottom = 242
               Right = 278
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1455
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getPurchaseDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_getPurchaseDetails'
GO
USE [master]
GO
ALTER DATABASE [GymFitnessPL] SET  READ_WRITE 
GO
