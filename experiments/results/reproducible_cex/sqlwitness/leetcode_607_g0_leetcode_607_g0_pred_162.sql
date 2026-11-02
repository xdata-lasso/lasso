-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default1'), (-1, 'default1', 'default1'), (0, 'default2', 'default1'), (2, 'RED', 'default2'), (3, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, NULL, 'RED'), (0, 'RED', 0, NULL, 'RED'), (-1, 'default1', 1, 1, 'default2'), (2, 'default1', 1, 1, 'RED'), (3, 'RED', 0, NULL, 'RED'), (4, 'default2', 0, 1, 'RED'), (5, 'default1', NULL, 0, 'RED'), (6, 'default2', 0, 1, NULL), (7, 'default1', 0, 1, 'RED'), (8, 'RED', NULL, 1, NULL), (9, 'default1', NULL, 0, NULL), (10, 'default1', 1, 0, NULL), (11, 'default1', 0, NULL, 'default1'), (12, 'default1', 1, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 12, 'default2', 1), (-1, 3, 7, 'default2', NULL), (0, 1, 2, 'RED', 1), (2, 3, 12, 'RED', 1), (3, 1, 4, 'default2', NULL), (4, 3, 1, 'default1', NULL), (5, 0, -1, 'default1', NULL), (6, -1, 1, 'default2', NULL), (7, NULL, 10, NULL, NULL), (8, NULL, 7, 'RED', 1), (9, 3, 0, 'default1', 1), (10, 2, 6, NULL, NULL), (11, NULL, 11, NULL, NULL), (12, 0, 2, 'default2', 1), (13, -1, 12, NULL, 1), (14, NULL, 9, NULL, NULL), (15, 0, 5, 'default1', NULL), (16, 0, 5, 'default2', 0), (17, 1, 1, NULL, 0), (18, 0, 10, 'default1', 0), (19, 1, 2, 'default2', 0), (20, 1, 6, 'RED', 0), (21, 2, 6, NULL, 0), (22, -1, 8, NULL, NULL), (23, NULL, 5, 'RED', 0), (24, NULL, 9, 'RED', NULL);
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
('default1',)
('RED',)
('default1',)
('default1',)
('default1',)
*/

-- Prediction Query
WITH EXCLUDE AS (SELECT S.SALES_ID, S.NAME FROM SALESPERSON AS S JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED'), TOTAL AS (SELECT S.SALES_ID, S.NAME FROM SALESPERSON AS S) SELECT T.NAME FROM TOTAL AS T LEFT JOIN EXCLUDE AS E ON E.SALES_ID = T.SALES_ID WHERE E.NAME IS NULL;

/*
Prediction Result:
('default1',)
(None,)
('default1',)
('RED',)
('default2',)
('default1',)
('RED',)
('default1',)
('default1',)
('default1',)
*/