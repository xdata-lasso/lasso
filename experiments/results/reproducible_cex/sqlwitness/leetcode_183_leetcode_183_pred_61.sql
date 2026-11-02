-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default1');
INSERT INTO orders (id, customerid) VALUES (1, 2), (0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT C2.NAME AS CUSTOMERS FROM CUSTOMERS AS C2 WHERE NOT C2.ID IN (SELECT O.CUSTOMERID FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.ID = O.CUSTOMERID);

/*
Prediction Result:
('default1',)
('default1',)
*/