 DECLARE @Yesterday VARCHAR(8) = CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4)) + RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) + RIGHT('0' + CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2)
 --20210413: string/text/char
MERGE {db}.{schema}.{table_name} AS DST
USING [ORDERS_RELATIONAL_DB].[dbo].[Suppliers] AS SRC
ON (SRC.SupplierID_PK = DST.SupplierID_NK)
WHEN NOT MATCHED THEN
INSERT (SupplierID_NK, [CompanyName], [ContactName],[ContactTitle],[Address],[City],[Region],[PostalCode],[Country],[Phone],[Fax],[HomePage])
VALUES (SRC.SupplierID_PK, SRC.[CompanyName], SRC.[ContactName],SRC.[ContactTitle],SRC.[Address],SRC.[City],SRC.[Region],SRC.[PostalCode],SRC.[Country],SRC.[Phone],SRC.[Fax],SRC.[HomePage])
WHEN MATCHED  -- there can be only one matched case
AND (DST.[CompanyName] <> SRC.[CompanyName]
OR DST.[ContactName] <> SRC.[ContactName]
OR DST.[ContactTitle] <> SRC.[ContactTitle]
OR DST.[Address] <> SRC.[Address]
OR DST.[City] <> SRC.[City]
OR DST.[Region] <> SRC.[Region]
OR DST.[PostalCode] <> SRC.[PostalCode]
OR DST.[Country] <> SRC.[Country]
OR DST.[Phone] <> SRC.[Phone]
OR DST.[Fax] <> SRC.[Fax]
OR DST.[HomePage] <> SRC.[HomePage]
 )
THEN 
	UPDATE 
	SET  DST.[ContactName] = SRC.[ContactName] -- simple overwrite
		,DST.[ContactTitle] = SRC.[ContactTitle]
		,DST.[Address] = SRC.[Address]
		,DST.[City] = SRC.[City]
		,DST.[Region] = SRC.[Region]
		,DST.[PostalCode] = SRC.[PostalCode]
		,DST.[Country] = SRC.[Country]
		,DST.[Phone] = SRC.[Phone]
		,DST.[Fax] = SRC.[Fax]
		,DST.[HomePage] = SRC.[HomePage]
		,DST.CompanyName_Prev = (CASE WHEN DST.[CompanyName] <> SRC.[CompanyName] THEN DST.Country ELSE DST.CompanyName_Prev END)
		,DST.CompanyName_Prev_ValidTo = (CASE WHEN DST.[CompanyName] <> SRC.[CompanyName] THEN @Yesterday ELSE DST.CompanyName_Prev_ValidTo END);