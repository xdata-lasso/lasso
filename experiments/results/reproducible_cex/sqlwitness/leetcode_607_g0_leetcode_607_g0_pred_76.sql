-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default1'), (0, 'default1', NULL), (1, 'RED', NULL), (2, 'RED', 'default2'), (3, 'default1', 'RED'), (4, 'default1', NULL), (5, NULL, NULL), (6, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 0, NULL, NULL), (0, 'default1', NULL, 0, NULL), (-1, 'default2', 1, 0, 'RED'), (2, 'default1', NULL, 0, NULL), (3, 'default2', 1, 0, 'default2'), (4, 'RED', 1, 0, NULL), (5, 'default1', 0, 0, NULL), (6, 'default2', 0, NULL, 'RED'), (7, 'default2', NULL, 0, NULL), (8, 'RED', NULL, 0, 'RED'), (9, 'default2', 0, 1, 'RED'), (10, NULL, NULL, NULL, 'RED'), (11, 'default2', 1, NULL, 'default2'), (12, 'RED', 1, 1, NULL), (13, 'default1', NULL, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 5, 8, 'default1', 1), (1, 3, 7, 'RED', NULL), (-1, 1, -1, 'default2', NULL), (2, 1, NULL, 'default2', NULL), (3, 5, 9, 'default2', 1), (4, 1, 5, 'default2', 1), (5, 2, NULL, 'RED', 0), (6, -1, 3, 'default1', NULL), (7, -1, 12, NULL, 0), (8, 4, 3, 'default1', 0), (9, -1, 1, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default2',)
('default1',)
('default2',)
('RED',)
('default2',)
('default2',)
('RED',)
('default2',)
(None,)
('default2',)
('RED',)
('default1',)
*/

-- Prediction Query
WITH RED_SALES AS (SELECT S1.NAME FROM SALESPERSON AS S1 JOIN ORDERS AS O ON S1.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED') SELECT S2.NAME FROM SALESPERSON AS S2 LEFT JOIN RED_SALES ON S2.NAME = RED_SALES.NAME WHERE RED_SALES.NAME IS NULL;

/*
Prediction Result:
('RED',)
('RED',)
(None,)
('RED',)
*/