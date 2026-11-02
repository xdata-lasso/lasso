-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'Anna', 50000, 5, '2020-01-01');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'Ben', 50000, 5, '2020-01-02');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (3, 'Cara', 50000, 5, '2020-01-03');
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'London');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, NULL, '2021-08-01', 1000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, NULL, 2, '2021-08-02', 1500);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (3, 1, 3, '2021-08-03', 2000);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (4, NULL, 3, '2021-08-04', 2500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('Anna',)
('Ben',)
*/

-- Prediction Query
SELECT SP.NAME FROM SALESPERSON AS SP WHERE NOT SP.SALES_ID IN (SELECT SALES_ID FROM ORDERS INNER JOIN COMPANY ON COMPANY.COM_ID = ORDERS.COM_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/