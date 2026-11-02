-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests string matching precision, aggregation mutants, and wrong join keys:
-- 1. Case sensitivity ('red', 'Red') and substring ('RED_CORP', 'DARK_RED') to kill LIKE '%RED%' or case-insensitive mutants.
-- 2. Order with amount = 0 for 'RED' (kills mutants using COALESCE(SUM(amount), 0) = 0 instead of COUNT).
-- 3. Multiple orders for 'RED' by the same salesperson (kills mutants checking COUNT(*) != 1 or similar).
-- 4. Matching IDs across different tables (e.g., sales_id = com_id = order_id) to kill wrong join condition mutants (like O.SALES_ID = C.COM_ID).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (10, 'ZeroAmountRed', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (20, 'MultiRed', 60000, 10, '2020-02-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (30, 'CaseAndSubstring', 55000, 8, '2020-03-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (40, 'RED', 70000, 12, '2020-04-01');
INSERT INTO company (com_id, name, city) VALUES (10, 'RED', 'Boston');
INSERT INTO company (com_id, name, city) VALUES (20, 'red', 'Austin');
INSERT INTO company (com_id, name, city) VALUES (30, 'RED_CORP', 'Denver');
INSERT INTO company (com_id, name, city) VALUES (40, 'GREEN', 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (10, 10, 10, '2021-03-01', 0);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (20, 10, 20, '2021-03-02', 100);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (21, 10, 20, '2021-03-03', 200);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (30, 20, 30, '2021-03-04', 300);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (31, 30, 30, '2021-03-05', 400);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (40, 40, 40, '2021-03-06', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('CaseAndSubstring',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT D.SALES_ID FROM (SELECT S.NAME, S.SALES_ID, O.COM_ID FROM SALESPERSON AS S INNER JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID) AS D WHERE D.COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME LIKE '%RED%'));

/*
Prediction Result:
('RED',)
*/