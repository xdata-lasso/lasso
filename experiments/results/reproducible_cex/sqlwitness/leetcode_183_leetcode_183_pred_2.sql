-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2'), (3, NULL), (4, 'default2');
INSERT INTO orders (id, customerid) VALUES (1, 4), (0, NULL), (2, 1), (3, 4), (4, 3), (5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME AS CUSTOMERS FROM CUSTOMERS AS A WHERE NOT EXISTS(SELECT B.ID FROM ORDERS AS B WHERE A.ID = B.CUSTOMERID);

/*
Prediction Result:
('default2',)
*/