-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default1'), (1, 'RED', 'default2'), (0, 'default2', 'RED'), (2, 'default1', 'default1'), (3, 'default2', 'default2'), (4, 'default1', 'default1'), (5, 'RED', 'default2'), (6, 'RED', 'RED'), (7, 'default1', 'RED'), (8, NULL, 'RED'), (9, 'default2', 'RED'), (10, 'RED', 'RED'), (11, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 0, 1, NULL), (0, NULL, 0, 1, 'RED'), (-1, 'RED', 0, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 8, 1, 'default1', 1), (1, 4, 1, 'default2', 0), (-1, 5, NULL, 'default1', NULL), (2, 10, 1, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
*/

-- Prediction Query
WITH NEW AS (SELECT * FROM COMPANY WHERE NAME = 'RED') SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS AS O INNER JOIN NEW AS N ON N.COM_ID = O.COM_ID);

/*
Prediction Result:
*/