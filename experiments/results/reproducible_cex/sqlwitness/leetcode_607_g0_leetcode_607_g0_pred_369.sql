-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'RED'), (-1, 'RED', 'RED'), (1, 'default2', NULL), (2, 'default1', 'default2'), (3, 'default2', NULL), (4, 'RED', 'default2'), (5, 'default2', 'default2'), (6, 'RED', NULL), (7, 'RED', 'default2'), (8, 'default1', NULL), (9, 'default2', 'default1'), (10, 'RED', 'RED'), (11, 'default2', NULL), (12, 'default1', 'default2'), (13, 'default1', 'RED'), (14, NULL, 'default2'), (15, 'RED', 'default1'), (16, 'default2', 'default1'), (17, 'RED', NULL), (18, NULL, 'RED'), (19, 'default2', 'default1'), (20, 'RED', 'default2'), (21, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 0, 1, NULL), (1, 'default1', 1, 1, NULL), (0, 'RED', 1, 0, NULL), (2, NULL, 1, 0, 'default1'), (3, 'default1', NULL, 1, 'RED'), (4, NULL, NULL, 0, NULL), (5, 'default2', 1, 1, 'default2'), (6, NULL, 1, NULL, 'default1'), (7, 'RED', 0, 0, NULL), (8, 'RED', 1, NULL, 'default2'), (9, 'RED', NULL, 1, 'RED'), (10, 'default2', 1, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 6, NULL, NULL, 1), (1, 21, 10, NULL, 0), (-1, 20, NULL, 'RED', 0), (2, 4, 0, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
(None,)
('default1',)
(None,)
('default2',)
(None,)
('RED',)
('RED',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS NATURAL JOIN COMPANY WHERE NAME = 'RED');

/*
Prediction Result:
*/