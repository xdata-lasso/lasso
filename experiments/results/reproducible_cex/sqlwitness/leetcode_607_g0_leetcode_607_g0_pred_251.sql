-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', NULL), (1, 'RED', 'RED'), (-1, 'RED', NULL), (2, 'default1', 'default2'), (3, 'default2', 'RED'), (4, 'default1', NULL), (5, 'default2', 'default1'), (6, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 1, 0, 'default2'), (-1, NULL, 0, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, NULL, NULL, NULL, 1), (-1, 5, NULL, 'default1', NULL), (1, 1, NULL, 'RED', 0), (2, 5, -1, 'default2', NULL), (3, -1, NULL, 'RED', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
*/

-- Prediction Query
WITH TEMP AS (SELECT O.ORDER_ID, SP.NAME, C.NAME AS COMPANY_NAME FROM ORDERS AS O LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID LEFT JOIN SALESPERSON AS SP ON O.SALES_ID = SP.SALES_ID) SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM TEMP WHERE COMPANY_NAME = 'RED');

/*
Prediction Result:
*/