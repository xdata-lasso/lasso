-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, 'default1'), (0, NULL, 'default1'), (-1, 'RED', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 0, NULL, 'RED'), (1, NULL, NULL, 0, 'RED'), (-1, 'default1', 1, 0, NULL), (2, 'default1', 1, NULL, 'RED'), (3, 'default2', 1, NULL, 'default1'), (4, 'RED', NULL, NULL, 'default1'), (5, NULL, 0, 1, 'RED'), (6, 'default1', 0, NULL, 'default2'), (7, 'default2', NULL, NULL, NULL), (8, 'default1', NULL, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 0, 8, 'default1', 0), (0, 1, 2, NULL, NULL), (1, 0, NULL, 'default2', 0), (2, -1, 2, NULL, 0), (3, -1, 5, 'default1', 0), (4, NULL, 4, 'default1', 1), (5, -1, 7, NULL, 1), (6, NULL, -1, NULL, NULL), (7, NULL, 0, 'default1', 1), (8, 0, -1, 'RED', NULL), (9, 0, 8, 'default2', NULL), (10, -1, 3, NULL, NULL), (11, NULL, 0, 'default2', 1), (12, 1, 0, 'default1', 0), (13, -1, 0, 'default2', 0), (14, -1, 2, NULL, 1), (15, -1, 4, NULL, 0), (16, 1, 0, 'RED', 0), (17, NULL, 4, 'default1', NULL), (18, NULL, 3, 'default2', 1), (19, 1, 7, 'default2', 1), (20, 0, 5, 'RED', 1), (21, NULL, 6, NULL, 1), (22, -1, 3, 'default2', NULL), (23, NULL, 2, 'default1', 1), (24, 0, 6, 'default2', 0), (25, -1, NULL, NULL, 1), (26, -1, NULL, NULL, 1), (27, NULL, 4, 'default2', NULL), (28, NULL, 0, NULL, NULL), (29, NULL, 2, 'RED', 1), (30, 1, 6, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT T1.SALES_ID FROM ORDERS AS T1 JOIN COMPANY AS T2 ON T2.COM_ID = T1.COM_ID WHERE T2.NAME = 'RED');

/*
Prediction Result:
*/