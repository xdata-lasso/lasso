-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'default2'), (1, 'RED', NULL), (0, 'RED', 'RED'), (2, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, 0, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, NULL, 'default2', 0), (-1, 1, NULL, 'default2', 0), (0, 1, NULL, 'default2', NULL), (2, 2, 0, 'RED', NULL), (3, NULL, NULL, 'RED', 0), (4, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT T2.SALES_ID FROM ORDERS AS T2 LEFT JOIN COMPANY AS T3 ON T2.COM_ID = T3.COM_ID WHERE T3.NAME = 'RED');

/*
Prediction Result:
*/