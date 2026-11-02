-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (Id, Name) VALUES (1, 'Alice');
INSERT INTO Customers (Id, Name) VALUES (2, 'Bob');
INSERT INTO Orders (Id, CustomerId) VALUES (1, 1);
INSERT INTO Orders (Id, CustomerId) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT CUSTOMERS.ID IN (SELECT CUSTOMERS.ID FROM ORDERS JOIN CUSTOMERS ON ORDERS.CUSTOMERID = CUSTOMERS.ID);

/*
Prediction Result:
('Bob',)
*/