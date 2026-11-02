-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'default2'), (-1, 'RED', 'default1'), (1, 'default1', 'default2'), (2, 'default1', 'default2'), (3, NULL, 'default2'), (4, NULL, 'RED'), (5, 'default1', 'default2'), (6, 'default2', 'default2'), (7, 'default2', 'default2'), (8, 'default1', 'default1'), (9, 'default2', NULL), (10, 'RED', 'default1'), (11, 'default2', 'RED'), (12, NULL, NULL), (13, NULL, 'default1'), (14, 'RED', NULL), (15, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 0, 0, 'default2'), (1, 'default2', NULL, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 4, 1, 'RED', NULL), (-1, 6, 0, NULL, NULL), (0, 10, NULL, 'default1', 1), (2, 7, NULL, 'RED', 1), (3, 4, 1, 'default1', NULL), (4, 2, NULL, 'default1', 1), (5, 9, 1, 'default1', NULL), (6, 10, 0, 'default2', 0), (7, 15, NULL, 'default2', NULL), (8, 4, 1, NULL, 1), (9, 14, NULL, 'default1', NULL), (10, 11, NULL, NULL, 0), (11, 14, 0, 'RED', NULL), (12, 5, 0, NULL, NULL), (13, 12, 0, 'default2', 0), (14, 12, 1, 'RED', 0), (15, 5, 1, 'RED', 1), (16, 8, 1, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT SP.NAME FROM SALESPERSON AS SP WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/