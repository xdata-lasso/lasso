-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default2', NULL), (1, 'default1', NULL), (-1, 'default2', 'default2'), (2, 'RED', NULL), (3, 'default2', 'RED'), (4, 'RED', 'default1'), (5, 'default1', 'RED'), (6, 'default2', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 0, NULL, NULL), (0, NULL, NULL, 0, NULL), (-1, 'default2', 1, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 3, 0, 'RED', 0), (0, 4, 1, 'default2', 1), (-1, -1, -1, 'default1', 0), (2, 0, NULL, 'default2', NULL), (3, 5, 1, 'RED', 0), (4, 2, 1, 'default2', 0), (5, 4, 0, NULL, NULL), (6, 2, 0, 'RED', 0), (7, NULL, -1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT T1.NAME FROM SALESPERSON AS T1 JOIN ORDERS AS T2 ON T1.SALES_ID = T2.SALES_ID JOIN COMPANY AS T3 ON T2.COM_ID = T3.COM_ID WHERE T3.NAME = 'RED');

/*
Prediction Result:
*/