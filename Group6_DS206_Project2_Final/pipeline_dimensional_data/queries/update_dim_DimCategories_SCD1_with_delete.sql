MERGE {db}.{schema}.{table_name} AS TARGET
USING [ORDERS_RELATIONAL_DB].[dbo].[Categories] AS SOURCE 
ON (TARGET.CategoryID_NK = SOURCE.CategoryID_PK) 
--When records are matched, update the records if there is any change
WHEN MATCHED AND TARGET.CategoryName <> SOURCE.CategoryName OR TARGET.Description <> SOURCE.Description
THEN UPDATE SET TARGET.CategoryName = SOURCE.CategoryName, TARGET.Description = SOURCE.Description 
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT (CategoryID_NK, CategoryName, Description) VALUES (SOURCE.CategoryID_PK, SOURCE.CategoryName, SOURCE.Description)
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE 
--$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
--one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
OUTPUT $action, 
DELETED.CategoryID_NK AS TargetCategoryID, 
DELETED.CategoryName AS TargetCategoryName, 
DELETED.Description AS TargetDescription, 
INSERTED.CategoryID_NK AS SourceCategoryID, 
INSERTED.CategoryName AS SourceCategoryName, 
INSERTED.Description AS SourceDescription; 

SELECT @@ROWCOUNT;