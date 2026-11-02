-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', NULL), (0, 'default1', NULL), (-1, 'default1', 'default1'), (2, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', NULL, 0, 'RED'), (0, NULL, 0, 0, 'default2'), (1, 'RED', NULL, NULL, 'default2'), (2, NULL, 1, 1, NULL), (3, 'default1', 1, NULL, 'default2'), (4, 'default1', 0, NULL, 'RED'), (5, 'default2', 1, 0, 'default1'), (6, 'default2', 1, 0, 'default1'), (7, NULL, 1, 1, NULL), (8, NULL, NULL, NULL, 'default2'), (9, 'RED', NULL, NULL, 'RED'), (10, 'default1', 0, 0, 'default2'), (11, 'default2', NULL, 1, NULL), (12, 'default1', 0, 1, 'RED'), (13, NULL, NULL, 1, NULL), (14, 'default2', NULL, 0, 'RED'), (15, 'default2', 0, 1, 'default2'), (16, 'RED', 0, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, -1, 4, 'default2', 1), (1, -1, 10, 'default1', 0), (-1, 2, 7, NULL, NULL), (2, -1, 16, 'RED', NULL), (3, 1, 9, 'default1', 0), (4, 1, 3, 'RED', NULL), (5, 2, 14, 'default1', 1), (6, -1, 7, NULL, 1), (7, NULL, 13, 'RED', 0), (8, -1, 1, 'default1', NULL), (9, -1, 12, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
('RED',)
(None,)
('default1',)
('default2',)
('default2',)
(None,)
(None,)
('default1',)
('default2',)
('default1',)
(None,)
('default2',)
('default2',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON LEFT JOIN (SELECT SALESPERSON.NAME AS SALES_PERSON_NAME FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED') AS FILTER ON SALESPERSON.NAME = FILTER.SALES_PERSON_NAME WHERE FILTER.SALES_PERSON_NAME IS NULL;

/*
Prediction Result:
(None,)
(None,)
('default2',)
('default2',)
(None,)
(None,)
('default2',)
(None,)
('default2',)
('default2',)
*/