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
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID GROUP BY C.ID HAVING COUNT(O.CUSTOMERID) < 1;

/*
Prediction Result:
('Cristian Santos',)
('Cristian Santos',)
('Connie Lawrence',)
*/