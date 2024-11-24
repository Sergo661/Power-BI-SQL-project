
--DECLARE @Yesterday INT =  (YEAR(DATEADD(dd,-1,GETDATE())) * 10000) + (MONTH(DATEADD(dd,-1,GETDATE())) * 100) + DAY(DATEADD(dd,-1,GETDATE()))
--DECLARE @Today INT =  (YEAR(GETDATE()) * 10000) + (MONTH(GETDATE()) * 100) + DAY(GETDATE())
DECLARE  @Customers_SCD4 TABLE
(
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
	[ValidFrom] [datetime] DEFAULT  current_timestamp,
	[MergeAction] [varchar](10) NULL
) 

MERGE		{db}.{schema}.{table_name}					AS DST
USING		[ORDERS_RELATIONAL_DB].[dbo].Customers				AS SRC
ON			(SRC.CustomerID_PK = DST.CustomerID_NK)

WHEN NOT MATCHED THEN

INSERT ([CustomerID_NK], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode],[Country],[Phone],[Fax],[ValidFrom])
VALUES (SRC.CustomerID_PK, SRC.[CompanyName], SRC.[ContactName], SRC.[ContactTitle], SRC.[Address], SRC.[City], SRC.[Region], SRC.[PostalCode],SRC.[Country],SRC.[Phone],SRC.[Fax], DEFAULT)

WHEN MATCHED 
AND		
	 ISNULL(DST.[CompanyName],'') <> ISNULL(SRC.[CompanyName],'')  
	 OR ISNULL(DST.[ContactName],'') <> ISNULL(SRC.[ContactName],'') 
	 OR ISNULL(DST.[ContactTitle],'') <> ISNULL(SRC.[ContactTitle],'')
	 OR ISNULL(DST.[Address],'') <> ISNULL(SRC.[Address],'')
	 OR ISNULL(DST.[City],'') <> ISNULL(SRC.[City],'')
	 OR ISNULL(DST.[Region],'') <> ISNULL(SRC.[Region],'')
	 OR ISNULL(DST.[PostalCode],'') <> ISNULL(SRC.[PostalCode],'')
	 OR ISNULL(DST.[Country],'') <> ISNULL(SRC.[Country],'')
	 OR ISNULL(DST.[Phone],'') <> ISNULL(SRC.[Phone],'')
	 OR ISNULL(DST.[Fax],'') <> ISNULL(SRC.[Fax],'')
THEN UPDATE 

SET			 
	 DST.[CompanyName] = SRC.[CompanyName]  
	 ,DST.[ContactName] = SRC.[ContactName] 
	 ,DST.[ContactTitle] = SRC.[ContactTitle]
	 ,DST.[Address] = SRC.[Address]
	 ,DST.[City] = SRC.[City]
	 ,DST.[Region] = SRC.[Region]
	 ,DST.[PostalCode] = SRC.[PostalCode]
	 ,DST.[Country] = SRC.[Country]
	 ,DST.[Phone] = SRC.[Phone]
	 ,DST.[Fax] = SRC.[Fax]

OUTPUT DELETED.[CustomerID_NK], DELETED.[CompanyName], DELETED.[ContactName], DELETED.[ContactTitle], DELETED.[Address], DELETED.[City], DELETED.[Region], DELETED.[PostalCode], DELETED.[Country],DELETED.[Phone],DELETED.[Fax],DELETED.ValidFrom, $Action AS MergeAction
INTO	@Customers_SCD4 ([CustomerID_NK], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country],[Phone],[Fax],ValidFrom, MergeAction)
;
UPDATE		TP4

SET			TP4.ValidTo = CONVERT (DATE, GETDATE())

FROM		dbo.DimCustomers_SCD4_History TP4
			INNER JOIN @Customers_SCD4 TMP
			ON TP4.CustomerID_NK = TMP.CustomerID_NK

WHERE		TP4.ValidTo IS NULL

INSERT INTO dbo.DimCustomers_SCD4_History ([CustomerID_NK], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone],[Fax], ValidFrom, ValidTo)

SELECT [CustomerID_NK], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone],[Fax],ValidFrom, GETDATE()
FROM @Customers_SCD4
WHERE CustomerID_NK IS NOT NULL