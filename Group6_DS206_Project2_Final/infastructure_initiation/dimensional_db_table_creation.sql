CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimCategories_SCD1_with_delete] (
	[CategoryID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [CategoryID_NK] INT NOT NULL,
    [CategoryName] VARCHAR(255),
    [Description] VARCHAR(255)
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimCustomers_SCD4_History] (
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID_NK] VARCHAR(255) NULL,
    [CompanyName] VARCHAR(255),
    [ContactName] VARCHAR(255),
    [ContactTitle] VARCHAR(255),
    [Address] VARCHAR(255),
    [City] VARCHAR(255),
    [Region] VARCHAR(255),
    [PostalCode] VARCHAR(255),
    [Country] VARCHAR(255),
    [Phone] VARCHAR(255),
    [Fax] VARCHAR(255),
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimCustomers_SCD4_1] (
	[CustomerID_SK_PK] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID_NK] VARCHAR(255) NOT NULL,
    [CompanyName] VARCHAR(255),
    [ContactName] VARCHAR(255),
    [ContactTitle] VARCHAR(255),
    [Address] VARCHAR(255),
    [City] VARCHAR(255),
    [Region] VARCHAR(255),
    [PostalCode] VARCHAR(255),
    [Country] VARCHAR(255),
    [Phone] VARCHAR(255),
    [Fax] VARCHAR(255),
	[ValidFrom] [datetime] DEFAULT  current_timestamp
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimEmployees_SCD1] (
	[EmployeeID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [EmployeeID_NK] INT NOT NULL,
    [LastName] VARCHAR(255),
    [FirstName] VARCHAR(255),
    [Title] VARCHAR(255),
    [TitleOfCourtesy] VARCHAR(255),
    [BirthDate] DATETIME,
    [HireDate] DATETIME,
    [Address] VARCHAR(255),
    [City] VARCHAR(255),
    [Region] VARCHAR(255),
    [PostalCode] VARCHAR(255),
    [Country] VARCHAR(255),
    [HomePhone] VARCHAR(255),
    [Extension] VARCHAR(255),
    [Notes] VARCHAR(500),
    [ReportsTo] INT,
    [PhotoPath] VARCHAR(255)
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimSuppliers_SCD3] (
	[SupplierID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [SupplierID_NK] INT NOT NULL,
    [CompanyName] VARCHAR(255),
    [ContactName] VARCHAR(255),
    [ContactTitle] VARCHAR(255),
    [Address] VARCHAR(255),
    [City] VARCHAR(255),
    [Region] VARCHAR(255),
    [PostalCode] VARCHAR(255),
    [Country] VARCHAR(255),
    [Phone] VARCHAR(255),
    [Fax] VARCHAR(255),
    [HomePage] VARCHAR(255),
	[CompanyName_Prev] VARCHAR(255),
	[CompanyName_Prev_ValidTo] [char](8) NULL,
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimShippers_SCD3] (
	[ShipperID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [ShipperID_NK] INT NOT NULL,
    [CompanyName] VARCHAR(255),
    [Phone] VARCHAR(255),
	[CompanyName_Prev] VARCHAR(255),
	[CompanyName_Prev_ValidTo] [char](8) NULL,
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimRegion_SCD2] (
	[RegionID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [RegionID_NK] INT NOT NULL,
    [RegionDescription] VARCHAR(255),
	ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimProducts_SCD4_History] (
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID_NK] INT NULL,
    [ProductName] VARCHAR(255),
    [SupplierID_NK_FK] INT,
	[SupplierID_SK_FK] INT,
    [CategoryID_NK_FK] INT,
	[CategoryID_SK_FK] INT,
    [QuantityPerUnit] VARCHAR(255),
    [UnitPrice] FLOAT,
    [UnitsInStock] INT,
    [UnitsOnOrder] INT,
    [ReorderLevel] INT,
    [Discontinued] VARCHAR(255),
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimProducts_SCD4_1] (
	[ProductID_SK_PK] [int] IDENTITY(1,1) NOT NULL,
    [ProductID_NK] INT NOT NULL,
    [ProductName] VARCHAR(255),
    [SupplierID_NK_FK] INT,
	[SupplierID_SK_FK] INT,
    [CategoryID_NK_FK] INT,
	[CategoryID_SK_FK] INT,
    [QuantityPerUnit] VARCHAR(255),
    [UnitPrice] FLOAT,
    [UnitsInStock] INT,
    [UnitsOnOrder] INT,
    [ReorderLevel] INT,
    [Discontinued] VARCHAR(255),
	[ValidFrom] [datetime] DEFAULT  current_timestamp
);


CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[DimTerritories_SCD2] (
	[TerritoryID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [TerritoryID_NK] VARCHAR(255) NOT NULL,
    [TerritoryDescription] VARCHAR(255),
    [RegionID_NK_FK] INT,
	[RegionID_SK_FK] INT,
	ValidFrom INT NULL,
	ValidTo INT NULL,
	IsCurrent BIT NULL
);

CREATE TABLE [ORDERS_DIMENSIONAL_DB].[dbo].[FactOrders] (
	[OrderID_SK_PK] INT IDENTITY(1,1) NOT NULL,
    [OrderID_NK] INT NOT NULL,
    [CustomerID_NK_FK] VARCHAR(255),
	[CustomerID_SK_FK] VARCHAR(255),
    [EmployeeID_NK_FK] INT,
	[EmployeeID_SK_FK] INT,
    [OrderDate] DATETIME,
    [RequiredDate] DATETIME,
    [ShippedDate] DATETIME,
    [ShipVia_NK_FK] INT,
	[ShipVia_SK_FK] INT,
    [Freight] FLOAT,
    [ShipName] VARCHAR(255),
    [ShipAddress] VARCHAR(255),
    [ShipCity] VARCHAR(255),
    [ShipRegion] VARCHAR(255),
    [ShipPostalCode] VARCHAR(255),
    [ShipCountry] VARCHAR(255),
    [TerritoryID_NK_FK] VARCHAR(255),
	[TerritoryID_SK_FK] VARCHAR(255),
	[ProductID_NK_FK] INT,
	[ProductID_SK_FK] INT ,
    [UnitPrice] FLOAT,
    [Quantity] INT,
    [Discount] FLOAT
);
