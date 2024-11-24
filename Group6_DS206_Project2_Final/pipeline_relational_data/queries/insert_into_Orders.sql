INSERT INTO {db}.{schema}.Orders
    ([OrderID_PK],[CustomerID_FK],[EmployeeID_FK],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia_FK],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode],[ShipCountry],[TerritoryID_FK])
    values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)