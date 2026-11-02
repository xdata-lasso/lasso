-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default2'), (0, 'RED', 'default2'), (1, NULL, 'default2'), (2, NULL, 'default1'), (3, NULL, 'default2'), (4, 'RED', NULL), (5, NULL, NULL), (6, NULL, 'RED'), (7, NULL, 'default2'), (8, 'default1', 'default2'), (9, 'RED', NULL), (10, 'default2', NULL), (11, NULL, 'default1'), (12, 'default1', 'RED'), (13, 'RED', 'default1'), (14, 'RED', 'default2'), (15, 'RED', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 0, 0, NULL), (1, 'default1', NULL, 0, 'default2'), (-1, 'RED', 0, 0, NULL), (2, 'default1', 1, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, 0, NULL, 1), (-1, 13, NULL, 'default2', 0), (0, 10, 1, NULL, 0), (2, 8, 0, NULL, NULL), (3, 12, NULL, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('RED',)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID AND C.NAME = 'RED');

/*
Prediction Result:
*/