-- Schema DDL
CREATE TABLE "Customers" ("Id" INTEGER PRIMARY KEY, "Name" TEXT(255));

CREATE TABLE "Orders" ("Id" INTEGER PRIMARY KEY, "CustomerId" INTEGER, FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("id", "name") VALUES (-2147483648, 'cus_422e17');

INSERT INTO "customers" ("id", "name") VALUES (1, 'cus_c007ac');

INSERT INTO "customers" ("id", "name") VALUES (2, 'cus_422e17');

INSERT INTO "customers" ("id", "name") VALUES (3, 'cus_422e17');

INSERT INTO "customers" ("id", "name") VALUES (-2147483646, 'cus_7b1125');

INSERT INTO "customers" ("id", "name") VALUES (-2147483643, 'cus_422e17');

INSERT INTO "customers" ("id", "name") VALUES (-2147483642, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS Customers FROM Customers WHERE NOT id IN (SELECT customerID FROM Orders);

/*
Gold Result:
('cus_422e17',)
('cus_7b1125',)
('cus_422e17',)
(None,)
('cus_c007ac',)
('cus_422e17',)
('cus_422e17',)
*/

-- Prediction Query
SELECT NAME AS CUSTOMERS FROM CUSTOMERS WHERE NOT ID IN ((SELECT C.ID FROM CUSTOMERS AS C CROSS JOIN ORDERS AS O WHERE C.ID = O.CUSTOMERID));

/*
Prediction Result:
*/