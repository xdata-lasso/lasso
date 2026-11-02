-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', 'RED'), (0, NULL, 'default2'), (1, 'RED', 'default1'), (2, 'default1', 'default1'), (3, 'default2', 'RED'), (4, 'RED', 'default2'), (5, 'RED', 'default2'), (6, NULL, 'RED'), (7, 'default1', NULL), (8, 'default1', NULL), (9, 'default1', 'default1'), (10, NULL, 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default2', NULL, 1, NULL), (1, 'default1', 1, 0, 'default1'), (-1, NULL, 1, NULL, 'RED'), (2, 'RED', 1, 1, 'RED'), (3, 'default1', NULL, 0, 'RED'), (4, 'default1', NULL, NULL, 'default2'), (5, 'RED', NULL, NULL, 'default2'), (6, 'default1', 0, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, NULL, 'RED', NULL), (-1, 10, -1, 'RED', 1), (0, 2, 5, 'default2', 0), (2, 4, 3, 'RED', NULL), (3, 4, 2, 'default1', NULL), (4, NULL, 1, 'default2', NULL), (5, 10, 2, 'RED', 0), (6, 3, -1, NULL, NULL), (7, 7, 4, 'default2', NULL), (8, 4, 3, 'default1', 1), (9, 1, 3, 'RED', 1), (10, 2, 6, 'RED', 1), (11, 7, 4, 'default2', 1), (12, 3, 3, 'RED', 0), (13, 4, -1, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('default1',)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM COMPANY INNER JOIN ORDERS ON COMPANY.COM_ID = ORDERS.COM_ID AND NAME = 'RED');

/*
Prediction Result:
*/