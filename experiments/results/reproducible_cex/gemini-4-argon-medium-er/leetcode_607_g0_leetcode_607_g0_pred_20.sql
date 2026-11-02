-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'John', 1000, 10, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'John', 1000, 10, '2020-01-01');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'New York');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 1, '2020-01-02', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('John',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT DISTINCT S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS AS O ON O.SALES_ID = S.SALES_ID LEFT JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/