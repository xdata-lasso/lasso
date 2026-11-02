-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, NULL), (0, NULL), (2, 5), (3, NULL), (4, 4), (5, 3), (6, 4), (7, 3), (8, 4), (9, 7), (10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM (CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID) WHERE CUSTOMERID IS NULL;

/*
Prediction Result:
('default1',)
(None,)
('default1',)
(None,)
*/