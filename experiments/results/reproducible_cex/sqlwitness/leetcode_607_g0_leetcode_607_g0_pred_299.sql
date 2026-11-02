-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default2'), (1, 'default1', 'default2'), (0, 'RED', 'default1'), (2, 'RED', 'default1'), (3, 'default1', 'default2'), (4, 'RED', 'default2'), (5, NULL, 'default1'), (6, 'default2', 'default1'), (7, 'RED', 'RED'), (8, 'RED', 'default2'), (9, 'RED', 'default1'), (10, 'RED', 'default1'), (11, NULL, 'RED'), (12, 'RED', 'RED'), (13, 'RED', NULL), (14, 'default2', 'default2'), (15, NULL, NULL), (16, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 1, NULL, NULL), (-1, 'default2', NULL, 0, 'default1'), (0, 'default1', 1, 0, NULL), (2, 'RED', 0, NULL, 'default2'), (3, 'default1', 0, 1, 'default1'), (4, 'default2', 0, 0, 'RED'), (5, NULL, 0, 0, 'RED'), (6, 'default1', 0, 1, 'default1'), (7, 'RED', NULL, 0, 'default2'), (8, 'default1', 0, NULL, 'default1'), (9, NULL, NULL, 1, 'default2'), (10, NULL, 1, 1, 'default2'), (11, NULL, 1, 1, NULL), (12, 'default2', 0, 1, NULL), (13, NULL, 1, 1, 'default1'), (14, 'default1', 1, NULL, 'default2'), (15, 'default1', 0, 0, 'default1'), (16, 'default2', NULL, 0, 'default2'), (17, 'RED', NULL, 0, NULL), (18, NULL, 0, NULL, NULL), (19, 'default2', 1, 1, 'RED'), (20, NULL, NULL, 1, 'RED'), (21, NULL, NULL, NULL, 'RED'), (22, NULL, NULL, 1, NULL), (23, 'default2', NULL, 0, 'default2'), (24, 'default1', NULL, NULL, 'RED'), (25, NULL, 0, 0, 'default2'), (26, 'default2', NULL, 1, 'default2'), (27, 'default1', 0, NULL, 'default2'), (28, 'RED', 1, 1, NULL), (29, 'RED', NULL, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 10, 7, 'RED', 1), (-1, 0, 27, 'default1', 1), (0, 0, 18, 'RED', 1), (2, 13, 14, 'default2', 0), (3, NULL, 18, 'RED', 1), (4, 8, 1, 'default2', NULL), (5, 16, 20, 'default1', NULL), (6, NULL, 4, 'default1', 1), (7, 12, 11, 'RED', 0), (8, 8, 28, 'RED', NULL), (9, 3, 2, 'default2', NULL), (10, 4, 17, NULL, NULL), (11, 4, 25, NULL, 1), (12, -1, 3, 'default2', NULL), (13, 7, 4, 'default1', 0), (14, 3, 1, NULL, NULL), (15, 9, 27, 'default2', 0), (16, 12, 2, 'default2', 1), (17, 10, 1, NULL, NULL), (18, 4, 25, 'default2', 1), (19, 9, 17, 'default1', NULL), (20, 8, 7, 'default2', 1), (21, 4, NULL, NULL, 1), (22, 0, 28, 'default2', 0), (23, 7, 3, 'default2', 0), (24, 9, 17, 'default1', 0), (25, 12, 9, 'RED', 1), (26, 16, 8, 'default2', NULL), (27, 16, 7, NULL, 1), (28, 1, 18, 'RED', 1), (29, 14, 2, 'RED', 0), (30, 10, 6, 'default1', NULL), (31, 10, 0, 'RED', 0), (32, 9, 29, 'default1', 0), (33, NULL, 2, NULL, 1), (34, 0, 23, NULL, 1), (35, 7, 5, 'default1', 1), (36, 9, 19, NULL, NULL), (37, 3, 26, NULL, NULL), (38, NULL, 10, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
(None,)
('default2',)
(None,)
('default1',)
('default2',)
(None,)
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
WITH TEMP AS (SELECT O1.ORDER_ID, O1.SALES_ID, S1.NAME FROM ORDERS AS O1 LEFT JOIN COMPANY AS C1 ON O1.COM_ID = C1.COM_ID LEFT JOIN SALESPERSON AS S1 ON O1.SALES_ID = S1.SALES_ID WHERE C1.NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM TEMP);

/*
Prediction Result:
*/