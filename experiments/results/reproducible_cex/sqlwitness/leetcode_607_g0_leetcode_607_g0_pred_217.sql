-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'default1'), (-1, 'default2', 'default2'), (1, 'default1', 'RED'), (2, 'RED', 'default1'), (3, 'default2', NULL), (4, 'default1', 'RED'), (5, 'default1', 'default1'), (6, 'default1', 'default1'), (7, 'default1', 'default2'), (8, 'default1', NULL), (9, 'RED', NULL), (10, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, NULL, 1, 0, 'RED'), (-1, 'RED', 1, 1, NULL), (1, 'RED', 0, NULL, 'default2'), (2, 'default1', 0, 0, 'default1'), (3, 'default1', 1, 1, 'default2'), (4, NULL, 0, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 4, 4, 'default1', 0), (1, 4, 3, NULL, 1), (0, 2, -1, NULL, NULL), (2, 0, 3, 'default2', 1), (3, 7, 2, 'default1', 0), (4, 8, 1, 'default1', NULL), (5, 9, 1, NULL, NULL), (6, 3, 1, NULL, 0), (7, 5, 1, NULL, 0), (8, 4, 4, NULL, NULL), (9, 8, 1, 'default1', 0), (10, -1, 0, 'default1', 0), (11, 5, 3, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT S.NAME FROM ORDERS AS O LEFT JOIN COMPANY AS C ON C.COM_ID = O.COM_ID LEFT JOIN SALESPERSON AS S ON S.SALES_ID = O.SALES_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
('default1',)
('default1',)
*/