 DECLARE @Yesterday VARCHAR(8) = CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4)) + RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) + RIGHT('0' + CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2)
 --20210413: string/text/char
MERGE {db}.{schema}.{table_name} AS DST
USING [ORDERS_RELATIONAL_DB].[dbo].[Shippers] AS SRC
ON (SRC.ShipperID_PK = DST.ShipperID_NK)
WHEN NOT MATCHED THEN
INSERT (ShipperID_NK, CompanyName, Phone)
VALUES (SRC.ShipperID_PK, SRC.CompanyName, SRC.Phone)
WHEN MATCHED  -- there can be only one matched case
AND (DST.CompanyName <> SRC.CompanyName
 OR DST.Phone <> SRC.Phone)
THEN 
	UPDATE 
	SET  DST.Phone = SRC.Phone -- simple overwrite
		,DST.CompanyName_Prev = (CASE WHEN DST.CompanyName <> SRC.CompanyName THEN DST.CompanyName ELSE DST.CompanyName_Prev END)
		,DST.CompanyName_Prev_ValidTo = (CASE WHEN DST.CompanyName <> SRC.CompanyName THEN @Yesterday ELSE DST.CompanyName_Prev_ValidTo END);
