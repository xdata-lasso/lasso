-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, NULL), (1, 'default1'), (-1, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 1), (0, 1), (-1, 0), (2, 1), (3, 0), (4, NULL), (5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT T.NAME AS CUSTOMERS FROM (SELECT NAME, COUNT(O.ID) AS FO FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.ID = O.CUSTOMERID GROUP BY C.ID HAVING FO = 0) AS T;

/*
Prediction Result:
('default1',)
*/