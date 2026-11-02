-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'default2'), (0, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', 0, 1, 'default1'), (1, 'default2', 1, 0, 'default1'), (0, 'default1', NULL, NULL, 'default2'), (2, 'default2', 1, 1, 'default1'), (3, 'default2', 0, NULL, 'default2'), (4, NULL, NULL, 0, 'default2'), (5, 'default2', 1, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, NULL, 4, 'default1', 1), (-1, 0, 1, NULL, NULL), (1, 0, NULL, 'default2', 0), (2, 0, 5, NULL, 1), (3, -1, 0, 'default2', 0), (4, NULL, 3, 'RED', 0), (5, NULL, 2, NULL, 1), (6, 0, 3, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT S.NAME FROM COMPANY AS C LEFT JOIN ORDERS AS O ON C.COM_ID = O.COM_ID AND C.NAME = 'RED' LEFT JOIN SALESPERSON AS S ON S.SALES_ID = O.SALES_ID WHERE NOT S.NAME IS NULL);

/*
Prediction Result:
('default1',)
('default1',)
*/