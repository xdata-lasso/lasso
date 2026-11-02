-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'RED'), (0, NULL, 'RED'), (-1, 'default2', 'RED'), (2, 'RED', 'default1'), (3, 'default1', NULL), (4, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 1, NULL, 'default2'), (-1, 'default2', NULL, NULL, 'RED'), (0, 'default2', 0, NULL, 'RED'), (2, 'default2', 0, 1, 'RED'), (3, 'RED', 1, NULL, 'RED'), (4, NULL, NULL, 1, 'RED'), (5, 'RED', 0, NULL, 'RED'), (6, 'default1', NULL, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 4, 2, 'default1', 0), (0, -1, 6, 'default1', 0), (1, 3, 3, 'default2', 1), (2, 2, 1, 'default2', 1), (3, 4, 0, NULL, NULL), (4, 3, 1, 'default1', NULL), (5, 4, 0, 'default2', 0), (6, 0, 4, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('RED',)
(None,)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.NAME IN (SELECT S1.NAME FROM SALESPERSON AS S1 CROSS JOIN COMPANY AS C CROSS JOIN ORDERS AS O WHERE S1.SALES_ID = O.SALES_ID AND O.COM_ID = C.COM_ID AND C.NAME = 'RED');

/*
Prediction Result:
('default1',)
*/