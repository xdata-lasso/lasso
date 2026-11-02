-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in foreign keys and company names:
-- 1. Orders with NULL sales_id for 'RED' company (kills NOT IN mutants when subquery returns NULL).
-- 2. Orders with NULL com_id (tests join conditions).
-- 3. Company with NULL name (tests three-valued logic on C.NAME != 'RED').
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'Alice', 50000, 10, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Bob', 60000, 12, '2020-02-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Charlie', 70000, 15, '2020-03-01');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'Chicago');
INSERT INTO company (com_id, name, city) VALUES (2, NULL, 'Seattle');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, NULL, '2021-01-01', 1000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, NULL, 1, '2021-01-02', 2000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 2, 2, '2021-01-03', 3000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (4, 1, 3, '2021-01-04', 4000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED' GROUP BY O.COM_ID, O.SALES_ID);

/*
Prediction Result:
*/