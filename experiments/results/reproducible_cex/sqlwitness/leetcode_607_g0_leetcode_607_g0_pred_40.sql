-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', NULL), (-1, 'default1', 'default1'), (0, NULL, NULL), (2, 'default1', 'default1'), (3, 'RED', 'RED'), (4, 'default1', NULL), (5, 'RED', NULL), (6, 'RED', 'RED'), (7, 'default1', 'RED'), (8, 'default2', NULL), (9, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default1', NULL, NULL, 'RED'), (0, 'default1', NULL, 1, 'RED'), (-1, 'default2', 1, NULL, NULL), (2, 'RED', 1, NULL, 'RED'), (3, 'default2', 1, NULL, 'default2'), (4, NULL, 0, 1, 'RED'), (5, 'default2', 1, 0, 'RED'), (6, 'default1', 1, 1, 'RED'), (7, 'default2', 0, 0, NULL), (8, 'default1', NULL, 1, NULL), (9, 'default2', 0, NULL, 'RED'), (10, NULL, 0, 0, 'default1'), (11, 'default1', NULL, 1, NULL), (12, 'default1', 0, 1, NULL), (13, 'default2', 0, NULL, 'default2'), (14, 'default1', 1, 1, 'default2'), (15, 'default2', NULL, 1, 'default2'), (16, 'default2', 0, NULL, 'RED'), (17, 'default2', 0, 1, 'RED'), (18, 'RED', 1, 1, NULL), (19, 'default2', NULL, NULL, NULL), (20, 'default1', 0, 1, 'default1'), (21, 'default1', 1, 0, 'default2'), (22, NULL, 1, 0, 'default2'), (23, 'default2', 0, NULL, 'RED'), (24, NULL, 1, NULL, 'default1'), (25, 'default1', 0, 0, 'default1'), (26, 'default1', NULL, 0, 'default2'), (27, 'default1', 0, 1, NULL), (28, 'RED', 1, 0, NULL), (29, 'default1', NULL, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 1, 6, 'default1', 1), (-1, 6, 28, 'default1', 0), (1, 1, NULL, 'RED', NULL), (2, 3, 2, 'default1', NULL), (3, 8, 11, 'default1', 1), (4, NULL, 3, 'RED', 0), (5, 3, NULL, NULL, NULL), (6, 0, 18, 'RED', 0), (7, 8, 1, 'RED', 0), (8, NULL, 26, 'RED', 1), (9, 3, 6, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('default1',)
('default2',)
(None,)
('default2',)
('default2',)
('default1',)
('default2',)
(None,)
('default1',)
('default1',)
('default2',)
('default1',)
('default2',)
('default2',)
('default2',)
('RED',)
('default2',)
('default1',)
('default1',)
(None,)
('default2',)
(None,)
('default1',)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
*/