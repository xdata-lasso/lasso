-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', NULL), (-1, 'default2', NULL), (0, 'RED', 'default1'), (2, 'RED', 'RED'), (3, 'RED', 'default1'), (4, NULL, NULL), (5, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, NULL, 1, NULL), (-1, NULL, NULL, 0, NULL), (0, 'default2', 0, 1, 'RED'), (2, 'default1', NULL, NULL, NULL), (3, 'RED', 1, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 2, 3, NULL, NULL), (-1, NULL, 3, 'default1', NULL), (0, 0, 0, NULL, NULL), (2, NULL, 1, 'RED', 0), (3, 5, 3, 'default2', NULL), (4, 4, -1, 'default1', NULL), (5, -1, 3, 'default1', NULL), (6, 2, -1, 'RED', 0), (7, 3, -1, 'default1', NULL), (8, 3, 0, NULL, 1), (9, 0, NULL, 'default1', NULL), (10, 5, 1, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT DISTINCT O.SALES_ID FROM ORDERS AS O WHERE O.COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
*/