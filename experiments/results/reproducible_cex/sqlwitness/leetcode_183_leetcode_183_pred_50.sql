-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, NULL), (2, 'default1'), (3, 'default1'), (4, NULL), (5, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 2), (0, NULL), (2, 3), (3, 0), (4, 3), (5, NULL), (6, 2), (7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME AS CUSTOMERS FROM CUSTOMERS AS A LEFT JOIN ORDERS AS O ON A.ID = O.CUSTOMERID WHERE CUSTOMERID IS NULL;

/*
Prediction Result:
(None,)
(None,)
('default1',)
*/