-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, NULL, 'default2'), (1, NULL, 'RED'), (-1, 'default1', NULL), (2, 'RED', NULL), (3, 'default2', 'RED'), (4, 'default1', 'RED'), (5, 'default1', 'default1'), (6, 'default1', 'RED'), (7, 'RED', 'default2'), (8, 'RED', 'default2'), (9, NULL, 'default1'), (10, NULL, 'default2'), (11, 'default1', 'RED'), (12, 'default2', 'RED'), (13, 'default2', NULL), (14, 'default2', NULL), (15, NULL, 'default2'), (16, 'default1', 'default1'), (17, NULL, 'default1'), (18, 'default2', NULL), (19, NULL, 'default1'), (20, 'default2', 'RED'), (21, NULL, 'RED'), (22, 'RED', 'default1'), (23, NULL, 'default1'), (24, 'default1', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 1, 1, NULL), (0, 'default1', 0, 0, NULL), (1, 'RED', 0, 1, 'RED'), (2, NULL, NULL, 1, NULL), (3, 'default1', NULL, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 3, NULL, 'RED', NULL), (-1, 3, -1, 'RED', 1), (1, 8, NULL, 'default1', NULL), (2, 17, 3, 'default2', NULL), (3, 11, 3, NULL, 1), (4, 8, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
('RED',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON AS S1 WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS JOIN COMPANY AS C USING (COM_ID) WHERE C.NAME = 'RED');

/*
Prediction Result:
*/