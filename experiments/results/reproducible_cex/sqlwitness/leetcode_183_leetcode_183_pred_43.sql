-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL);
INSERT INTO orders (id, customerid) VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT CUST.NAME AS CUSTOMERS FROM CUSTOMERS AS CUST LEFT JOIN ORDERS AS ORD ON CUST.ID = ORD.CUSTOMERID WHERE ORD.CUSTOMERID IS NULL;

/*
Prediction Result:
(None,)
*/