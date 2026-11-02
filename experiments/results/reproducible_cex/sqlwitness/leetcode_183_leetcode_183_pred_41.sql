-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default2'), (1, NULL), (-1, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default2'), (5, 'default2'), (6, NULL), (7, 'default2'), (8, NULL);
INSERT INTO orders (id, customerid) VALUES (0, 2), (-1, 8), (1, NULL), (2, 1), (3, 4), (4, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID GROUP BY C.NAME, C.ID HAVING COUNT(O.ID) = 0;

/*
Prediction Result:
('default1',)
('default2',)
('default2',)
('default2',)
(None,)
('default2',)
*/