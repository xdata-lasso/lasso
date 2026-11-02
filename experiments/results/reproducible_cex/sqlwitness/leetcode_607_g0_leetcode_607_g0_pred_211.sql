-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'default2'), (-1, 'default1', 'RED'), (0, 'default2', 'RED'), (2, NULL, 'default1'), (3, 'default2', 'RED'), (4, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', NULL, 1, 'default1'), (1, 'default1', 0, 1, 'RED'), (0, 'default1', NULL, 0, 'default1'), (2, 'default2', 0, 0, 'default2'), (3, NULL, 1, 0, 'default1'), (4, 'default2', 0, NULL, 'RED'), (5, NULL, 0, NULL, 'default1'), (6, 'RED', NULL, 1, 'default2'), (7, 'RED', 0, 1, 'RED'), (8, NULL, 0, NULL, 'default2'), (9, 'default1', NULL, 0, 'default2'), (10, 'RED', 1, 0, 'RED'), (11, 'default1', 0, NULL, 'default1'), (12, 'default1', 1, 0, 'RED'), (13, 'default1', NULL, NULL, NULL), (14, 'RED', 1, NULL, NULL), (15, 'default2', NULL, 0, 'default1'), (16, 'default2', NULL, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 1, 8, 'default2', 0), (1, -1, 6, 'default1', 0), (0, 0, 7, NULL, 0), (2, 4, 1, 'default2', 1), (3, 0, -1, NULL, 0), (4, 4, 4, 'default2', 1), (5, -1, 0, NULL, 1), (6, -1, 7, 'default1', NULL), (7, -1, NULL, NULL, NULL), (8, 2, 10, 'default2', 1), (9, -1, 16, 'default1', 0), (10, 2, 1, NULL, 0), (11, 3, 3, NULL, 0), (12, 4, 0, 'default2', NULL), (13, 1, NULL, 'default2', 1), (14, NULL, 1, NULL, 1), (15, 3, 10, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('default1',)
('default2',)
(None,)
('default2',)
(None,)
('RED',)
('RED',)
('default1',)
('RED',)
('default1',)
('default1',)
('default1',)
('RED',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
*/