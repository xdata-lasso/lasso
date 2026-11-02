-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic scenarios:
-- 1. Salesperson with NO orders at all (John).
-- 2. Salesperson with orders ONLY for 'RED' (Amy).
-- 3. Salesperson with orders for BOTH 'RED' and 'BLUE' (Mark - kills mutants filtering C.NAME != 'RED' on a simple JOIN).
-- 4. Salesperson with multiple orders for 'BLUE' (Pam - kills mutants without DISTINCT if they use LEFT JOIN).
-- 5. Two salespersons with the exact same name 'Alex', one has a 'RED' order and one does not (kills mutants using EXCEPT on NAME or GROUP BY NAME instead of sales_id).
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'John', 100000, 6, '4/1/2006');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Amy', 120000, 5, '5/1/2010');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Mark', 65000, 12, '12/25/2008');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'Pam', 25000, 25, '1/1/2005');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (5, 'Alex', 50000, 10, '2/3/2007');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (6, 'Alex', 55000, 10, '3/3/2008');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'Boston');
INSERT INTO company (com_id, name, city) VALUES (2, 'BLUE', 'New York');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 2, '1/1/2014', 10000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 1, 3, '2/1/2014', 20000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 2, 3, '3/1/2014', 30000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (4, 2, 4, '4/1/2014', 40000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (5, 2, 4, '5/1/2014', 50000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (6, 1, 6, '6/1/2014', 60000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('John',)
('Pam',)
('Alex',)
*/

-- Prediction Query
WITH TEMP_TABLE AS (SELECT SALESPERSON.SALES_ID, SALESPERSON.NAME AS PERSON, COMPANY.NAME AS NAME FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID) SELECT DISTINCT PERSON AS NAME FROM TEMP_TABLE WHERE NOT PERSON IN (SELECT PERSON FROM TEMP_TABLE WHERE NAME = 'RED');

/*
Prediction Result:
('John',)
('Pam',)
*/