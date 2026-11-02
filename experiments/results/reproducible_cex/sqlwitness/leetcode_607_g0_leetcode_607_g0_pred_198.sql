-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', NULL), (1, NULL, NULL), (0, NULL, 'RED'), (2, 'RED', 'default1'), (3, 'default1', 'RED'), (4, 'default1', 'default2'), (5, 'default1', NULL), (6, 'default1', NULL), (7, NULL, NULL), (8, NULL, 'default2'), (9, 'default1', 'default1'), (10, NULL, 'default2'), (11, 'RED', 'default2'), (12, 'RED', NULL), (13, 'default1', 'default1'), (14, NULL, 'default2'), (15, 'RED', 'default1'), (16, 'default1', 'RED'), (17, 'RED', 'default2'), (18, 'default1', 'RED'), (19, NULL, 'default1'), (20, 'default2', 'default2'), (21, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 1, NULL, 'RED'), (0, 'default2', 1, 1, 'RED'), (1, NULL, 0, 0, 'RED'), (2, 'default1', 0, 0, 'default2'), (3, 'RED', NULL, 1, 'default1'), (4, 'RED', NULL, 0, 'RED'), (5, 'RED', 0, NULL, 'default1'), (6, 'default1', 1, 0, NULL), (7, 'RED', 0, 1, 'RED'), (8, 'default2', 1, NULL, 'RED'), (9, 'default1', 0, 0, 'default1'), (10, NULL, 0, 1, 'default1'), (11, 'default2', 1, NULL, 'default2'), (12, NULL, NULL, 0, 'default1'), (13, 'default1', 1, NULL, 'default2'), (14, 'RED', 1, NULL, 'default1'), (15, 'default2', NULL, 1, 'default1'), (16, NULL, 0, 1, 'default2'), (17, 'RED', NULL, NULL, 'RED'), (18, 'RED', 0, 1, 'RED'), (19, NULL, 1, 0, 'default2'), (20, 'default1', 1, 0, 'RED'), (21, 'default2', 1, 1, NULL), (22, NULL, 1, 1, 'default2'), (23, 'default1', 0, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 15, 11, 'default1', NULL), (-1, 2, 14, NULL, NULL), (0, 0, 20, 'default2', NULL), (2, 3, 20, 'RED', 0), (3, 5, 18, 'default2', 1), (4, 21, 4, 'RED', 1), (5, 2, 5, 'RED', 1), (6, -1, NULL, 'default1', 1), (7, 15, 2, 'default1', 1), (8, 6, NULL, 'default1', 0), (9, 11, 20, 'default2', 1), (10, 5, 7, NULL, 1), (11, 13, 23, 'RED', 1), (12, 18, 2, 'RED', 1), (13, 18, 4, 'RED', NULL), (14, 14, 5, 'default2', 1), (15, 12, 5, 'RED', 1), (16, 12, 18, NULL, NULL), (17, 10, 15, 'default1', 1), (18, 5, 8, 'default2', NULL), (19, 10, 0, 'default1', 0), (20, -1, 18, 'RED', 1), (21, 3, 16, 'default2', 0), (22, 13, 15, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
(None,)
('RED',)
('RED',)
('default1',)
('RED',)
('default2',)
('default1',)
(None,)
(None,)
('default1',)
('default2',)
(None,)
('RED',)
(None,)
('default2',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED' GROUP BY O.SALES_ID) AS A);

/*
Prediction Result:
*/