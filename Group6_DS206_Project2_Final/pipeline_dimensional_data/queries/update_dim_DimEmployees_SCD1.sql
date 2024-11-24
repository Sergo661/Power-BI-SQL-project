MERGE ORDERS_DIMENSIONAL_DB.dbo.DimEmployees_SCD1 AS DST -- destination
USING ORDERS_RELATIONAL_DB.dbo.Employees AS SRC -- source
ON ( SRC.EmployeeID_PK = DST.EmployeeID_NK )
WHEN NOT MATCHED THEN -- there are IDs in the source table that are not in the destination table
  INSERT (EmployeeID_NK,
          LastName,
          FirstName,
          Title,
          TitleOfCourtesy,
          BirthDate,
          HireDate,
          Address,
          City,
		  Region,
		  PostalCode,
		  Country,
		  HomePhone,
		  Extension,
		  Notes,
		  ReportsTo,
		  PhotoPath)
  VALUES (SRC.EmployeeID_PK,
          SRC.LastName,
          SRC.FirstName,
          SRC.Title,
          SRC.TitleOfCourtesy,
          SRC.BirthDate,
          SRC.HireDate,
          SRC.Address,
          SRC.City,
		  SRC.Region,
		  SRC.PostalCode,
		  SRC.Country,
		  SRC.HomePhone,
		  SRC.Extension,
		  SRC.Notes,
		  SRC.ReportsTo,
		  SRC.PhotoPath)
WHEN MATCHED AND (  -- Isnull - a function that return a specified expression  when encountering null values 
	--Isnull(DST.clientname, '') if DST.clientname == NULL then it will return ''
	Isnull(DST.LastName, '') <> Isnull(SRC.LastName, '') OR
	Isnull(DST.FirstName, '') <> Isnull(SRC.FirstName, '') OR 
	Isnull(DST.Title, '') <> Isnull(SRC.Title, '') OR 
	Isnull(DST.TitleOfCourtesy, '') <> Isnull(SRC.TitleOfCourtesy, '') OR
	Isnull(DST.BirthDate, '') <> Isnull(SRC.BirthDate, '') OR
	Isnull(DST.HireDate, '') <> Isnull(SRC.HireDate, '') OR
	Isnull(DST.Address, '') <> Isnull(SRC.Address, '') OR
	Isnull(DST.City, '') <> Isnull(SRC.City, '') OR
	Isnull(DST.Region, '') <> Isnull(SRC.Region, '') OR
	Isnull(DST.PostalCode, '') <> Isnull(SRC.PostalCode, '') OR
	Isnull(DST.Country, '') <> Isnull(SRC.Country, '') OR
	Isnull(DST.HomePhone, '') <> Isnull(SRC.HomePhone, '') OR
	Isnull(DST.Extension, '') <> Isnull(SRC.Extension, '') OR
	Isnull(DST.Notes, '') <> Isnull(SRC.Notes, '') OR
	Isnull(DST.ReportsTo, '') <> Isnull(SRC.ReportsTo, '') OR
	Isnull(DST.PhotoPath, '') <> Isnull(SRC.PhotoPath, '') )
	THEN
		UPDATE SET DST.LastName = SRC.LastName,
             DST.FirstName = SRC.FirstName,
             DST.Title = SRC.Title,
             DST.TitleOfCourtesy = SRC.TitleOfCourtesy,
             DST.BirthDate = SRC.BirthDate,
             DST.Address = SRC.Address,
             DST.City = SRC.City,
			 DST.Region = SRC.Region,
			 DST.PostalCode = SRC.PostalCode,
			 DST.Country = SRC.Country,
			 DST.HomePhone = SRC.HomePhone,
			 DST.Extension = SRC.Extension,
			 DST.Notes = SRC.Notes,
			 DST.ReportsTo = SRC.ReportsTo,
			 DST.PhotoPath = SRC.PhotoPath;