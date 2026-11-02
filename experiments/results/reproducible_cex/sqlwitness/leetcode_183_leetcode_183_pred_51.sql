-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (id, name) VALUES (0, 'default1'), (1, NULL), (2, 'default2');
INSERT INTO orders (id, customerid) VALUES (0, 0), (1, 1), (2, 0), (3, NULL), (4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS AS CT LEFT JOIN ORDERS AS OT ON CT.ID = OT.CUSTOMERID WHERE OT.CUSTOMERID IS NULL;

/*
Prediction Result:
('default2',)
*/