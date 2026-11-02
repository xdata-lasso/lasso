-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'RED'), (1, NULL, 'default1'), (-1, 'default2', 'RED'), (2, 'default2', 'default1'), (3, 'default1', 'default2'), (4, 'default2', 'default2'), (5, NULL, 'RED'), (6, 'RED', 'default2'), (7, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 1, NULL, 'default2'), (0, NULL, 1, NULL, 'RED'), (-1, 'default2', 0, 1, 'default2'), (2, 'default1', 0, 0, 'default2'), (3, 'default1', 1, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, -1, -1, 'default1', NULL), (-1, 1, -1, 'default2', 1), (1, 7, 2, NULL, 0), (2, 2, 0, 'default2', 1), (3, 0, NULL, 'default2', 0), (4, 6, 2, 'default2', NULL), (5, 3, 2, 'RED', NULL), (6, 7, 1, 'default1', 0), (7, 6, 2, 'default2', 1), (8, 4, 0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
(None,)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT O.SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID AND C.NAME = 'RED');

/*
Prediction Result:
*/