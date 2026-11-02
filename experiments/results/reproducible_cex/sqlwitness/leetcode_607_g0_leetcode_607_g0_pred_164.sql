-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', 'RED'), (1, NULL, 'default1'), (0, NULL, 'default2'), (2, 'RED', 'default2'), (3, 'RED', 'default1'), (4, 'default1', 'default1'), (5, NULL, 'default1'), (6, 'default1', 'default2'), (7, 'default2', 'default2'), (8, 'default1', NULL), (9, 'RED', 'default2'), (10, 'default2', 'default1'), (11, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, NULL, 1, 'default2'), (0, NULL, 0, NULL, 'default2'), (1, 'RED', 0, 0, 'default2'), (2, 'default2', 0, 1, NULL), (3, 'RED', NULL, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 11, 0, 'RED', 1), (1, 8, 1, 'RED', 0), (0, 11, NULL, NULL, NULL), (2, 6, 3, 'default1', 0), (3, 9, 1, 'default1', 0), (4, 3, 1, 'RED', 0), (5, 10, -1, 'default1', 0), (6, 0, NULL, NULL, NULL), (7, 2, 1, NULL, 1), (8, 9, NULL, 'default2', 0), (9, -1, 2, 'RED', 1), (10, 7, -1, 'RED', 0), (11, 8, NULL, 'RED', 0), (12, 11, 1, 'default2', NULL), (13, 2, 1, 'default2', NULL), (14, 2, 3, NULL, 1), (15, 2, 0, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
WITH NOTRED AS (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'), GETSALESID AS (SELECT DISTINCT O.SALES_ID FROM ORDERS AS O CROSS JOIN NOTRED AS N WHERE O.COM_ID = N.COM_ID) SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM GETSALESID);

/*
Prediction Result:
*/