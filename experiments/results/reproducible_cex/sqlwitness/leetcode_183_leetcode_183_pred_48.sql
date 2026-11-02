-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default1'), (0, 'default2'), (2, NULL), (3, NULL);
INSERT INTO orders (id, customerid) VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME AS CUSTOMERS FROM CUSTOMERS AS A WHERE NOT EXISTS(SELECT B.CUSTOMERID FROM ORDERS AS B WHERE A.ID = B.CUSTOMERID);

/*
Prediction Result:
('default2',)
('default1',)
(None,)
(None,)
*/