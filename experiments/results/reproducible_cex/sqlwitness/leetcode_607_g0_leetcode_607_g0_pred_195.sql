-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'RED'), (1, 'default1', 'default2'), (-1, 'default2', NULL), (2, 'RED', 'RED'), (3, 'RED', 'default1'), (4, NULL, 'RED'), (5, 'RED', 'default1'), (6, 'default2', NULL), (7, NULL, 'RED'), (8, 'RED', 'default2'), (9, NULL, NULL), (10, 'RED', 'default1'), (11, 'default1', 'RED'), (12, 'RED', NULL), (13, 'default2', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 0, 0, 'default2'), (0, 'RED', 1, 0, 'default1'), (-1, 'RED', 1, 0, 'RED'), (2, 'RED', NULL, 1, NULL), (3, 'default2', 0, NULL, 'RED'), (4, NULL, 1, 0, NULL), (5, 'RED', NULL, 0, 'default2'), (6, NULL, 0, NULL, NULL), (7, 'default2', 1, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 0, 1, 'default1', 1), (-1, 11, 2, 'default2', 0), (0, 8, 5, 'RED', NULL), (2, 5, 6, NULL, NULL), (3, 7, 4, NULL, NULL), (4, 12, 4, 'default1', 0), (5, 5, 0, 'default2', 0), (6, 6, 0, 'default1', 1), (7, 4, 0, 'default1', 0), (8, 4, 2, 'RED', NULL), (9, 8, 3, 'default2', NULL), (10, 7, 2, 'default1', 1), (11, 5, NULL, 'default1', NULL), (12, 10, 6, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
('RED',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT (SALES_ID) FROM ORDERS AS ORD INNER JOIN COMPANY AS CP ON ORD.COM_ID = CP.COM_ID AND CP.NAME = 'RED');

/*
Prediction Result:
*/