-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default2'), (0, NULL), (2, NULL), (3, 'default2'), (4, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 4), (0, 0), (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.NAME AS CUSTOMERS FROM CUSTOMERS LEFT JOIN ORDERS ON CUSTOMERS.ID = ORDERS.CUSTOMERID WHERE (CUSTOMERID IS NULL) = TRUE;

/*
Prediction Result:
('default2',)
(None,)
('default2',)
*/