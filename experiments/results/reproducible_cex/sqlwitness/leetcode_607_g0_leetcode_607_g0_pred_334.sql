-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', 'default2'), (0, 'RED', 'default1'), (1, 'default1', 'default2'), (2, 'RED', 'default1'), (3, 'RED', 'default1'), (4, 'default2', 'default1'), (5, 'default2', 'default1'), (6, 'default1', 'default2'), (7, 'default1', 'default1'), (8, NULL, 'default2'), (9, NULL, 'default1'), (10, 'default2', 'default1'), (11, NULL, 'RED'), (12, NULL, 'RED'), (13, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, NULL, 'RED'), (-1, 'default2', NULL, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 4, NULL, NULL, 0), (1, 0, NULL, 'default1', NULL), (-1, 13, -1, 'default1', NULL), (2, 11, -1, NULL, NULL), (3, 5, NULL, 'default2', 1), (4, 2, NULL, NULL, 0), (5, 6, -1, 'RED', 0), (6, 10, 0, 'RED', NULL), (7, 4, 0, NULL, 1), (8, 3, -1, 'default2', 0), (9, NULL, -1, NULL, 1), (10, 2, -1, 'default1', NULL), (11, 10, NULL, 'default2', 0), (12, 1, NULL, NULL, NULL), (13, 2, -1, 'default1', 1), (14, 1, NULL, 'RED', NULL), (15, 12, 0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT SALESPERSON.NAME FROM SALESPERSON WHERE NOT SALESPERSON.SALES_ID IN (SELECT ORDERS.SALES_ID FROM ORDERS LEFT OUTER JOIN COMPANY ON COMPANY.COM_ID = ORDERS.COM_ID WHERE COMPANY.NAME = 'RED' GROUP BY (ORDERS.SALES_ID));

/*
Prediction Result:
*/