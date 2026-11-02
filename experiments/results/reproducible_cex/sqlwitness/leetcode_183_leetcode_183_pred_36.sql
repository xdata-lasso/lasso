-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default2'), (1, NULL), (2, NULL), (3, NULL), (4, NULL);
INSERT INTO orders (id, customerid) VALUES (1, 3), (0, 0), (2, NULL), (3, NULL), (4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT ID IN (SELECT T1.ID FROM CUSTOMERS AS T1 INNER JOIN ORDERS AS T2 ON T2.CUSTOMERID = T1.ID);

/*
Prediction Result:
(None,)
(None,)
(None,)
*/