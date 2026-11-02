-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'default1'), (1, 'default2', NULL), (-1, 'default2', 'default1'), (2, 'RED', 'default1'), (3, NULL, 'default1'), (4, NULL, NULL), (5, 'default1', 'default1'), (6, 'default2', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', NULL, 1, 'RED'), (0, 'RED', 1, NULL, 'default2'), (-1, 'RED', NULL, 0, 'default1'), (2, NULL, NULL, NULL, 'RED'), (3, 'RED', NULL, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 6, 1, NULL, 0), (-1, NULL, 0, 'default1', 0), (1, 3, NULL, 'RED', 0), (2, 0, 2, 'default1', 1), (3, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('RED',)
('RED',)
('RED',)
*/

-- Prediction Query
WITH T AS (SELECT ORDER_ID, C.COM_ID, SALES_ID, NAME FROM COMPANY AS C INNER JOIN ORDERS AS O ON C.COM_ID = O.COM_ID), T2 AS (SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN T ON S.SALES_ID = T.SALES_ID WHERE T.NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM T2);

/*
Prediction Result:
*/