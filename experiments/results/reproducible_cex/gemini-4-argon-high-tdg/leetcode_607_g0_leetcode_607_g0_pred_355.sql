-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'John', 50000, 5, '2019-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'John', 60000, 6, '2019-02-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Mary', 55000, 5, '2019-03-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (4, 'Mary', 58000, 7, '2019-04-01');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'CityA');
INSERT INTO company (com_id, name, city) VALUES (2, 'GREEN', 'CityB');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 1, '2021-06-01', 1200);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 2, 4, '2021-06-02', 900);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('John',)
('Mary',)
('Mary',)
*/

-- Prediction Query
SELECT S1.NAME FROM SALESPERSON AS S1 WHERE NOT S1.NAME IN (SELECT S2.NAME FROM SALESPERSON AS S2 JOIN ORDERS USING (SALES_ID) JOIN COMPANY USING (COM_ID) WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
('Mary',)
('Mary',)
*/