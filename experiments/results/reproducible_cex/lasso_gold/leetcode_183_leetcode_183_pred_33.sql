-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("id", "name") VALUES (1012, 'Cristian Santos');
INSERT INTO "customers" ("id", "name") VALUES (1014, 'Cristian Santos');
INSERT INTO "customers" ("id", "name") VALUES (1016, 'Connie Lawrence');
INSERT INTO "orders" ("id", "customerid") VALUES (1015, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT T1.ID, T1.NAME FROM CUSTOMERS AS T1 JOIN ORDERS AS T2 ON T1.ID = T2.CUSTOMERID) SELECT T1.NAME AS CUSTOMERS FROM CUSTOMERS AS T1 LEFT JOIN CTE AS T2 ON T1.ID = T2.ID WHERE T2.ID IS NULL;

/*
Prediction Result:
('Cristian Santos',)
('Cristian Santos',)
('Connie Lawrence',)
*/