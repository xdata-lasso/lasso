-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, NULL, 'default2'), (1, NULL, 'RED'), (-1, 'RED', 'default2'), (2, 'RED', 'default2'), (3, NULL, NULL), (4, 'RED', 'RED'), (5, 'default1', NULL), (6, 'RED', 'default1'), (7, 'RED', 'default1'), (8, 'default1', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 1, NULL, 'default1'), (0, NULL, 1, 0, 'default2'), (1, 'RED', NULL, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 6, 1, NULL, 1), (-1, 6, NULL, 'default1', 1), (0, 6, 0, NULL, 1), (2, 8, 1, NULL, 1), (3, 8, 1, 'default2', NULL), (4, 1, NULL, 'default1', 1), (5, -1, 0, 'default2', 0), (6, -1, NULL, NULL, NULL), (7, NULL, 0, NULL, 0), (8, 0, 1, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT T1.SALES_ID FROM ORDERS AS T1 LEFT JOIN COMPANY AS T2 ON T1.COM_ID = T2.COM_ID WHERE T2.NAME = 'RED');

/*
Prediction Result:
*/