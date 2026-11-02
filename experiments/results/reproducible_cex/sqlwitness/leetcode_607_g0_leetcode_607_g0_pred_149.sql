-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'RED'), (-1, 'default2', NULL), (0, NULL, 'default2'), (2, 'RED', 'default1'), (3, 'default1', NULL), (4, 'default2', 'default1'), (5, 'default2', 'default1'), (6, 'RED', 'RED'), (7, 'RED', 'RED'), (8, NULL, 'default1'), (9, 'default2', NULL), (10, 'RED', NULL), (11, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', NULL, 0, 'default2'), (1, NULL, 1, 1, 'default2'), (0, NULL, 1, 0, 'default2'), (2, NULL, 0, 0, NULL), (3, NULL, 1, 1, NULL), (4, 'default2', 1, 1, 'default1'), (5, 'default2', NULL, 1, 'default1'), (6, 'default2', NULL, 0, 'RED'), (7, NULL, NULL, 0, NULL), (8, 'default1', 1, 0, 'default1'), (9, NULL, 1, 1, 'default1'), (10, 'default1', 0, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 2, 9, NULL, 1), (1, 4, 2, 'default1', 0), (0, -1, -1, 'default2', NULL), (2, 8, 2, 'default2', 1), (3, 6, -1, 'default2', 0), (4, 4, 4, NULL, 0), (5, 5, -1, NULL, NULL), (6, 3, 2, 'default1', 0), (7, 0, 1, 'default1', NULL), (8, 9, 4, 'default1', NULL), (9, 1, 3, NULL, 1), (10, 7, -1, 'default1', 1), (11, 7, NULL, 'RED', 0), (12, 1, 9, 'RED', 1), (13, -1, 0, 'RED', NULL), (14, 5, -1, NULL, 0), (15, 0, -1, 'default1', 1), (16, 11, -1, 'RED', NULL), (17, 7, NULL, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
('default2',)
('default2',)
('default2',)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT SP.NAME FROM SALESPERSON AS SP WHERE NOT SP.SALES_ID IN (SELECT DISTINCT (O.SALES_ID) FROM ORDERS AS O LEFT JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/