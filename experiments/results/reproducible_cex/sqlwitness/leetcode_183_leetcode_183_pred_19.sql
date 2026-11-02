-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, NULL), (2, NULL), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, 'default2');
INSERT INTO orders (id, customerid) VALUES (0, 4), (1, 7), (2, 7), (3, 6), (4, NULL), (5, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS AS C WHERE NOT EXISTS(SELECT CUSTOMERID FROM ORDERS AS O WHERE O.CUSTOMERID = C.ID);

/*
Prediction Result:
(None,)
(None,)
(None,)
('default1',)
('default1',)
('default2',)
*/