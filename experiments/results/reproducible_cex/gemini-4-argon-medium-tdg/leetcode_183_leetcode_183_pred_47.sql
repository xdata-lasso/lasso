-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (Id, Name) VALUES (1, 'Alice');
INSERT INTO Customers (Id, Name) VALUES (2, 'Bob');
INSERT INTO Orders (Id, CustomerId) VALUES (100, 1);
INSERT INTO Orders (Id, CustomerId) VALUES (101, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.NAME AS CUSTOMERS FROM CUSTOMERS AS T1 LEFT JOIN ORDERS AS T2 ON T1.ID = T2.CUSTOMERID WHERE T2.CUSTOMERID IS NULL;

/*
Prediction Result:
('Bob',)
*/