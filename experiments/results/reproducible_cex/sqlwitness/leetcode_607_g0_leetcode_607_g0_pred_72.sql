-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', NULL), (0, NULL, 'default2'), (1, NULL, NULL), (2, 'default2', 'RED'), (3, NULL, NULL), (4, 'default2', 'default2'), (5, 'default1', 'default2'), (6, 'default1', 'default1'), (7, NULL, 'RED'), (8, 'default2', 'default2'), (9, 'default1', 'default2'), (10, 'default1', 'default1'), (11, 'default1', 'default1'), (12, 'default2', NULL), (13, 'default1', 'default2'), (14, 'default1', 'RED'), (15, 'RED', NULL), (16, 'default2', NULL), (17, NULL, NULL), (18, NULL, 'RED'), (19, NULL, NULL), (20, NULL, 'RED'), (21, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, 1, 1, 'RED'), (-1, NULL, NULL, 0, 'RED'), (1, NULL, NULL, 1, NULL), (2, NULL, NULL, 1, 'RED'), (3, 'default2', 0, 0, 'default2'), (4, 'default1', 1, NULL, 'RED'), (5, NULL, 0, 0, 'default2'), (6, 'default2', 1, NULL, 'RED'), (7, NULL, NULL, NULL, 'default1'), (8, 'default1', NULL, 0, 'default2'), (9, 'RED', NULL, 1, 'RED'), (10, NULL, 0, 0, 'default2'), (11, NULL, 1, 1, 'default1'), (12, NULL, 0, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 10, 2, 'default1', 1), (0, 7, 0, NULL, 0), (1, 13, -1, 'RED', 0), (2, 14, 3, NULL, NULL), (3, 21, 8, 'RED', 0), (4, 15, NULL, 'RED', NULL), (5, 4, 3, 'default1', NULL), (6, 2, 12, NULL, 1), (7, NULL, 2, 'default1', 0), (8, 7, 11, NULL, 1), (9, 9, 2, 'default2', 0), (10, 8, 1, NULL, NULL), (11, 13, 8, NULL, NULL), (12, 16, 10, 'default1', NULL), (13, 3, 11, 'default1', NULL), (14, 1, 10, NULL, NULL), (15, 20, 9, 'RED', 1), (16, 11, 2, 'default2', 1), (17, 12, 4, 'default2', 0), (18, 1, NULL, 'default1', 0), (19, 0, 4, 'RED', NULL), (20, NULL, 4, 'RED', 0), (21, 4, 7, NULL, NULL), (22, 0, 9, 'RED', 1), (23, 13, 4, 'default2', NULL), (24, 20, 8, 'default1', 1), (25, 17, 8, NULL, 1), (26, 7, 1, 'default2', NULL), (27, 13, 5, NULL, 1), (28, 8, 0, 'RED', 0), (29, 15, 6, 'default1', 1), (30, 7, 7, 'default2', 0), (31, 4, 12, 'default1', 1), (32, 1, 5, 'default2', NULL), (33, 12, 9, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
('default2',)
('default1',)
(None,)
(None,)
('default1',)
('RED',)
(None,)
(None,)
(None,)
*/

-- Prediction Query
WITH A AS (SELECT ORDERS.SALES_ID, COMPANY.NAME FROM ORDERS JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID), B AS (SELECT DISTINCT SALES_ID FROM A WHERE NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT * FROM B);

/*
Prediction Result:
*/