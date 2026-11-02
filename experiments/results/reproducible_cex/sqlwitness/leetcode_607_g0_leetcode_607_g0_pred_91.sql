-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', NULL), (-1, NULL, 'default2'), (0, 'default2', 'default1'), (2, 'default2', 'RED'), (3, 'RED', 'default1'), (4, 'default2', 'default2'), (5, 'RED', NULL), (6, 'default1', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default1', 0, 0, 'default2'), (-1, 'default1', 1, 0, 'RED');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT SALES_NAME FROM (SELECT O.ORDER_ID, O.COM_ID, O.SALES_ID, C.NAME AS COM_NAME, S.NAME AS SALES_NAME FROM ORDERS AS O LEFT JOIN SALESPERSON AS S ON O.SALES_ID = S.SALES_ID LEFT JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED') AS T);

/*
Prediction Result:
('default1',)
*/