-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (2, NULL), (0, 'default2'), (1, NULL), (3, 'default2'), (4, 'default2'), (5, NULL), (6, 'default1'), (7, 'default2'), (8, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 2), (2, 6), (0, 0), (3, NULL), (4, 3), (5, 4), (6, 4), (7, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS AS C WHERE NOT EXISTS(SELECT 1 FROM ORDERS WHERE C.ID = CUSTOMERID);

/*
Prediction Result:
(None,)
(None,)
('default2',)
*/