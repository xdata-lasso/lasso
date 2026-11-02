-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'Sam', 45000, 5, '2021-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Pam', 48000, 6, '2021-01-02');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Tim', 52000, 4, '2021-01-03');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'North');
INSERT INTO company (com_id, name, city) VALUES (2, 'RED', 'South');
INSERT INTO company (com_id, name, city) VALUES (3, 'YELLOW', 'East');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 1, '2021-07-01', 400);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 2, 2, '2021-07-02', 600);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 3, 3, '2021-07-03', 700);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Tim',)
*/

-- Prediction Query
WITH TRADED_WITH_RED AS (SELECT DISTINCT (SALES_ID), 1 AS RED_FLAG FROM ORDERS WHERE COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')) SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM TRADED_WITH_RED);

/*
Prediction Result:
('Pam',)
('Tim',)
*/