-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', NULL), (0, 'default2', NULL), (1, 'default1', NULL), (2, 'RED', 'default1'), (3, NULL, 'default1'), (4, NULL, 'RED'), (5, 'default1', 'default1'), (6, 'default2', 'default2'), (7, NULL, 'RED'), (8, 'default2', 'default2'), (9, 'default1', 'default1'), (10, NULL, 'default1'), (11, 'RED', 'default1'), (12, 'default2', 'default2'), (13, 'RED', 'default2'), (14, 'RED', 'default2'), (15, NULL, 'RED'), (16, 'default1', NULL), (17, 'default2', 'RED'), (18, 'default1', 'default2'), (19, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, NULL, 'default2'), (0, 'default2', NULL, 0, 'default2'), (-1, NULL, 0, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 12, NULL, 'RED', NULL), (-1, 6, 1, 'RED', 1), (0, NULL, -1, 'RED', 0), (2, 8, -1, 'RED', NULL), (3, 9, NULL, 'default2', NULL), (4, 7, NULL, 'RED', 1), (5, NULL, 0, 'default2', 0), (6, 11, 0, 'default2', NULL), (7, -1, NULL, 'default1', 0), (8, 19, NULL, 'RED', NULL), (9, 5, 1, 'RED', 1), (10, 7, -1, 'default1', 0), (11, 15, -1, 'default1', NULL), (12, 8, NULL, NULL, NULL), (13, 15, -1, 'default1', 1), (14, -1, NULL, 'default2', 1), (15, 1, NULL, 'default1', NULL), (16, 9, -1, 'default1', 0), (17, 14, 1, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE_RED_SELLERS AS (SELECT DISTINCT SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED'), CTE_FILTER AS (SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT * FROM CTE_RED_SELLERS)) SELECT * FROM CTE_FILTER;

/*
Prediction Result:
*/