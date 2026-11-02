-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default2'), (3, 'default2'), (4, NULL), (5, NULL);
INSERT INTO orders (id, customerid) VALUES (0, 5), (1, 1), (2, 2), (3, 1), (4, 3), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C1.NAME AS CUSTOMERS FROM CUSTOMERS AS C1 WHERE NOT C1.ID IN (SELECT C.ID FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.ID = O.CUSTOMERID);

/*
Prediction Result:
('default2',)
(None,)
*/