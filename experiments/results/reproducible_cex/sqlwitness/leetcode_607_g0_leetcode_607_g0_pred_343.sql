-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, 'default1'), (0, 'default2', 'default1'), (-1, NULL, NULL), (2, 'RED', NULL), (3, NULL, 'default2'), (4, NULL, 'RED'), (5, NULL, NULL), (6, 'default2', 'RED'), (7, 'default1', 'RED'), (8, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 1, NULL, 'default2'), (-1, NULL, 0, 1, 'RED'), (1, 'default1', 1, 0, NULL), (2, 'default2', NULL, 0, 'default2'), (3, 'RED', 0, 1, 'RED'), (4, 'default2', 0, NULL, 'default1'), (5, NULL, 0, 0, 'default1'), (6, NULL, 1, 0, 'default2'), (7, NULL, 1, NULL, NULL), (8, NULL, NULL, NULL, 'default2'), (9, 'default2', 0, 1, 'default2'), (10, 'RED', 0, NULL, 'RED'), (11, NULL, 0, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 7, 0, 'default1', NULL), (0, -1, 3, 'default1', 1), (1, -1, 3, 'RED', 0), (2, 6, 8, 'RED', 0), (3, NULL, 10, 'default2', 1), (4, 8, NULL, 'default2', 0), (5, 7, 9, 'default1', 1), (6, -1, 9, NULL, NULL), (7, 7, 5, 'default1', 0), (8, 0, 10, 'default2', 0), (9, 7, 9, 'RED', NULL), (10, 1, 11, 'default1', 0), (11, 6, 4, 'default2', NULL), (12, 3, 3, NULL, NULL), (13, 6, 4, 'default2', NULL), (14, 7, 7, NULL, 1), (15, 4, 2, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('default1',)
('default2',)
('RED',)
('default2',)
(None,)
(None,)
(None,)
(None,)
('default2',)
('RED',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS AS O LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME IN ('RED'));

/*
Prediction Result:
*/