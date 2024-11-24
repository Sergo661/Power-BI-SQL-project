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
   {db}.{schema}.{table_name} ([TerritoryID_NK], [TerritoryDescription], [RegionID_NK_FK], [RegionID_SK_FK], ValidFrom, IsCurrent) 
   SELECT
      TerritoryID_PK,
      TerritoryDescription,
      RegionID_FK,
      RegionID_SK_PK,
      @Today,
      1 
   FROM
      (
         -- Merge statement
         MERGE INTO ORDERS_DIMENSIONAL_DB.dbo.DimTerritories_SCD2 AS DST
		 USING
			(SELECT
				t.TerritoryID_PK,
				t.TerritoryDescription,
				t.RegionID_FK,
				r.RegionID_SK_PK
			FROM ORDERS_RELATIONAL_DB.dbo.Territories as t
			JOIN ORDERS_DIMENSIONAL_DB.dbo.DimRegion_SCD2 as r on t.RegionID_FK = r.RegionID_NK
			) as SRC
         ON (SRC.TerritoryID_PK = DST.TerritoryID_NK) 			
		 -- New records inserted
         WHEN
            NOT MATCHED 
         THEN
            INSERT (TerritoryID_NK, [TerritoryDescription], [RegionID_NK_FK], [RegionID_SK_FK], ValidFrom, IsCurrent) --There is no ValidTo
      VALUES
         (
            SRC.TerritoryID_PK, SRC.[TerritoryDescription], SRC.RegionID_FK, SRC.RegionID_SK_PK, @Today, 1
         )
         -- Existing records updated if data changes
      WHEN
         MATCHED 
         AND IsCurrent = 1 
         AND 
         (
            ISNULL(DST.TerritoryID_NK, '') <> ISNULL(SRC.TerritoryID_PK, '') 
            OR ISNULL(DST.[TerritoryDescription], '') <> ISNULL(SRC.[TerritoryDescription], '') 
            OR ISNULL(DST.[RegionID_NK_FK], '') <> ISNULL(SRC.RegionID_FK, '') 
            OR ISNULL(DST.[RegionID_SK_FK], '') <> ISNULL(SRC.RegionID_SK_PK, '') 
         )
         -- Update statement for a changed dimension record, to flag as no longer active
      THEN
         UPDATE
         SET
            DST.IsCurrent = 0, 
			DST.ValidTo = @Yesterday 
			OUTPUT SRC.TerritoryID_PK, SRC.[TerritoryDescription], SRC.RegionID_FK, SRC.RegionID_SK_PK, $Action AS MergeAction 
      )
      AS MRG 
   WHERE
      MRG.MergeAction = 'UPDATE' ;
