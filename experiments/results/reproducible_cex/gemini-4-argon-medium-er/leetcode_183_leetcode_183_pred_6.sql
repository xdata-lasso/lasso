-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("Id", "Name") VALUES (1, 'Alice');
INSERT INTO "Orders" ("Id", "CustomerId") VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS AS C WHERE NOT C.ID IN (SELECT X.ID FROM CUSTOMERS AS X INNER JOIN ORDERS AS R ON R.CUSTOMERID = X.ID);

/*
Prediction Result:
('Alice',)
*/