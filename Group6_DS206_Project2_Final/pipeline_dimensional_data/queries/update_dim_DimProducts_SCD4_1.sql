
--DECLARE @Yesterday INT =  (YEAR(DATEADD(dd,-1,GETDATE())) * 10000) + (MONTH(DATEADD(dd,-1,GETDATE())) * 100) + DAY(DATEADD(dd,-1,GETDATE()))
--DECLARE @Today INT =  (YEAR(GETDATE()) * 10000) + (MONTH(GETDATE()) * 100) + DAY(GETDATE())
DECLARE  @Products_SCD4 TABLE
(
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
	[ValidFrom] [datetime] DEFAULT  current_timestamp,
	[MergeAction] [varchar](10) NULL
)

MERGE INTO		{db}.{schema}.{table_name}				AS DST
USING
	(SELECT
		r.ProductID_PK,
		r.ProductName,
		r.SupplierID_FK,
		s.SupplierID_SK_PK,
		r.CategoryID_FK,
		c.CategoryID_SK_PK,
		r.QuantityPerUnit,
		r.UnitPrice,
		r.UnitsInStock,
		r.UnitsOnOrder,
		r.ReorderLevel,
		r.Discontinued
	FROM [ORDERS_RELATIONAL_DB].[dbo].[Products] as r
	JOIN [ORDERS_DIMENSIONAL_DB].[dbo].[DimSuppliers_SCD3] as s ON r.SupplierID_FK = s.SupplierID_NK
	JOIN [ORDERS_DIMENSIONAL_DB].[dbo].[DimCategories_SCD1_with_delete] as c ON r.CategoryID_FK = c.CategoryID_NK
	) as SRC
ON			(SRC.ProductID_PK = DST.ProductID_NK)

WHEN NOT MATCHED THEN

INSERT (ProductID_NK, ProductName, [SupplierID_NK_FK], [SupplierID_SK_FK], [CategoryID_NK_FK], [CategoryID_SK_FK], [QuantityPerUnit], UnitPrice, UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom)
VALUES (SRC.ProductID_PK, SRC.ProductName, SRC.SupplierID_FK, SRC.SupplierID_SK_PK, SRC.CategoryID_FK, SRC.CategoryID_SK_PK, SRC.QuantityPerUnit, SRC.UnitPrice, SRC.UnitsInStock,SRC.UnitsOnOrder,SRC.ReorderLevel,SRC.Discontinued,DEFAULT)

WHEN MATCHED 
AND		
	 ISNULL(DST.ProductName,'') <> ISNULL(SRC.ProductName,'')  
	 OR ISNULL(DST.[SupplierID_NK_FK],'') <> ISNULL(SRC.SupplierID_FK,'') 
	 OR ISNULL(DST.[SupplierID_SK_FK],'') <> ISNULL(SRC.SupplierID_SK_PK,'')
	 OR ISNULL(DST.[CategoryID_NK_FK],'') <> ISNULL(SRC.CategoryID_FK,'')
	 OR ISNULL(DST.[CategoryID_SK_FK],'') <> ISNULL(SRC.CategoryID_SK_PK,'')
	 OR ISNULL(DST.QuantityPerUnit,'') <> ISNULL(SRC.QuantityPerUnit,'')
	 OR ISNULL(DST.UnitPrice,'') <> ISNULL(SRC.UnitPrice,'')
	 OR ISNULL(DST.UnitsInStock,'') <> ISNULL(SRC.UnitsInStock,'')
	 OR ISNULL(DST.UnitsOnOrder,'') <> ISNULL(SRC.UnitsOnOrder,'')
	 OR ISNULL(DST.ReorderLevel,'') <> ISNULL(SRC.ReorderLevel,'')
	 OR ISNULL(DST.Discontinued,'') <> ISNULL(SRC.Discontinued,'')
THEN UPDATE 

SET			 
	 DST.ProductName = SRC.ProductName  
	 ,DST.[SupplierID_NK_FK] = SRC.SupplierID_FK 
	 ,DST.[SupplierID_SK_FK] = SRC.SupplierID_SK_PK
	 ,DST.[CategoryID_NK_FK] = SRC.CategoryID_FK
	 ,DST.[CategoryID_SK_FK] = SRC.CategoryID_SK_PK
	 ,DST.QuantityPerUnit = SRC.QuantityPerUnit
	 ,DST.UnitPrice = SRC.UnitPrice
	 ,DST.UnitsInStock = SRC.UnitsInStock
	 ,DST.UnitsOnOrder = SRC.UnitsOnOrder
	 ,DST.ReorderLevel = SRC.ReorderLevel
	 ,DST.Discontinued = SRC.Discontinued

OUTPUT DELETED.ProductID_NK, DELETED.ProductName, DELETED.[SupplierID_NK_FK], DELETED.[SupplierID_SK_FK], DELETED.[CategoryID_NK_FK], DELETED.[CategoryID_SK_FK], DELETED.QuantityPerUnit, DELETED.UnitPrice,DELETED.UnitsInStock,DELETED.UnitsOnOrder,DELETED.ReorderLevel,DELETED.Discontinued, DELETED.ValidFrom, $Action AS MergeAction
INTO	@Products_SCD4 (ProductID_NK, ProductName, [SupplierID_NK_FK], [SupplierID_SK_FK], [CategoryID_NK_FK], [CategoryID_SK_FK], QuantityPerUnit, UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom, MergeAction)
;

-- Update history table to set final date and current flag

UPDATE		TP4

SET			TP4.ValidTo = CONVERT (DATE, GETDATE())

FROM		dbo.DimProducts_SCD4_History TP4
			INNER JOIN @Products_SCD4 TMP
			ON TP4.ProductID_NK = TMP.ProductID_NK

WHERE		TP4.ValidTo IS NULL


-- Add latest history records to history table

INSERT INTO dbo.DimProducts_SCD4_History (ProductID_NK, ProductName, [SupplierID_NK_FK], [SupplierID_SK_FK], [CategoryID_NK_FK], [CategoryID_SK_FK], QuantityPerUnit, UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom, ValidTo)

SELECT ProductID_NK, ProductName, [SupplierID_NK_FK], [SupplierID_SK_FK], [CategoryID_NK_FK], [CategoryID_SK_FK], QuantityPerUnit, UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued, ValidFrom, GETDATE()
FROM @Products_SCD4
WHERE ProductID_NK IS NOT NULL