CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Categories] (
    [CategoryID_PK] INT NOT NULL,
    [CategoryName] VARCHAR(255),
    [Description] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Customers] (
    [CustomerID_PK] VARCHAR(255) NOT NULL,
    [CompanyName] VARCHAR(255),
    [ContactName] VARCHAR(255),
    [ContactTitle] VARCHAR(255),
    [Address] VARCHAR(255),
    [City] VARCHAR(255),
    [Region] VARCHAR(255),
    [PostalCode] VARCHAR(255),
    [Country] VARCHAR(255),
    [Phone] VARCHAR(255),
    [Fax] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Employees] (
    [EmployeeID_PK] INT NOT NULL,
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

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails] (
    [OrderID_FK] INT NOT NULL,
    [ProductID_FK] INT NOT NULL,
    [UnitPrice] FLOAT,
    [Quantity] INT,
    [Discount] FLOAT
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders] (
    [OrderID_PK] INT NOT NULL,
    [CustomerID_FK] VARCHAR(255),
    [EmployeeID_FK] INT,
    [OrderDate] DATETIME,
    [RequiredDate] DATETIME,
    [ShippedDate] DATETIME,
    [ShipVia_FK] INT,
    [Freight] FLOAT,
    [ShipName] VARCHAR(255),
    [ShipAddress] VARCHAR(255),
    [ShipCity] VARCHAR(255),
    [ShipRegion] VARCHAR(255),
    [ShipPostalCode] VARCHAR(255),
    [ShipCountry] VARCHAR(255),
    [TerritoryID_FK] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Products] (
    [ProductID_PK] INT NOT NULL,
    [ProductName] VARCHAR(255),
    [SupplierID_FK] INT,
    [CategoryID_FK] INT,
    [QuantityPerUnit] VARCHAR(255),
    [UnitPrice] FLOAT,
    [UnitsInStock] INT,
    [UnitsOnOrder] INT,
    [ReorderLevel] INT,
    [Discontinued] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Region] (
    [RegionID_PK] INT NOT NULL,
    [RegionDescription] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Shippers] (
    [ShipperID_PK] INT NOT NULL,
    [CompanyName] VARCHAR(255),
    [Phone] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Suppliers] (
    [SupplierID_PK] INT NOT NULL,
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
    [HomePage] VARCHAR(255)
);

CREATE TABLE [ORDERS_RELATIONAL_DB].[dbo].[Territories] (
    [TerritoryID_PK] VARCHAR(255) NOT NULL,
    [TerritoryDescription] VARCHAR(255),
    [RegionID_FK] INT
);