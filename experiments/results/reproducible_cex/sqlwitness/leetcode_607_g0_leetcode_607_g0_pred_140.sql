-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', NULL), (1, 'RED', 'RED'), (-1, 'RED', 'RED'), (2, 'RED', 'default2'), (3, 'RED', 'default2'), (4, 'RED', 'RED'), (5, 'RED', 'RED'), (6, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', NULL, 0, 'default1'), (0, NULL, 1, 1, 'RED'), (-1, 'default1', 0, NULL, 'RED'), (2, 'default1', 0, NULL, 'RED'), (3, 'RED', 1, NULL, 'default2'), (4, 'default1', NULL, 0, 'default1'), (5, 'RED', 1, 0, NULL), (6, 'RED', NULL, 0, NULL), (7, 'default1', 1, 0, 'RED'), (8, 'RED', 0, 0, 'RED'), (9, 'default2', 0, 0, 'RED'), (10, 'default1', 0, 1, 'default1'), (11, NULL, NULL, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 3, 1, 'default2', 1), (1, 4, 6, NULL, 1), (0, 6, 0, 'default2', NULL), (2, 4, NULL, 'RED', 1), (3, 2, 5, 'RED', NULL), (4, 3, 3, NULL, NULL), (5, 1, 1, NULL, 0), (6, -1, 8, NULL, NULL), (7, -1, 7, 'default2', 0), (8, NULL, NULL, 'default1', NULL), (9, 3, 3, 'RED', 1), (10, NULL, 10, 'default1', 0), (11, 1, NULL, 'RED', NULL), (12, 1, 1, 'RED', 0), (13, 2, -1, NULL, 1), (14, 4, 7, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT DISTINCT O.SALES_ID FROM COMPANY AS C INNER JOIN ORDERS AS O ON C.COM_ID = O.COM_ID AND C.NAME = 'RED');

/*
Prediction Result:
*/