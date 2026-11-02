-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, 'default1'), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2');
INSERT INTO orders (id, customerid) VALUES (1, 3), (0, NULL), (2, NULL), (3, NULL), (4, 5), (5, 5), (6, 2), (7, 1), (8, 3), (9, 3), (10, 3), (11, 4), (12, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT EXISTS(SELECT * FROM ORDERS WHERE CUSTOMERID = CUSTOMERS.ID);

/*
Prediction Result:
('default1',)
('default2',)
*/