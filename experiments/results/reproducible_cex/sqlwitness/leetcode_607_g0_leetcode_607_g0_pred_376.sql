-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', 'default1'), (0, 'RED', 'default1'), (-1, 'default1', NULL), (2, 'RED', 'default2'), (3, 'default1', 'default2'), (4, NULL, 'default1'), (5, 'default1', 'default1'), (6, 'RED', 'RED'), (7, NULL, NULL), (8, 'default1', 'RED'), (9, 'default2', 'default2'), (10, NULL, 'default1'), (11, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (2, 'default2', NULL, 1, 'default1'), (0, 'default1', 2, 1, 'default2'), (-1, 'RED', NULL, 0, 'RED'), (1, 'default1', 0, 1, 'default1'), (3, NULL, NULL, 0, 'default2'), (4, 'default2', NULL, NULL, 'RED'), (5, NULL, 0, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, 2, -1, 'default2', 1), (0, 5, 3, 'default2', 1), (-1, 7, 5, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
(None,)
('default2',)
(None,)
*/

-- Prediction Query
WITH TRADED_WITH_RED AS (SELECT DISTINCT (SALES_ID), 1 AS RED_FLAG FROM ORDERS WHERE COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')) SELECT SALESPERSON.NAME FROM SALESPERSON LEFT JOIN TRADED_WITH_RED ON SALESPERSON.SALES_ID = TRADED_WITH_RED.SALES_ID WHERE TRADED_WITH_RED.RED_FLAG IS NULL;

/*
Prediction Result:
('RED',)
('default1',)
('default1',)
('default2',)
(None,)
('default2',)
(None,)
*/