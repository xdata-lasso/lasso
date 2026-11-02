-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, NULL), (0, 'default1', NULL), (-1, 'default2', 'default1'), (2, 'RED', 'default1'), (3, 'default2', 'default1'), (4, 'RED', 'RED'), (5, 'default2', 'RED'), (6, 'RED', 'default2'), (7, 'RED', NULL), (8, 'default2', 'RED'), (9, 'RED', 'default1'), (10, 'default2', 'default1'), (11, NULL, 'default1'), (12, 'RED', NULL), (13, 'default2', 'default2'), (14, 'default1', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', NULL, 0, 'default2'), (1, 'RED', 0, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 13, 1, 'default2', NULL), (0, 0, NULL, 'default2', 0), (-1, 7, NULL, 'RED', 1), (2, 14, 1, 'default1', 1), (3, 6, 1, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT SALES_ID FROM ORDERS LEFT JOIN COMPANY USING (COM_ID) WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/