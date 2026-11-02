-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'RED'), (0, 'default2', 'RED'), (-1, 'default2', 'default1'), (2, 'default1', NULL), (3, 'default2', 'default1'), (4, 'default2', 'RED'), (5, 'RED', NULL), (6, NULL, 'RED'), (7, 'default2', 'default1'), (8, 'RED', NULL), (9, 'default2', 'RED'), (10, 'RED', 'RED'), (11, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default1', 0, 1, 'default2'), (-1, 'RED', NULL, 0, 'RED'), (0, NULL, 0, 1, NULL), (2, 'default2', NULL, 0, NULL), (3, 'default2', 0, NULL, NULL), (4, 'RED', 0, 1, 'RED'), (5, NULL, NULL, 1, 'RED'), (6, 'RED', NULL, 1, 'RED'), (7, 'RED', 1, NULL, NULL), (8, 'default1', NULL, 1, 'default2'), (9, 'default2', 1, NULL, 'default1'), (10, NULL, NULL, 1, 'default2'), (11, 'RED', NULL, 0, 'RED'), (12, 'default2', 1, NULL, 'RED'), (13, 'default1', NULL, NULL, 'default1'), (14, 'default2', 1, NULL, NULL), (15, 'default2', 0, 0, 'default1'), (16, 'RED', 0, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 1, 5, 'default2', NULL), (1, 5, 2, NULL, 1), (-1, 4, -1, NULL, 1), (2, 8, NULL, NULL, 0), (3, 8, 2, NULL, 1), (4, 9, 7, 'RED', NULL), (5, -1, 11, NULL, 1), (6, 4, 3, 'default1', 0), (7, 4, 13, NULL, 0), (8, NULL, 14, 'default1', 1), (9, 0, 10, 'RED', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
('default1',)
('default2',)
('RED',)
(None,)
('RED',)
('RED',)
('default1',)
('default2',)
(None,)
('RED',)
('default2',)
('default1',)
('default2',)
('default2',)
('RED',)
*/

-- Prediction Query
SELECT P.NAME FROM SALESPERSON AS P WHERE NOT P.SALES_ID IN (SELECT DISTINCT (O.SALES_ID) FROM ORDERS AS O INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/