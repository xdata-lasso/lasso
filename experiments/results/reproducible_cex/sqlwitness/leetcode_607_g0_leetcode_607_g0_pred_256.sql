-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default2'), (1, 'RED', NULL), (0, NULL, 'default1'), (2, 'default2', 'RED'), (3, 'RED', 'default2'), (4, 'RED', 'default1'), (5, 'default2', 'RED'), (6, 'default1', 'default2'), (7, NULL, 'default2'), (8, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', 0, 1, 'default2'), (0, NULL, 1, 1, 'RED'), (1, NULL, 0, 0, NULL), (2, 'RED', 1, NULL, 'default2'), (3, 'default2', 1, 0, NULL), (4, 'default1', 0, 0, 'default1'), (5, 'RED', NULL, NULL, 'default1'), (6, 'RED', 1, 1, 'default1'), (7, NULL, NULL, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 0, 1, 'default1', 1), (-1, 4, 0, NULL, 1), (0, 1, 1, 'default2', 1), (2, 3, -1, 'default1', NULL), (3, 8, 0, NULL, 1), (4, 4, NULL, NULL, NULL), (5, 4, 4, 'default1', NULL), (6, NULL, -1, 'RED', 0), (7, 0, 7, 'default1', NULL), (8, 8, 1, NULL, NULL), (9, 2, 5, NULL, NULL), (10, 4, 3, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('RED',)
('RED',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM COMPANY AS C INNER JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE UPPER(C.NAME) = 'RED');

/*
Prediction Result:
*/