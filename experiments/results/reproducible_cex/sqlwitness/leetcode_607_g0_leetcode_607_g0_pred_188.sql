-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', 'RED'), (1, 'default2', 'default2'), (0, 'RED', 'default1'), (2, 'default1', 'default1'), (3, NULL, 'default1'), (4, 'default1', 'RED'), (5, 'default1', NULL), (6, 'RED', 'default1'), (7, 'RED', 'default1'), (8, 'default2', NULL), (9, 'RED', 'default2'), (10, 'default2', NULL), (11, 'RED', 'default2'), (12, 'default2', 'RED'), (13, 'default2', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 1, NULL, NULL), (-1, NULL, NULL, 1, 'default1'), (0, 'RED', NULL, 0, 'default2'), (2, 'RED', NULL, 1, 'RED'), (3, 'RED', 1, 0, NULL), (4, 'default1', 1, 1, NULL), (5, 'default1', 1, NULL, 'RED'), (6, 'default2', NULL, 0, 'default2'), (7, 'RED', NULL, 0, 'RED'), (8, 'RED', 1, 0, 'default1'), (9, 'default2', 1, NULL, NULL), (10, NULL, 0, 1, 'RED'), (11, NULL, 0, 1, 'default2'), (12, 'default2', NULL, NULL, 'RED'), (13, 'default1', NULL, 0, NULL), (14, 'default1', 0, 0, 'RED'), (15, NULL, 1, NULL, 'default1'), (16, 'default1', 1, NULL, 'RED'), (17, 'default1', 1, 0, 'RED'), (18, NULL, 1, 0, 'default1'), (19, NULL, 1, 0, NULL), (20, NULL, 1, NULL, 'RED'), (21, 'default2', NULL, NULL, 'default2'), (22, 'RED', 0, NULL, NULL), (23, 'default1', NULL, 0, 'RED'), (24, NULL, 1, 0, 'default2'), (25, NULL, 0, 0, NULL), (26, 'RED', NULL, NULL, 'default2'), (27, NULL, NULL, 1, 'default2'), (28, 'RED', 0, 1, 'RED'), (29, 'RED', 1, 0, 'default2'), (30, 'default2', 1, NULL, 'RED'), (31, 'default1', 0, 0, 'default1'), (32, 'default2', 1, NULL, 'default1'), (33, 'default2', 0, 0, 'RED'), (34, NULL, NULL, NULL, 'default1'), (35, NULL, 1, 0, 'default2'), (36, 'RED', NULL, 0, 'default1'), (37, 'default2', NULL, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, -1, NULL, 'default2', NULL), (1, 7, 5, 'RED', NULL), (-1, 7, 29, 'default1', 0), (2, 0, NULL, NULL, NULL), (3, 7, 14, 'RED', NULL), (4, 4, 5, 'default2', 0), (5, 12, 10, 'default2', 1), (6, 6, 32, NULL, 1), (7, 1, 11, 'default2', 1), (8, 5, -1, 'default1', 0), (9, 8, 35, 'RED', NULL), (10, 8, 11, 'default2', NULL), (11, 9, 11, 'default2', 0), (12, 7, 8, 'RED', 0), (13, 4, 26, 'default2', 1), (14, 3, 11, 'default2', NULL), (15, 5, 15, NULL, 1), (16, 11, 30, 'default1', NULL), (17, 6, 30, 'default1', 0), (18, 1, 0, 'default2', 1), (19, 7, 25, 'default2', 1), (20, 13, 21, 'default2', 0), (21, 2, 34, 'RED', NULL), (22, 1, 15, 'default1', 0), (23, 2, 13, 'default2', NULL), (24, 0, 32, 'default1', 0), (25, 5, 37, 'RED', 0), (26, 10, 18, 'default2', NULL), (27, 3, 0, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('RED',)
('RED',)
('RED',)
('default1',)
('default2',)
('RED',)
('default2',)
(None,)
('default2',)
('default1',)
(None,)
('default1',)
('default1',)
(None,)
(None,)
(None,)
('default2',)
('RED',)
('default1',)
(None,)
('RED',)
(None,)
('RED',)
('default1',)
('default2',)
(None,)
(None,)
('RED',)
('default2',)
*/

-- Prediction Query
SELECT SP.NAME FROM SALESPERSON AS SP WHERE NOT SP.SALES_ID IN (SELECT O.SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/