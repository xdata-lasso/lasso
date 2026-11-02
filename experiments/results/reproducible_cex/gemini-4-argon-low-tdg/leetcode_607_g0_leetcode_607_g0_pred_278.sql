-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests empty ORDERS and COMPANY tables, and NULL salesperson name:
-- 1. No company named 'RED' exists at all (kills mutants that INNER JOIN company with name='RED' at the top level).
-- 2. Salesperson with NULL name (kills mutants doing COUNT(S.NAME) or filtering S.NAME IS NOT NULL).
-- 3. Two salespersons with identical non-null names, neither having 'RED' orders (kills mutants applying DISTINCT to the final SELECT NAME output).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'Twin', 50000, 10, '2022-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Twin', 60000, 15, '2022-01-02');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, NULL, 70000, 20, '2022-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Twin',)
('Twin',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME IS NULL OR NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
('Twin',)
(None,)
*/