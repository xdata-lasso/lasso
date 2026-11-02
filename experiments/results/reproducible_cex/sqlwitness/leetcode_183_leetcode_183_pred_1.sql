-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (1, NULL), (0, 'default2'), (2, NULL);
INSERT INTO orders (id, customerid) VALUES (0, 1), (1, 1), (2, NULL), (3, 2), (4, 2), (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME AS CUSTOMERS FROM CUSTOMERS AS A LEFT JOIN ORDERS AS B ON A.ID = B.CUSTOMERID WHERE B.CUSTOMERID IS NULL;

/*
Prediction Result:
('default2',)
*/