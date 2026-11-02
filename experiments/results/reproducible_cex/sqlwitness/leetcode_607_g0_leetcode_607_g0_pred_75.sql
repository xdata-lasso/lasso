-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default1'), (0, NULL, 'default1'), (-1, 'RED', 'default2'), (2, 'default2', 'RED'), (3, 'default2', NULL), (4, 'RED', 'default1'), (5, 'RED', NULL), (6, 'default2', 'default2'), (7, 'RED', NULL), (8, 'RED', 'default1'), (9, NULL, 'RED'), (10, 'default1', 'default1'), (11, 'default2', 'default2'), (12, NULL, 'RED'), (13, 'default1', NULL), (14, NULL, NULL), (15, NULL, NULL), (16, NULL, 'default1'), (17, 'RED', 'default1'), (18, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default1', NULL, NULL, NULL), (-1, 'default2', 1, NULL, 'RED'), (0, 'default1', NULL, NULL, 'default1'), (2, 'RED', NULL, NULL, 'default1'), (3, 'default2', 1, 1, NULL), (4, NULL, 0, NULL, 'default1'), (5, 'RED', 1, NULL, 'RED'), (6, NULL, NULL, 1, 'default1'), (7, 'RED', NULL, NULL, 'RED'), (8, NULL, 1, 1, NULL), (9, 'RED', 0, NULL, 'default2'), (10, 'RED', 1, 1, 'default2'), (11, NULL, 0, NULL, NULL), (12, 'default2', 0, NULL, 'default2'), (13, 'RED', 0, 1, 'RED'), (14, 'RED', NULL, 0, 'RED'), (15, 'RED', NULL, NULL, 'RED'), (16, NULL, 0, 0, 'default1'), (17, 'default2', 1, 0, 'RED'), (18, 'RED', NULL, NULL, 'default2'), (19, 'default2', 0, 0, 'default1'), (20, 'default2', NULL, NULL, NULL), (21, 'default1', 0, NULL, 'RED'), (22, 'default2', 0, NULL, NULL), (23, 'default2', 0, 0, 'RED'), (24, 'default2', 1, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 11, 12, 'default1', NULL), (0, 17, -1, 'default2', 0), (1, 13, 10, 'RED', 0), (2, 16, 20, 'RED', NULL), (3, 11, 5, 'RED', NULL), (4, 2, 8, 'default1', 0), (5, 7, NULL, NULL, NULL), (6, 7, 16, 'default2', 1), (7, 5, 8, 'default2', NULL), (8, 11, 16, 'RED', NULL), (9, 9, 18, 'default1', NULL), (10, 9, 16, 'default1', NULL), (11, 6, 18, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
('RED',)
('default2',)
(None,)
('RED',)
(None,)
('RED',)
('RED',)
('RED',)
(None,)
('default2',)
('RED',)
('RED',)
('RED',)
('default2',)
('RED',)
('default2',)
('default2',)
('default1',)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
WITH CTE AS (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE NAME = 'RED' GROUP BY SALES_ID) SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT (SALES_ID) FROM CTE);

/*
Prediction Result:
*/