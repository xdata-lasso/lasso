-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', NULL), (-1, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default2', 1, 1, 'RED'), (-1, 'default1', 0, NULL, 'default1'), (1, NULL, 0, 1, 'default2'), (2, 'default2', NULL, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, NULL, 1, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default2',)
(None,)
('default2',)
*/

-- Prediction Query
WITH CTE AS (SELECT S.SALES_ID FROM SALESPERSON AS S JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME IN ('RED')) SELECT DISTINCT S.NAME FROM SALESPERSON AS S LEFT JOIN CTE ON CTE.SALES_ID = S.SALES_ID WHERE CTE.SALES_ID IS NULL;

/*
Prediction Result:
('default1',)
('default2',)
(None,)
*/