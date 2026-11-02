-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default2'), (0, 'default1'), (2, NULL), (3, NULL), (4, 'default2'), (5, 'default2'), (6, NULL), (7, NULL), (8, NULL), (9, 'default2'), (10, 'default1'), (11, NULL), (12, NULL), (13, 'default2'), (14, 'default2'), (15, 'default2');
INSERT INTO orders (id, customerid) VALUES (0, NULL), (1, 0), (2, 12), (3, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT ID IN (SELECT A.ID FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.ID = B.CUSTOMERID);

/*
Prediction Result:
('default2',)
(None,)
(None,)
('default2',)
('default2',)
(None,)
(None,)
(None,)
('default2',)
(None,)
('default2',)
('default2',)
('default2',)
*/