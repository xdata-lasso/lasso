-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'RED'), (0, 'default2', NULL), (1, 'default1', 'default2'), (2, 'default1', 'RED'), (3, 'RED', NULL), (4, 'RED', 'default2'), (5, 'default2', NULL), (6, NULL, NULL), (7, 'default2', NULL), (8, NULL, 'default1'), (9, NULL, 'default1'), (10, NULL, 'default2'), (11, NULL, 'default1'), (12, 'default2', 'default1'), (13, 'default1', NULL), (14, 'default1', NULL), (15, NULL, 'RED'), (16, 'default1', 'default1'), (17, 'default1', 'default2'), (18, 'default2', 'RED'), (19, 'RED', 'default1'), (20, 'RED', NULL), (21, 'default2', 'RED'), (22, 'RED', 'default2'), (23, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, 1, 'default1'), (0, NULL, NULL, NULL, NULL), (1, 'default1', 1, 1, 'default1'), (2, NULL, 0, NULL, 'RED'), (3, 'default2', 1, 1, 'default1'), (4, NULL, NULL, NULL, NULL), (5, 'RED', 1, 0, 'RED'), (6, NULL, 0, NULL, 'RED'), (7, 'default2', 0, 0, 'RED'), (8, NULL, 1, NULL, 'default2'), (9, NULL, NULL, NULL, 'default2'), (10, NULL, 1, 0, NULL), (11, NULL, 1, 1, 'RED'), (12, 'default1', 0, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, -1, 6, NULL, NULL), (1, 6, 0, 'default1', 0), (-1, 6, -1, 'default2', 1), (2, 8, 8, NULL, 1), (3, 9, 9, 'default1', 1), (4, 18, 7, 'default2', 1), (5, 6, 2, 'default1', 1), (6, -1, 7, 'RED', 1), (7, 19, NULL, NULL, 0), (8, 3, 3, NULL, 1), (9, 5, 8, 'default2', NULL), (10, 1, 8, NULL, 0), (11, 8, 1, 'RED', NULL), (12, 9, -1, 'RED', NULL), (13, 20, -1, 'default2', 0), (14, 14, NULL, NULL, NULL), (15, 22, 3, NULL, 1), (16, 8, 10, NULL, 0), (17, 7, 4, 'default1', 0), (18, 6, NULL, 'default1', 1), (19, 9, 9, NULL, 1), (20, -1, 0, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
(None,)
(None,)
('RED',)
(None,)
('default2',)
(None,)
(None,)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME IN ('RED')));

/*
Prediction Result:
*/