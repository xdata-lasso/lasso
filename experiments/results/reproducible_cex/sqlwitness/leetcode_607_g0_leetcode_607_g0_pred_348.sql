-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default2'), (0, 'default1', NULL), (-1, 'default1', 'default1'), (2, 'RED', 'default1'), (3, 'default1', NULL), (4, 'default1', 'default1'), (5, NULL, 'default1'), (6, 'default2', 'default1'), (7, 'default2', NULL), (8, 'RED', 'default1'), (9, NULL, 'RED'), (10, 'default1', 'default2'), (11, 'default1', 'default1'), (12, 'default2', 'default2'), (13, NULL, 'RED'), (14, 'RED', 'default1'), (15, 'default1', 'default2'), (16, NULL, 'default2'), (17, 'default2', 'default2'), (18, 'default1', NULL), (19, 'RED', 'default2'), (20, 'default1', 'default1'), (21, 'default1', 'default1'), (22, 'default1', 'RED'), (23, 'RED', 'default2'), (24, 'default1', 'default1'), (25, 'RED', 'default2'), (26, 'default2', 'default1'), (27, 'RED', 'default1'), (28, 'default2', 'RED'), (29, 'default1', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', NULL, NULL, 'default1'), (0, 'default1', 1, NULL, NULL), (1, 'default1', 1, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 14, 0, 'default1', NULL), (1, 17, -1, 'default1', 1), (0, 15, -1, 'default1', 0), (2, 11, -1, 'default1', 0), (3, 13, 0, 'RED', 0), (4, 7, 0, NULL, 1), (5, 9, -1, NULL, NULL), (6, -1, -1, 'default1', 1), (7, 1, NULL, 'RED', 1), (8, 27, NULL, 'default2', NULL), (9, 15, 1, 'default2', 0), (10, 16, 0, 'RED', NULL), (11, 0, NULL, 'RED', 0), (12, 24, 1, 'RED', 1), (13, 18, -1, NULL, 1), (14, 14, NULL, 'default1', 1), (15, 28, 1, 'RED', 0), (16, 23, -1, 'default2', NULL), (17, 1, -1, 'default2', NULL), (18, 13, -1, 'default1', NULL), (19, 3, 1, 'default1', 1), (20, 14, NULL, 'default2', 0), (21, 24, -1, 'default2', 1), (22, NULL, 1, 'default2', 0), (23, 17, -1, NULL, 0), (24, 25, NULL, 'default1', 1), (25, 19, -1, 'default2', NULL), (26, 17, NULL, 'default1', 1), (27, 22, NULL, 'RED', NULL), (28, 28, 0, 'default1', 0), (29, 4, NULL, 'RED', 1), (30, 17, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT DISTINCT O.SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/