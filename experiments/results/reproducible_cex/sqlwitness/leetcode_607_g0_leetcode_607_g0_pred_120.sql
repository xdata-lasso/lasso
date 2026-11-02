-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', 'default1'), (0, 'RED', 'RED'), (1, 'default1', 'default1'), (2, NULL, 'default1'), (3, 'default1', 'default2'), (4, 'default2', 'default1'), (5, NULL, 'RED'), (6, 'default2', 'default1'), (7, 'default1', 'RED'), (8, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', NULL, 0, 'default2'), (0, 'default2', 0, NULL, 'RED'), (1, NULL, NULL, NULL, NULL), (2, 'default1', 0, NULL, 'RED'), (3, 'default2', 0, NULL, 'RED'), (4, NULL, 1, 1, 'RED'), (5, 'RED', NULL, 0, NULL), (6, 'default1', 0, 1, 'RED'), (7, 'RED', NULL, 1, 'default1'), (8, 'default1', 1, 0, 'RED'), (9, 'default2', 1, NULL, NULL), (10, 'default1', 1, 1, 'default1'), (11, 'default1', NULL, 1, NULL), (12, 'default1', NULL, 1, 'RED'), (13, 'default1', 1, NULL, 'default2'), (14, NULL, 0, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 4, 8, 'RED', NULL), (-1, 1, 10, 'RED', 0), (0, 8, 7, 'default2', 0), (2, 8, 8, 'default1', 0), (3, 7, 14, NULL, 0), (4, 7, 13, 'default1', 0), (5, NULL, 1, 'default2', NULL), (6, 6, -1, 'default1', 1), (7, 8, 5, 'RED', 0), (8, 5, 8, NULL, 0), (9, 0, 12, 'RED', 1), (10, 7, 8, 'RED', NULL), (11, 3, NULL, NULL, 0), (12, NULL, 0, NULL, 0), (13, 0, NULL, NULL, 0), (14, 0, 4, 'default2', 1), (15, 0, 12, 'RED', 0), (16, 1, 5, 'default1', NULL), (17, 8, 11, 'default2', 0), (18, 0, 3, 'default1', NULL), (19, 4, 4, 'default2', NULL), (20, 4, 13, 'default2', NULL), (21, 5, 8, NULL, 1), (22, NULL, 6, NULL, 0), (23, -1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
(None,)
('default1',)
('RED',)
('default1',)
('RED',)
('default1',)
('default2',)
('default1',)
('default1',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/