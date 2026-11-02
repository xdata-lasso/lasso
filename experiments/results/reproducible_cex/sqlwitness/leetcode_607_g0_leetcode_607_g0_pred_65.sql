-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', NULL), (1, 'default2', 'RED'), (0, 'RED', 'default1'), (2, 'RED', 'default2'), (3, 'RED', NULL), (4, NULL, NULL), (5, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', NULL, NULL, 'RED'), (0, 'default2', 1, 1, NULL), (-1, NULL, NULL, 1, 'RED'), (2, 'default1', 1, NULL, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 0, 0, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT T3.NAME FROM (SELECT T2.COM_ID, T1.NAME FROM SALESPERSON AS T1 JOIN ORDERS AS T2 ON T1.SALES_ID = T2.SALES_ID) AS T3 JOIN COMPANY AS T4 ON T3.COM_ID = T4.COM_ID WHERE T4.NAME = 'RED');

/*
Prediction Result:
('RED',)
('default1',)
*/