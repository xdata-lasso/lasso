-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default1'), (1, 'default1'), (2, 'default2');
INSERT INTO orders (id, customerid) VALUES (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT T.NAME AS CUSTOMERS FROM CUSTOMERS AS T WHERE NOT T.ID IN (SELECT C.ID FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.ID = O.CUSTOMERID);

/*
Prediction Result:
('default1',)
('default1',)
('default2',)
*/