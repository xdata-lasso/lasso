-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, 'default2'), (0, 'default2'), (2, 'default2');
INSERT INTO orders (id, customerid) VALUES (1, 2), (0, 0), (2, NULL), (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS AS C WHERE NOT C.ID IN (SELECT CUSTOMERID FROM ORDERS AS O WHERE O.CUSTOMERID = C.ID);

/*
Prediction Result:
('default2',)
*/