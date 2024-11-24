-- Define the dates used in validity - assume whole 24 hour cycles
DECLARE @Yesterday INT =  --20210412 = 2021 * 10000 + 4 * 100 + 12
(
   YEAR(DATEADD(dd, - 1, GETDATE())) * 10000
)
+ (MONTH(DATEADD(dd, - 1, GETDATE())) * 100) + DAY(DATEADD(dd, - 1, GETDATE())) 
DECLARE @Today INT = --20210413 = 2021 * 10000 + 4 * 100 + 13
(
   YEAR(GETDATE()) * 10000
)
+ (MONTH(GETDATE()) * 100) + DAY(GETDATE()) -- Outer insert - the updated records are added to the SCD2 table
INSERT INTO
   {db}.{schema}.{table_name} (RegionID_NK, RegionDescription, ValidFrom, IsCurrent) 
   SELECT
      RegionID_PK,
      RegionDescription,
      @Today,
      1 
   FROM
      (
         -- Merge statement
         MERGE INTO [ORDERS_DIMENSIONAL_DB].dbo.DimRegion_SCD2 AS DST 
		 USING [ORDERS_RELATIONAL_DB].[dbo].[Region] AS SRC 
         ON (SRC.RegionID_PK = DST.RegionID_NK) 			
		 -- New records inserted
         WHEN
            NOT MATCHED 
         THEN
            INSERT (RegionID_NK, RegionDescription, ValidFrom, IsCurrent) --There is no ValidTo
      VALUES
         (
            SRC.RegionID_PK, SRC.RegionDescription, @Today, 1
         )
         -- Existing records updated if data changes
      WHEN
         MATCHED 
         AND IsCurrent = 1 
         AND 
         (
            ISNULL(DST.RegionDescription, '') <> ISNULL(SRC.RegionDescription, '')  
         )
         -- Update statement for a changed dimension record, to flag as no longer active
      THEN
         UPDATE
         SET
            DST.IsCurrent = 0, 
			DST.ValidTo = @Yesterday 
			OUTPUT SRC.RegionID_PK, SRC.RegionDescription, $Action AS MergeAction 
      )
      AS MRG 
   WHERE
      MRG.MergeAction = 'UPDATE'