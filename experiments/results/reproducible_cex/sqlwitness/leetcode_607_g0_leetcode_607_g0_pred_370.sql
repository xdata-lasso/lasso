-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, NULL), (0, NULL, 'RED'), (-1, NULL, 'default1'), (2, 'RED', 'default1'), (3, 'default2', NULL), (4, 'RED', 'RED'), (5, NULL, 'default1'), (6, 'default2', 'default1'), (7, NULL, 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 1, 0, NULL), (1, NULL, 0, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, NULL, 1, 'default2', 0), (0, 1, 1, 'default1', 1), (-1, -1, 1, NULL, 1), (2, 4, NULL, 'default1', NULL), (3, 4, NULL, 'default1', 0), (4, 7, NULL, 'default1', 1), (5, 0, NULL, 'default1', NULL), (6, 4, NULL, 'default2', 1), (7, 6, NULL, NULL, 1), (8, NULL, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT E1.NAME AS NAME FROM SALESPERSON AS E1 WHERE NOT E1.SALES_ID IN (SELECT E2.SALES_ID FROM ORDERS AS E2 LEFT JOIN COMPANY AS E3 ON E2.COM_ID = E3.COM_ID WHERE E3.NAME = 'RED');

/*
Prediction Result:
*/