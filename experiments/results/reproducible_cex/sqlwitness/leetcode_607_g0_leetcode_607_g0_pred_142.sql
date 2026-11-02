-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'RED'), (0, 'RED', 'default2'), (1, 'default2', 'default1'), (2, 'default1', 'default1'), (3, 'default2', NULL), (4, NULL, 'default1'), (5, 'RED', 'default2'), (6, 'default1', 'default1'), (7, NULL, 'default2'), (8, 'RED', 'RED'), (9, 'default1', 'default1'), (10, NULL, 'RED'), (11, 'default2', 'default2'), (12, 'default1', NULL), (13, 'default1', 'default1'), (14, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, 1, 'default2'), (-1, 'default2', NULL, NULL, NULL), (1, 'default1', 0, NULL, 'default2'), (2, NULL, 0, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 6, NULL, NULL, 0), (-1, NULL, 1, NULL, 1), (1, NULL, 2, 'RED', NULL), (2, NULL, -1, 'default2', NULL), (3, 1, -1, 'default2', 1), (4, 3, -1, NULL, 0), (5, 5, NULL, 'default1', NULL), (6, -1, 0, 'default1', 0), (7, 8, 0, 'default1', 0), (8, 12, 2, NULL, NULL), (9, NULL, 1, 'RED', 1), (10, 4, 2, NULL, 1), (11, 1, 0, 'default2', NULL), (12, 2, 0, 'default1', NULL), (13, 4, NULL, NULL, 1), (14, 11, 2, 'RED', 1), (15, 9, NULL, 'default2', 1), (16, 6, NULL, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O LEFT JOIN COMPANY AS C ON C.COM_ID = O.COM_ID WHERE C.NAME IN ('RED'));

/*
Prediction Result:
*/