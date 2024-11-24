-- Add Primary Key Constraints
ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Categories] 
    ADD CONSTRAINT PK_Categories PRIMARY KEY (CategoryID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Customers]
    ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Employees]
    ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails]
    ADD CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID_FK, ProductID_FK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders]
    ADD CONSTRAINT PK_Orders PRIMARY KEY (OrderID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Products]
    ADD CONSTRAINT PK_Products PRIMARY KEY (ProductID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Region]
    ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Shippers]
    ADD CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Suppliers]
    ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Territories]
    ADD CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID_PK);
GO

-- Add Foreign Key Constraints
ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Employees]
    ADD CONSTRAINT FK_Employees_ReportsTo FOREIGN KEY (ReportsTo) REFERENCES dbo.Employees (EmployeeID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails]
    ADD CONSTRAINT FK_OrderDetails_OrderID FOREIGN KEY (OrderID_FK) REFERENCES dbo.Orders (OrderID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[OrderDetails]
    ADD CONSTRAINT FK_OrderDetails_ProductID FOREIGN KEY (ProductID_FK) REFERENCES dbo.Products (ProductID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders]
    ADD CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID_FK) REFERENCES dbo.Customers (CustomerID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders]
    ADD CONSTRAINT FK_Orders_EmployeeID FOREIGN KEY (EmployeeID_FK) REFERENCES dbo.Employees (EmployeeID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders]
    ADD CONSTRAINT FK_Orders_ShipVia FOREIGN KEY (ShipVia_FK) REFERENCES dbo.Shippers (ShipperID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Orders]
    ADD CONSTRAINT FK_Orders_TerritoryID FOREIGN KEY (TerritoryID_FK) REFERENCES dbo.Territories (TerritoryID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Products]
    ADD CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID_FK) REFERENCES dbo.Categories (CategoryID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Products]
    ADD CONSTRAINT FK_Products_SupplierID FOREIGN KEY (SupplierID_FK) REFERENCES dbo.Suppliers (SupplierID_PK);
GO

ALTER TABLE [ORDERS_RELATIONAL_DB].[dbo].[Territories]
    ADD CONSTRAINT FK_Territories_RegionID FOREIGN KEY (RegionID_FK) REFERENCES dbo.Region (RegionID_PK);
GO