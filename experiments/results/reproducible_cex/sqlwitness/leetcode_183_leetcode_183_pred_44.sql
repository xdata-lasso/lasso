-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default2'), (8, NULL);
INSERT INTO orders (id, customerid) VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.NAME AS CUSTOMERS FROM CUSTOMERS LEFT JOIN (SELECT DISTINCT CUSTOMERID FROM ORDERS) AS ORDS ON CUSTOMERS.ID = ORDS.CUSTOMERID WHERE ORDS.CUSTOMERID IS NULL;

/*
Prediction Result:
('default1',)
('default2',)
(None,)
('default2',)
('default2',)
(None,)
(None,)
('default2',)
(None,)
*/