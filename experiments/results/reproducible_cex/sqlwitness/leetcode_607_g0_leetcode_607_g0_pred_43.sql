-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', NULL), (0, NULL, 'default1'), (1, 'default2', 'RED'), (2, 'default2', 'RED'), (3, 'RED', 'default2'), (4, 'default1', 'default1'), (5, 'default1', NULL), (6, 'RED', 'default1'), (7, NULL, 'RED'), (8, 'default2', NULL), (9, 'default2', NULL), (10, 'RED', 'RED'), (11, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 0, 1, 'RED'), (0, 'default1', 0, 1, 'default1'), (1, NULL, 0, 1, 'default2'), (2, 'default1', 1, NULL, 'default1'), (3, 'RED', 1, 1, 'default1'), (4, 'RED', 0, 0, 'default2'), (5, 'RED', 1, 0, 'default2'), (6, 'RED', NULL, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, -1, NULL, 'RED', NULL), (0, 5, 4, 'RED', 1), (-1, 3, 6, 'RED', NULL), (2, 3, 3, NULL, 1), (3, 8, 0, 'RED', 1), (4, 3, NULL, 'default2', NULL), (5, 7, NULL, 'default2', 0), (6, 4, 5, 'RED', NULL), (7, NULL, NULL, 'default2', 1), (8, 10, NULL, 'default2', 0), (9, NULL, -1, 'RED', 1), (10, 0, 0, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
(None,)
('default1',)
('RED',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/