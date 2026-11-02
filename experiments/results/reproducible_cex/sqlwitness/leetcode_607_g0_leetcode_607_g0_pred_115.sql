-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', NULL), (-1, 'default2', 'default1'), (1, 'default2', 'default1'), (2, 'default1', 'RED'), (3, 'default2', NULL), (4, NULL, 'default1'), (5, NULL, 'default1'), (6, 'default2', 'default2'), (7, 'default2', 'default2'), (8, 'default1', NULL), (9, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 0, 0, 'RED'), (1, NULL, 0, NULL, NULL), (-1, 'default1', NULL, 1, NULL), (2, 'default2', NULL, 1, 'default1'), (3, 'default2', NULL, 1, NULL), (4, 'RED', 1, 1, 'default1'), (5, NULL, NULL, 0, 'default2'), (6, 'default1', 0, 0, 'default1'), (7, 'RED', NULL, 0, 'default1'), (8, 'RED', 0, 1, 'RED'), (9, NULL, 0, NULL, 'default2'), (10, 'RED', NULL, 1, NULL), (11, 'default2', 0, NULL, 'RED'), (12, 'RED', 1, 0, 'RED'), (13, NULL, NULL, NULL, 'default2'), (14, 'default2', 1, NULL, 'RED'), (15, 'default1', NULL, 1, NULL), (16, 'default2', NULL, 1, 'default1'), (17, 'default1', 0, 0, 'default2'), (18, 'RED', NULL, 1, NULL), (19, 'RED', NULL, 1, 'default1'), (20, 'default1', NULL, 1, 'default1'), (21, NULL, 0, 0, 'default1'), (22, NULL, NULL, 1, 'default1'), (23, 'RED', 1, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 2, 15, 'default1', 1), (1, 1, 22, 'default1', 0), (-1, 9, 8, NULL, 0), (2, 1, 21, 'default1', NULL), (3, 9, 21, 'default1', NULL), (4, 9, 1, 'default1', NULL), (5, 8, 17, 'default2', 0), (6, 9, NULL, 'RED', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
('default2',)
('RED',)
(None,)
('default1',)
('RED',)
(None,)
('RED',)
('default2',)
('RED',)
(None,)
('default2',)
('default1',)
('default2',)
('default1',)
('RED',)
('RED',)
('default1',)
(None,)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT SALES_ID FROM ORDERS LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/