INSERT INTO {db}.{schema}.Products
    ([ProductID_PK],[ProductName],[SupplierID_FK],[CategoryID_FK],[QuantityPerUnit],[UnitPrice],[UnitsInStock],[UnitsOnOrder],[ReorderLevel],[Discontinued])
    values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);