-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests string matching, case sensitivity, city vs name confusion, and multiple 'RED' companies:
-- 1. Company named 'red' (lowercase) and 'RED_CORP' (kills LIKE '%RED%' or case-insensitive mutants).
-- 2. Company where city is 'RED' instead of name (kills mutants checking C.CITY = 'RED').
-- 3. Multiple companies named 'RED' (kills mutants using scalar subquery O.COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'S_Lower_Red', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'S_Prefix_Red', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'S_City_Red', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'S_Red_1', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (5, 'S_Red_2', 50000, 5, '2020-01-01');
INSERT INTO company (com_id, name, city) VALUES (10, 'red', 'Boston');
INSERT INTO company (com_id, name, city) VALUES (20, 'RED_CORP', 'Boston');
INSERT INTO company (com_id, name, city) VALUES (30, 'GREEN', 'RED');
INSERT INTO company (com_id, name, city) VALUES (40, 'RED', 'Miami');
INSERT INTO company (com_id, name, city) VALUES (50, 'RED', 'Dallas');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (100, 10, 1, '2021-01-01', 500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (200, 20, 2, '2021-01-01', 500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (300, 30, 3, '2021-01-01', 500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (400, 40, 4, '2021-01-01', 500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (500, 50, 5, '2021-01-01', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('S_Lower_Red',)
('S_Prefix_Red',)
('S_City_Red',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON AS S LEFT JOIN (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')) AS T ON S.SALES_ID = T.SALES_ID WHERE T.SALES_ID IS NULL;

/*
Prediction Result:
('S_Lower_Red',)
('S_Prefix_Red',)
('S_City_Red',)
('S_Red_2',)
*/