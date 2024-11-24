
MERGE INTO {db}.{schema}.{table_name} AS target
USING
    (SELECT
        r.OrderID_PK,
		r.CustomerID_FK,
        dc.CustomerID_SK_PK,
		r.EmployeeID_FK,
        de.EmployeeID_SK_PK,
        r.OrderDate,
        r.RequiredDate,
        r.ShippedDate,
		r.Shipvia_FK,
        ds.ShipperID_SK_PK,
        r.Freight,
		rd.ProductID_FK,
        dp.ProductID_SK_PK,
        r.ShipCity,
        r.ShipCountry,
        r.ShipRegion,
        r.ShipPostalCode,
        r.ShipAddress,
        rd.UnitPrice,
        rd.Quantity,
        rd.Discount
     FROM ORDERS_RELATIONAL_DB.dbo.Orders AS r
     JOIN ORDERS_RELATIONAL_DB.dbo.OrderDetails AS rd ON r.OrderID_PK = rd.OrderID_FK
     JOIN ORDERS_DIMENSIONAL_DB.dbo.DimCustomers_SCD4_1 AS dc ON r.CustomerID_FK = dc.CustomerID_NK
     JOIN ORDERS_DIMENSIONAL_DB.dbo.DimEmployees_SCD1 AS de ON r.EmployeeID_FK = de.EmployeeID_NK
     JOIN ORDERS_DIMENSIONAL_DB.dbo.DimShippers_SCD3 AS ds ON r.ShipVia_FK = ds.ShipperID_NK
     JOIN ORDERS_DIMENSIONAL_DB.dbo.DimProducts_SCD4_1 AS dp ON rd.ProductID_FK = dp.ProductID_NK
    ) AS source
ON (target.OrderID_NK = source.OrderID_PK AND target.ProductID_NK_FK = source.ProductID_FK)
WHEN MATCHED THEN
    UPDATE SET
        target.CustomerID_SK_FK = source.CustomerID_SK_PK,
		target.CustomerID_NK_FK = source.CustomerID_FK,
        target.EmployeeID_SK_FK = source.EmployeeID_SK_PK,
		target.EmployeeID_NK_FK = source.EmployeeID_FK,
        target.OrderDate = source.OrderDate,
        target.RequiredDate = source.RequiredDate,
        target.ShippedDate = source.ShippedDate,
        target.[ShipVia_SK_FK] = source.ShipperID_SK_PK,
		target.[ShipVia_NK_FK] = source.Shipvia_FK,
        target.ShipAddress = source.ShipAddress,
        target.ShipCity = source.ShipCity,
        target.ShipCountry = source.ShipCountry,
        target.ShipRegion = source.ShipRegion,
        target.ShipPostalCode = source.ShipPostalCode,
        target.Freight = source.Freight,
        target.UnitPrice = source.UnitPrice,
        target.Quantity = source.Quantity,
        target.Discount = source.Discount
WHEN NOT MATCHED BY TARGET THEN
    INSERT (OrderID_NK, CustomerID_SK_FK, CustomerID_NK_FK, EmployeeID_SK_FK, EmployeeID_NK_FK, OrderDate, RequiredDate, ShippedDate, [ShipVia_SK_FK], [ShipVia_NK_FK], Freight, UnitPrice,Quantity, Discount,ShipAddress,ShipCity,ShipCountry,ShipRegion,ShipPostalCode)
    VALUES (source.OrderID_PK, source.CustomerID_SK_PK, source.CustomerID_FK, source.EmployeeID_SK_PK, source.EmployeeID_FK, source.OrderDate, source.RequiredDate, source.ShippedDate, source.ShipperID_SK_PK, source.Shipvia_FK, source.Freight, source.UnitPrice, source.Quantity,source.Discount,source.ShipAddress,source.ShipCity,source.ShipCountry,source.ShipRegion,source.ShipPostalCode);