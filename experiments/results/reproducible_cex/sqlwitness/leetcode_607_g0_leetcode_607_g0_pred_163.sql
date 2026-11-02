-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, NULL, NULL), (-1, NULL, 1, 0, 'default2'), (1, 'default1', 1, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, NULL, 1, 'default1', NULL), (-1, NULL, -1, 'RED', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
WITH N AS (SELECT COM_ID, SALES_ID, C.NAME AS COM_NAME, S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS USING (SALES_ID) LEFT JOIN COMPANY AS C USING (COM_ID)) SELECT DISTINCT NAME FROM N WHERE NOT NAME IN (SELECT NAME FROM N WHERE COM_NAME = 'RED');

/*
Prediction Result:
(None,)
('default1',)
*/