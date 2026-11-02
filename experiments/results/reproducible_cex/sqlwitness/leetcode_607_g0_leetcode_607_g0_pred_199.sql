-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default2'), (1, NULL, NULL), (0, 'RED', 'default2'), (2, 'default2', NULL), (3, 'RED', 'RED'), (4, NULL, NULL), (5, NULL, 'default1'), (6, NULL, 'RED'), (7, 'RED', NULL), (8, NULL, 'RED'), (9, 'default2', NULL), (10, NULL, NULL), (11, 'default1', NULL), (12, 'default2', 'default1'), (13, 'default1', 'default2'), (14, NULL, 'RED'), (15, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 0, 0, 'default2'), (-1, 'default2', 0, 0, NULL), (0, 'default1', 1, 1, 'RED'), (2, 'default2', 1, 0, NULL), (3, NULL, 0, 1, 'default1'), (4, NULL, 0, NULL, 'RED'), (5, 'default2', 0, 1, NULL), (6, 'RED', 0, 1, 'default2'), (7, NULL, NULL, 0, 'default2'), (8, NULL, 0, NULL, 'default1'), (9, 'default2', NULL, NULL, NULL), (10, 'default1', 0, 1, NULL), (11, 'RED', 1, 1, 'default2'), (12, 'default1', 1, NULL, 'RED'), (13, NULL, NULL, 1, NULL), (14, 'default2', 1, 0, 'default1'), (15, 'default2', 0, NULL, 'RED'), (16, NULL, 0, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 7, 16, NULL, 0), (1, 14, 4, 'default2', 0), (0, 0, 11, NULL, NULL), (2, 13, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('RED',)
('default2',)
(None,)
(None,)
('default2',)
('RED',)
(None,)
(None,)
('default2',)
('default1',)
('default1',)
(None,)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT SALESPERSON.NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT DISTINCT SALESPERSON.NAME FROM ORDERS INNER JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID INNER JOIN SALESPERSON ON SALESPERSON.SALES_ID = ORDERS.SALES_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/