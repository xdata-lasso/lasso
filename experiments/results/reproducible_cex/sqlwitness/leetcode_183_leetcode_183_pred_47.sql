-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default1'), (1, 'default1'), (2, 'default1'), (3, 'default2'), (4, 'default2');
INSERT INTO orders (id, customerid) VALUES (0, NULL), (1, NULL), (2, 3), (3, 0), (4, 4), (5, 1), (6, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.NAME AS CUSTOMERS FROM CUSTOMERS AS T1 LEFT JOIN ORDERS AS T2 ON T1.ID = T2.CUSTOMERID WHERE T2.CUSTOMERID IS NULL;

/*
Prediction Result:
('default1',)
*/