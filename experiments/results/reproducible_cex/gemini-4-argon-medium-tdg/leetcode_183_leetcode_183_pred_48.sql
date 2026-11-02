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
SELECT A.NAME AS CUSTOMERS FROM CUSTOMERS AS A WHERE NOT EXISTS(SELECT B.CUSTOMERID FROM ORDERS AS B WHERE A.ID = B.CUSTOMERID);

/*
Prediction Result:
('Bob',)
*/