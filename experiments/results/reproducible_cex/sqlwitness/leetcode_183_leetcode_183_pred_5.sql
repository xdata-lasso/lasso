-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'default1'), (5, 'default2'), (6, 'default1');
INSERT INTO orders (id, customerid) VALUES (0, 5), (1, NULL), (2, 4), (3, 1), (4, 2), (5, 2), (6, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID WHERE O.CUSTOMERID IS NULL;

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
*/