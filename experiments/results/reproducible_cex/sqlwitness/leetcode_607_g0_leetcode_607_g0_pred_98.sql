-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default2', 'default1'), (-1, 'default1', NULL), (1, NULL, 'default2'), (2, 'default2', 'default2'), (3, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, 0, 0, 'default2'), (1, 'default2', NULL, 0, 'default2'), (-1, NULL, 1, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 1, 1, 'RED', 1), (1, NULL, 0, 'default1', 1), (0, 2, -1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT S.NAME FROM SALESPERSON AS S LEFT JOIN ORDERS AS O2 ON S.SALES_ID = O2.SALES_ID WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
(None,)
('default2',)
*/