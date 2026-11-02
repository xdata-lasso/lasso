-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'RED'), (-1, NULL, 'RED'), (1, NULL, 'RED'), (2, NULL, 'default2'), (3, 'RED', 'default1'), (4, 'RED', 'default1'), (5, 'default2', 'RED'), (6, 'default2', 'RED'), (7, 'default1', 'default2'), (8, 'RED', 'default1'), (9, 'RED', NULL), (10, 'RED', 'RED'), (11, NULL, 'RED'), (12, NULL, 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, 1, NULL), (1, NULL, 1, 0, 'default2'), (0, 'default2', 1, NULL, 'RED'), (2, 'default2', NULL, 0, 'default2'), (3, 'RED', 0, 0, 'RED'), (4, NULL, 1, NULL, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 8, 2, NULL, 1), (0, 7, 0, NULL, NULL), (1, NULL, NULL, 'default2', NULL), (2, 10, 1, 'default1', NULL), (3, 4, 0, 'default1', NULL), (4, 3, -1, 'default1', NULL), (5, 11, 2, 'default1', 0), (6, 9, NULL, 'RED', 1), (7, 2, 3, 'RED', NULL), (8, 1, 3, 'RED', 0), (9, 4, -1, 'default2', 0), (10, 1, -1, NULL, 0), (11, 7, NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
*/

-- Prediction Query
WITH SUB AS (SELECT ORDER_ID AS ORDER_ID1, SALES_ID AS SALES_ID1 FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED') SELECT S.NAME AS NAME FROM SALESPERSON AS S WHERE NOT SALES_ID IN (SELECT SALES_ID1 FROM SUB);

/*
Prediction Result:
*/