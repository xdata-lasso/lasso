-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling, duplicate salesperson names, and multiple 'RED' companies:
-- 1. Orders with NULL sales_id (kills NOT IN subqueries that don't filter out NULLs, as x NOT IN (1, NULL) evaluates to UNKNOWN).
-- 2. Orders with NULL com_id and Companies with NULL name.
-- 3. Multiple companies named 'RED' (kills scalar subquery mutants like `com_id = (SELECT com_id FROM company WHERE name = 'RED')` or LIMIT 1).
-- 4. Duplicate salesperson names where one should be included and one excluded, and two included (kills SELECT DISTINCT name or EXCEPT on names).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'SameName_Included', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'SameName_Included', 60000, 10, '2020-02-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'MixedName', 55000, 8, '2020-03-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'MixedName', 70000, 12, '2020-04-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (5, 'SecondRed_Excluded', 65000, 10, '2020-05-01');
INSERT INTO company (com_id, name, city) VALUES (10, 'RED', 'Boston');
INSERT INTO company (com_id, name, city) VALUES (11, 'RED', 'Chicago');
INSERT INTO company (com_id, name, city) VALUES (20, NULL, 'Seattle');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (201, 10, NULL, '2021-02-01', 500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (202, NULL, 1, '2021-02-02', 600);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (203, 20, 2, '2021-02-03', 700);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (204, 10, 3, '2021-02-04', 800);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (205, 11, 5, '2021-02-05', 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('SameName_Included',)
('SameName_Included',)
('MixedName',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT O.SALES_ID AS SALES_ID FROM ORDERS AS O WHERE O.COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
*/