-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', NULL), (0, NULL, 'RED'), (1, 'default2', 'default2'), (2, 'RED', 'default1'), (3, 'RED', NULL), (4, 'RED', 'default1'), (5, 'default2', 'RED'), (6, 'default1', 'default2'), (7, 'RED', 'RED'), (8, 'default1', 'default2'), (9, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, NULL, 1, 'default1'), (-1, 'default1', NULL, 1, 'default1'), (1, NULL, 0, 1, 'default1'), (2, 'default2', 0, 0, 'default1'), (3, 'default1', NULL, NULL, 'default1'), (4, NULL, 1, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 3, NULL, 'RED', NULL), (1, NULL, 3, 'default1', 0), (0, 2, 4, NULL, NULL), (2, 0, 0, 'RED', 0), (3, 0, 3, 'default2', 1), (4, -1, 0, NULL, 0), (5, 7, NULL, 'default2', 1), (6, -1, 1, 'RED', 0), (7, NULL, 3, NULL, NULL), (8, 6, 3, 'RED', NULL), (9, 6, 0, 'default2', 0), (10, 4, 3, NULL, NULL), (11, 4, 3, 'default1', 1), (12, 3, 3, 'RED', NULL), (13, 6, 4, 'default2', 0), (14, -1, -1, 'RED', 0), (15, 0, NULL, 'default2', 1), (16, 0, 2, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT P.NAME FROM SALESPERSON AS P WHERE NOT P.SALES_ID IN (SELECT SALES_ID FROM ORDERS WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
*/