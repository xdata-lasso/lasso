-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests wrong join key mutations (e.g., O.COM_ID = S.SALES_ID or O.ORDER_ID = S.SALES_ID) and aggregation mutations (e.g., SUM(amount) = 0, COUNT(amount) = 0):
-- 1. Order for 'RED' with amount = 0 and order with NULL amount (kills SUM(amount) = 0 or COUNT(amount) = 0).
-- 2. Overlapping IDs across tables (sales_id = 1, com_id = 1, order_id = 1) where the actual relationship is different.
-- 3. Multiple orders for 'RED' by the same salesperson (kills mutants checking COUNT(*) = 1 or COUNT(*) < 2).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'Overlap_Safe', 40000, 5, '2019-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Zero_Amt_Red', 40000, 5, '2019-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Null_Amt_Red', 40000, 5, '2019-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'Multi_Red', 40000, 5, '2019-01-01');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'Austin');
INSERT INTO company (com_id, name, city) VALUES (2, 'YELLOW', 'Austin');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 2, 1, '2020-05-05', 100);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 1, 2, '2020-05-06', 0);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 1, 3, '2020-05-07', NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (4, 1, 4, '2020-05-08', 250);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (5, 1, 4, '2020-05-09', 350);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Overlap_Safe',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN (ORDERS AS O JOIN (SELECT * FROM COMPANY WHERE NAME = 'RED') AS C ON C.COM_ID = O.COM_ID) ON O.SALES_ID = S.SALES_ID WHERE O.AMOUNT IS NULL;

/*
Prediction Result:
('Overlap_Safe',)
('Null_Amt_Red',)
*/