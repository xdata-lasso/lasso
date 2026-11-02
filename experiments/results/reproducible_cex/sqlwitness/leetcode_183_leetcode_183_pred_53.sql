-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (2, 'default2'), (1, NULL);
INSERT INTO orders (id, customerid) VALUES (1, NULL), (0, NULL), (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS LEFT JOIN (SELECT DISTINCT CUSTOMERID, 1 AS HAS_ORDER FROM ORDERS) AS SUBQ ON CUSTOMERS.ID = SUBQ.CUSTOMERID WHERE HAS_ORDER IS NULL;

/*
Prediction Result:
(None,)
*/