-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', NULL), (1, NULL, 'RED'), (-1, 'RED', 'default2'), (2, NULL, 'default1'), (3, 'RED', 'default2'), (4, 'RED', 'default1'), (5, 'default1', 'default2'), (6, 'RED', 'default1'), (7, 'RED', 'default2'), (8, 'RED', 'default1'), (9, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 1, 1, 'RED'), (-1, 'RED', 1, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 8, 0, 'default1', NULL), (1, 2, -1, 'default2', 1), (-1, 8, 0, 'RED', NULL), (2, 6, 0, 'default1', 1), (3, 3, 0, NULL, 0), (4, 2, NULL, NULL, 1), (5, NULL, NULL, NULL, 0), (6, NULL, 0, 'default2', 1), (7, 7, NULL, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT DISTINCT (O.SALES_ID) FROM ORDERS AS O CROSS JOIN COMPANY AS C WHERE C.NAME = 'RED' AND O.COM_ID = C.COM_ID);

/*
Prediction Result:
*/