-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'RED'), (1, NULL, 'default2'), (0, 'default1', 'RED'), (2, 'RED', NULL), (3, NULL, 'default2'), (4, 'RED', NULL), (5, 'RED', 'RED'), (6, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 0, 1, 'RED'), (-1, 'default1', 0, 1, NULL), (0, 'default2', NULL, 1, 'RED'), (2, 'RED', 0, 1, 'default2'), (3, NULL, 1, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 2, NULL, 'default1', NULL), (-1, 5, 1, 'RED', 1), (0, 0, -1, 'RED', 1), (2, 2, 3, 'default1', NULL), (3, 1, 2, 'default2', NULL), (4, 2, 0, 'RED', 1), (5, -1, 0, 'default1', NULL), (6, -1, -1, NULL, 1), (7, 5, -1, 'RED', 1), (8, 5, 0, 'default1', NULL), (9, 0, -1, 'RED', NULL), (10, 5, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT ORD.SALES_ID FROM ORDERS AS ORD JOIN COMPANY AS COM ON COM.COM_ID = ORD.COM_ID WHERE COM.NAME = 'RED');

/*
Prediction Result:
*/