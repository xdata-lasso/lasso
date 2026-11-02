-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', 'default1'), (-1, 'RED', 'default1'), (0, 'default1', 'default1'), (2, 'default2', NULL), (3, 'RED', 'RED'), (4, NULL, 'RED'), (5, 'default2', 'default1'), (6, NULL, 'default2'), (7, 'RED', 'default1'), (8, 'RED', 'default2'), (9, NULL, 'default2'), (10, 'RED', 'RED'), (11, 'RED', NULL), (12, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 0, 0, 'default2'), (0, 'RED', 0, 1, 'default1'), (-1, 'RED', 1, 0, NULL), (2, NULL, 0, NULL, 'RED'), (3, NULL, NULL, 1, NULL), (4, 'default2', NULL, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, -1, 1, 'RED', NULL), (1, 10, NULL, NULL, 1), (0, 9, 1, 'default1', NULL), (2, 12, NULL, 'default2', 1), (3, 8, 0, 'default1', 1), (4, -1, 2, 'default1', 1), (5, 12, 0, NULL, 0), (6, 3, 4, 'default2', 1), (7, 11, 0, 'default1', 0), (8, 11, 4, 'RED', NULL);
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
WITH T AS (SELECT ORDER_ID, COM_ID, SALES_ID, C.NAME AS COM_NAME, S.NAME FROM ORDERS JOIN COMPANY AS C USING (COM_ID) JOIN SALESPERSON AS S USING (SALES_ID) WHERE C.NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM T);

/*
Prediction Result:
*/