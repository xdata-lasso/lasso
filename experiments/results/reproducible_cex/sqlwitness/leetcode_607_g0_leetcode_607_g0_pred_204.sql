-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'RED'), (1, 'default1', NULL), (0, 'default2', NULL), (2, NULL, NULL), (3, NULL, NULL), (4, 'RED', NULL), (5, 'RED', 'RED'), (6, 'default2', 'RED'), (7, 'default2', NULL), (8, NULL, 'RED'), (9, 'default1', 'RED'), (10, 'default1', 'default2'), (11, 'default2', 'default1'), (12, NULL, 'default2'), (13, 'RED', 'default2'), (14, 'default1', 'RED'), (15, 'default2', 'default2'), (16, NULL, 'default1'), (17, NULL, NULL), (18, 'default2', 'RED'), (19, NULL, 'default2'), (20, 'default2', 'default2'), (21, 'default2', 'default1'), (22, 'default1', 'RED'), (23, NULL, NULL), (24, 'RED', NULL), (25, 'default1', 'default2'), (26, 'default1', 'RED'), (27, 'RED', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default2', 0, 1, NULL), (-1, 'default1', 1, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, NULL, 'default1', NULL), (-1, -1, NULL, NULL, NULL), (0, 17, NULL, 'RED', 0), (2, 19, -1, 'RED', 1), (3, 8, NULL, 'RED', NULL), (4, 10, 0, NULL, 0), (5, 15, -1, 'RED', 0), (6, 16, -1, 'default1', NULL), (7, 1, 0, NULL, 0), (8, 12, NULL, NULL, 1), (9, -1, -1, 'RED', 1), (10, 20, NULL, NULL, 0), (11, 17, 0, 'default1', 1), (12, 25, -1, 'RED', 0), (13, 8, -1, 'default2', 0), (14, 19, -1, NULL, 0), (15, 18, -1, 'RED', 1), (16, 26, -1, 'default1', 0), (17, 20, -1, NULL, NULL), (18, 20, -1, 'RED', 0), (19, 24, NULL, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT A.NAME FROM SALESPERSON AS A WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS AS B JOIN COMPANY AS C USING (COM_ID) WHERE C.NAME = 'RED');

/*
Prediction Result:
*/