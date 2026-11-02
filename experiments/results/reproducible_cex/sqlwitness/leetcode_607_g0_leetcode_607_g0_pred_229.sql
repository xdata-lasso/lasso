-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', NULL), (-1, NULL, 'RED'), (0, NULL, 'default2'), (2, 'default2', 'RED'), (3, 'default2', NULL), (4, 'RED', 'default2'), (5, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 1, NULL, NULL), (-1, 'default2', 1, 1, 'default2'), (0, NULL, NULL, 1, 'default1'), (2, 'default1', 0, 0, 'RED'), (3, 'default2', 0, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, 1, 'default1', 0), (0, 0, 1, NULL, NULL), (-1, 4, 0, 'default2', 0), (2, -1, 2, 'RED', 1), (3, 5, 1, 'default2', 0), (4, 0, 1, 'default1', 0), (5, -1, -1, 'default2', 1), (6, -1, 2, 'default2', NULL), (7, NULL, 0, 'RED', 0), (8, 0, 2, 'default1', NULL), (9, NULL, -1, 'RED', NULL), (10, -1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT DISTINCT (A.NAME) FROM SALESPERSON AS A JOIN ORDERS AS O ON A.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/