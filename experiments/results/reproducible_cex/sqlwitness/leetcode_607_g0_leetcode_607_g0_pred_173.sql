-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', NULL), (1, 'RED', 'default2'), (0, NULL, 'RED'), (2, 'default1', 'RED'), (3, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 0, NULL, 'default1'), (1, 'default1', NULL, NULL, 'default1'), (0, NULL, 1, 1, 'RED'), (2, 'RED', NULL, NULL, 'RED'), (3, NULL, 1, 0, NULL), (4, NULL, NULL, NULL, 'default1'), (5, 'default1', 1, NULL, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, -1, 2, NULL, 0), (-1, 3, 4, 'default1', 1), (0, NULL, 5, 'RED', 0), (2, 3, 0, 'default1', NULL), (3, 3, -1, 'RED', 0), (4, 0, 1, 'default2', NULL), (5, NULL, 3, NULL, NULL), (6, 0, 3, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('RED',)
(None,)
('default1',)
*/

-- Prediction Query
WITH T0 AS (SELECT O.ORDER_ID, C.NAME AS COM_NAME, S.NAME FROM (ORDERS AS O LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID) LEFT JOIN SALESPERSON AS S ON O.SALES_ID = S.SALES_ID) SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM T0 WHERE COM_NAME = 'RED');

/*
Prediction Result:
*/