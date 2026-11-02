-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'default2'), (0, 'RED', NULL), (1, 'RED', NULL), (2, 'RED', 'default2'), (3, 'default2', NULL), (4, 'default1', 'default2'), (5, 'default1', 'default2'), (6, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 1, 0, 'default1'), (-1, 'default2', 0, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 1, -1, 'default2', NULL), (1, 5, 0, 'RED', 0), (-1, NULL, -1, 'default2', 0), (2, 0, NULL, 'RED', 1), (3, 5, -1, 'default1', NULL), (4, 3, -1, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT S1.NAME FROM SALESPERSON AS S1 WHERE NOT S1.SALES_ID IN (SELECT DISTINCT O2.SALES_ID FROM ORDERS AS O2 LEFT JOIN COMPANY AS C1 ON O2.COM_ID = C1.COM_ID WHERE C1.NAME = 'RED');

/*
Prediction Result:
*/