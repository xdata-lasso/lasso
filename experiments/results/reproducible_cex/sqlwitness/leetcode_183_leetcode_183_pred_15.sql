-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default1'), (0, NULL), (2, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 1), (0, NULL), (2, NULL), (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT CUSTOMERS.ID IN (SELECT CUSTOMERS.ID FROM ORDERS JOIN CUSTOMERS ON ORDERS.CUSTOMERID = CUSTOMERS.ID);

/*
Prediction Result:
(None,)
('default1',)
*/