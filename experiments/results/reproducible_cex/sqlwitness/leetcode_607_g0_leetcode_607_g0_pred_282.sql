-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'default1'), (1, 'RED', NULL), (0, 'RED', 'RED'), (2, NULL, NULL), (3, 'default2', NULL), (4, 'default2', 'default2'), (5, 'RED', 'default1'), (6, 'default1', 'default1'), (7, NULL, 'default1'), (8, 'RED', 'RED'), (9, 'RED', 'default2'), (10, 'default2', 'default2'), (11, NULL, 'default1'), (12, 'default2', 'default2'), (13, 'default1', NULL), (14, NULL, 'default1'), (15, 'RED', 'default2'), (16, 'default1', 'default2'), (17, NULL, 'default2'), (18, NULL, 'default2'), (19, NULL, 'default2'), (20, 'RED', 'RED'), (21, 'default2', NULL), (22, 'RED', 'default2'), (23, NULL, 'RED'), (24, NULL, 'default2'), (25, 'default1', 'RED'), (26, 'RED', 'default1'), (27, 'default1', 'default2'), (28, NULL, 'RED'), (29, 'RED', 'default2'), (30, 'RED', NULL), (31, 'RED', 'RED'), (32, NULL, 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, 1, NULL), (0, 'RED', 0, 0, NULL), (1, 'RED', NULL, 1, 'default1'), (2, 'default2', 0, 0, 'default2'), (3, 'RED', 1, 1, 'default1'), (4, NULL, NULL, NULL, 'default2'), (5, 'default2', 0, 1, 'default1'), (6, 'default1', 1, 1, NULL), (7, 'RED', 1, 1, 'default2'), (8, 'RED', NULL, 0, NULL), (9, 'default2', NULL, NULL, 'default1'), (10, 'default1', NULL, NULL, 'RED'), (11, 'RED', 1, NULL, 'default1'), (12, 'RED', 1, NULL, NULL), (13, 'default2', 1, 1, NULL), (14, 'RED', NULL, NULL, 'default2'), (15, 'RED', 1, NULL, NULL), (16, NULL, NULL, NULL, 'default1'), (17, 'default1', NULL, 1, 'default1'), (18, 'RED', NULL, NULL, 'default2'), (19, NULL, 0, NULL, 'default1'), (20, NULL, 1, 0, 'RED'), (21, 'default1', 0, NULL, 'default1'), (22, 'RED', 1, NULL, NULL), (23, NULL, 1, NULL, NULL), (24, 'RED', 1, 1, 'default1'), (25, NULL, 1, 0, 'RED'), (26, 'RED', NULL, 0, 'default1'), (27, 'default2', NULL, 0, 'default2'), (28, 'default1', 0, 0, 'default1'), (29, 'default1', NULL, 1, 'default2'), (30, 'default1', 1, 0, NULL), (31, NULL, 1, 1, 'default1'), (32, 'RED', NULL, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 16, 4, 'default2', NULL), (-1, 31, 25, 'default1', NULL), (1, 1, 25, 'default2', 0), (2, 31, NULL, 'default2', 0), (3, 32, 28, 'RED', 1), (4, 2, NULL, 'RED', NULL), (5, 19, 12, 'default1', NULL), (6, 20, 2, 'RED', NULL), (7, 23, 21, 'RED', 0), (8, 27, 15, NULL, 1), (9, 6, 30, 'RED', NULL), (10, 32, 20, 'default1', 0), (11, 1, 18, 'default1', 0), (12, 8, 3, 'RED', 1), (13, 7, 14, 'RED', 1), (14, 17, 23, 'default2', 1), (15, 14, 12, 'RED', NULL), (16, 0, 4, 'default2', NULL), (17, 7, 11, 'default1', 1), (18, 5, 28, 'default2', 0), (19, 31, 20, NULL, 0), (20, 21, 30, 'default1', 0), (21, 19, 3, NULL, 1), (22, 21, 6, 'default2', NULL), (23, 16, 3, 'RED', 0), (24, -1, 13, 'default1', 1), (25, 23, 19, 'RED', 1), (26, 24, 14, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('RED',)
('RED',)
('default2',)
('default1',)
('RED',)
('RED',)
('default2',)
('default1',)
('RED',)
('RED',)
('default2',)
('RED',)
('RED',)
(None,)
('default1',)
(None,)
('default1',)
('RED',)
(None,)
('RED',)
('RED',)
('default2',)
('default1',)
('default1',)
(None,)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS AS O WHERE O.COM_ID IN (SELECT COM_ID FROM COMPANY AS C WHERE C.NAME = 'RED'));

/*
Prediction Result:
*/