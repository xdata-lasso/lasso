-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default2', 'default2'), (-1, 'default1', 'default2'), (1, 'default2', NULL), (2, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 1, 0, NULL), (0, 'RED', NULL, 1, 'default1'), (1, 'RED', 1, 0, 'default1'), (2, 'default2', NULL, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 2, 1, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('RED',)
('default2',)
*/

-- Prediction Query
WITH MPP AS (SELECT A.ORDER_ID, A.COM_ID, A.SALES_ID, B.NAME AS CNAME, C.NAME FROM ORDERS AS A JOIN COMPANY AS B ON A.COM_ID = B.COM_ID JOIN SALESPERSON AS C ON A.SALES_ID = C.SALES_ID), RN AS (SELECT NAME FROM MPP WHERE CNAME = 'RED') SELECT A.NAME FROM SALESPERSON AS A LEFT JOIN RN AS B ON A.NAME = B.NAME WHERE B.NAME IS NULL;

/*
Prediction Result:
('default2',)
('default2',)
*/