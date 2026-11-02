-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default2'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, NULL), (7, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 4), (0, NULL), (2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT CUSTOMERS.ID IN (SELECT CUSTOMERS.ID FROM CUSTOMERS INNER JOIN ORDERS ON (CUSTOMERS.ID = ORDERS.CUSTOMERID));

/*
Prediction Result:
('default1',)
('default2',)
(None,)
('default1',)
(None,)
('default1',)
*/