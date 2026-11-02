-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (2, 'default1'), (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS AS C WHERE NOT ID IN (SELECT CUSTOMERID FROM ORDERS) ORDER BY 1, C.id NULLS LAST;

/*
Prediction Result:
(None,)
('default1',)
*/